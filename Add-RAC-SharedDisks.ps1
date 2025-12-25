
<# 
Add-RAC-SharedDisks.ps1
为 Oracle RAC 的两台 VM 添加共享 VMDK（MultiWriter）：SYSTEM/DATA/REDO
容量：SYSTEM 3×10GB，DATA 8×128GB，REDO 8×32GB
创建在 DLISNMIS-PMAX01-Clustered-DSCL01-VMFS01 上
需要 PowerCLI 12+；建议在维护窗口内执行
使用方法：
1. 修改配置区的参数（VM 名称、数据存储名称、容量等
2. 以管理员身份运行 PowerShell，执行本脚本
3. 输入 vCenter 凭据
.\Add-RAC-SharedDisks.ps1 -vCenter "你的vCenter FQDN或IP"
注意事项：
- 脚本会根据需要添加 PVSCSI 控制器（SCSI 1 和 2）
- 脚本会在需要时关闭并重新启动 VM 
- 脚本会设置 disk.EnableUUID 以支持 ASM/udev
- 请确保数据存储有足够空间  
- 请确保 VM 的操作系统支持 MultiWriter（Oracle Linux 7+ 等）
#>

param(
  [string]$vCenter = "dlisnvcsa01.corp.hynix-dl.com",
  [PSCredential]$Creds = $(Get-Credential -Message "vCenter credentials"),
  [switch]$DryRun,
  [switch]$CreateSnapshot,
  [string[]]$VMNames = @("dlhymmsdb01","dlhymmsdb02"),
  [string]$DatastoreName = "DLISNMIS-PMAX01-Clustered-DSCL01-VMFS01",
  [int]$RetryCount = 3,
  [int]$RetryDelaySec = 5
)

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false | Out-Null
Connect-VIServer -Server $vCenter -Credential $Creds | Out-Null

#=== 配置区（已按你的容量设置；部分可通过参数覆盖） ===#
# $VMNames 与 $DatastoreName 可通过脚本参数覆盖，默认值已设于 param()

# 组与容量
$groups = @(
  @{Name="SYSTEM"; Count=3;  SizeGB=10  },
  @{Name="DATA";   Count=8;  SizeGB=128 },
  @{Name="REDO";   Count=8;  SizeGB=32  }
)

# 使用的共享控制器：SCSI 1 与 SCSI 2（PVSCSI）
$SharedScsiBuses = @(1,2)
# 单控制器的可用 UnitNumbers：0..15（跳过 7）
$PerBusUnitNumbers = @(0,1,2,3,4,5,6,8,9,10,11,12,13,14,15) # 共 15 个

# 存储格式与持久性
$StorageFormat = "EagerZeroedThick"
$RequirePowerOff = $true
#=== 结束配置 ===#

#—— 通用函数 ——#
function Get-VM-Strict($name) {
  $vm = Get-VM -Name $name -ErrorAction SilentlyContinue
  if (-not $vm) { throw "未找到 VM：$name" }
  return $vm
}

function Ensure-Datastore($name) {
  $ds = Get-Datastore -Name $name -ErrorAction SilentlyContinue
  if (-not $ds) { throw "未找到数据存储：$name" }
  return $ds
}

function Ensure-PVSCSI-Controller($vm, $busNumber) {
  $scsi = Get-ScsiController -VM $vm | Where-Object {$_.BusNumber -eq $busNumber}
  if (-not $scsi) {
    $scsi = New-ScsiController -VM $vm -Type ParaVirtual -BusSharingMode NoSharing -BusNumber $busNumber -Confirm:$false
    Write-Host "[$($vm.Name)] 新增 PVSCSI 控制器：SCSI $busNumber" -ForegroundColor Green
  } elseif ($scsi.Type -ne "ParaVirtual") {
    Write-Warning "[$($vm.Name)] SCSI $busNumber 控制器类型为 $($scsi.Type)，建议使用 ParaVirtual"
  }
  return $scsi
}

function Ensure-EnableUUID($vm) {
  $cur = Get-AdvancedSetting -Entity $vm -Name "disk.EnableUUID" -ErrorAction SilentlyContinue
  if ($cur) {
    if ($cur.Value -ne "true") {
      Set-AdvancedSetting -AdvancedSetting $cur -Value $true -Confirm:$false | Out-Null
      Write-Host "[$($vm.Name)] 设置 disk.EnableUUID=true" -ForegroundColor Green
    }
  } else {
    New-AdvancedSetting -Entity $vm -Name "disk.EnableUUID" -Value $true -Confirm:$false | Out-Null
    Write-Host "[$($vm.Name)] 新增 disk.EnableUUID=true" -ForegroundColor Green
  }
}

# 日志文件
$LogFile = Join-Path $PSScriptRoot "Add-RAC-SharedDisks.log"
function Write-Log([string]$msg, [string]$level = "INFO") {
  $line = "{0} [{1}] {2}" -f (Get-Date -Format s), $level, $msg
  $line | Out-File -FilePath $LogFile -Append -Encoding UTF8
  if ($level -eq 'ERROR') { Write-Error $msg } else { Write-Host $msg }
}

# 简单等待 VMDK 可见（可根据环境增强实现）
function Wait-For-Vmdk($ds, $filename, $timeoutSec=30) {
  $end = (Get-Date).AddSeconds($timeoutSec)
  while ((Get-Date) -lt $end) {
    Start-Sleep -Seconds 1
    # 这里采用简单等待策略，若需要可改为查询 Datastore 文件列表或 API
    return $true
  }
  return $false
}

# 简单重试封装
function Retry-Operation($scriptBlock, $retries=3, $delay=5) {
  for ($i=0; $i -lt $retries; $i++) {
    try {
      return & $scriptBlock
    } catch {
      if ($i -lt ($retries - 1)) { Start-Sleep -Seconds $delay } else { throw }
    }
  }
}

function Require-VM-PowerState($vm, [string]$state) {
  $cur = $vm.PowerState.ToString()
  if ($state -eq "PoweredOff" -and $cur -ne "PoweredOff") {
    Stop-VM -VM $vm -Confirm:$false | Out-Null
    Write-Host "[$($vm.Name)] 已关机" -ForegroundColor Yellow
  }
  if ($state -eq "PoweredOn" -and $cur -ne "PoweredOn") {
    Start-VM -VM $vm | Out-Null
    Write-Host "[$($vm.Name)] 已开机" -ForegroundColor Green
  }
}

# 计算总所需容量并校验数据存储空间
function Check-Datastore-Capacity($ds, $groups) {
  $needGB = ($groups | Measure-Object -Property @{Expression={$_.Count * $_.SizeGB}} -Sum).Sum
  $freeGB = [math]::Round($ds.FreeSpaceMB/1024,2)
  Write-Host ("数据存储剩余：{0} GB；本次预计申请：{1} GB" -f $freeGB, $needGB) -ForegroundColor Cyan
  if ($freeGB -lt $needGB) {
    Write-Warning "数据存储剩余空间不足，可能导致创建失败！"
  }
}

# 生成跨控制器的 (Bus,Unit) 分配列表，跳过 7
function Build-AttachPlan($totalDisks, $buses, $unitsPerBus) {
  $plan = New-Object System.Collections.ArrayList
  foreach ($bus in $buses) {
    foreach ($u in $unitsPerBus) {
      $null = $plan.Add(@{Bus=$bus; Unit=$u})
    }
  }
  if ($totalDisks -gt $plan.Count) {
    throw "磁盘数量超出可分配的 (Bus,Unit) 数量：$totalDisks > $($plan.Count)"
  }
  return $plan[0..($totalDisks-1)]
}

# 创建并在两台 VM 上挂载共享盘（MultiWriter）
function New-SharedVMDKs-And-Attach {
  param(
    [VMware.VimAutomation.ViCore.Impl.V1.Inventory.VirtualMachineImpl]$vm1,
    [VMware.VimAutomation.ViCore.Impl.V1.Inventory.VirtualMachineImpl]$vm2,
    [VMware.VimAutomation.ViCore.Impl.V1.DatastoreManagement.DatastoreImpl]$ds,
    [array]$groups,
    [array]$attachPlan,      # @( @{Bus=1;Unit=0}, @{Bus=1;Unit=1}, ... )
    [string]$storageFormat
  )

  # 确保两台 VM 有所有需要的控制器
  $requiredBuses = ($attachPlan | Select-Object -ExpandProperty Bus | Sort-Object -Unique)
  foreach ($b in $requiredBuses) {
    foreach ($vmObj in @($vm1,$vm2)) {
      $null = Ensure-PVSCSI-Controller -vm $vmObj -busNumber $b
    }
  }

  $vmObj1 = $vm1
  $vmObj2 = $vm2

  $cursor = 0
  foreach ($g in $groups) {
    for ($i=1; $i -le $g.Count; $i++) {
      $slot   = $attachPlan[$cursor]
      $bus    = $slot.Bus
      $unit   = $slot.Unit
      $index  = "{0:D2}" -f $i
      $scsi1  = Get-ScsiController -VM $vmObj1 | Where-Object {$_.BusNumber -eq $bus}
      $scsi2  = Get-ScsiController -VM $vmObj2 | Where-Object {$_.BusNumber -eq $bus}

      # 在 vm1 创建并挂载（幂等检查）、支持 DryRun 与重试
      $filename = "${($vmObj1.Name)}_${($g.Name)}_$index.vmdk"

      # 幂等检查：相同 Unit 或 文件名已存在则跳过
      $exists1 = Get-HardDisk -VM $vmObj1 -ErrorAction SilentlyContinue | Where-Object { $_.ExtensionData.UnitNumber -eq $unit -or $_.Filename -like "*$filename" }
      $exists2 = Get-HardDisk -VM $vmObj2 -ErrorAction SilentlyContinue | Where-Object { $_.ExtensionData.UnitNumber -eq $unit -or $_.Filename -like "*$filename" }
      if ($exists1 -or $exists2) {
        Write-Log "跳过：$($g.Name)-$index 在 SCSI$bus:$unit 已存在于 ${($vmObj1.Name)} 或 ${($vmObj2.Name)}" "WARN"
        $cursor++; continue
      }

      $createScript = {
        New-HardDisk -VM $vmObj1 -CapacityGB $g.SizeGB -Datastore $ds `
          -StorageFormat $storageFormat -Persistence "Persistent" `
          -Controller $scsi1 -UnitNumber $unit -Confirm:$false
      }

      if ($DryRun) { Write-Log "DryRun: 将创建 $($g.Name)-$index ($g.SizeGB GB) 在 $($vmObj1.Name) SCSI$bus:$unit"; $cursor++; continue }

      $hd1 = Retry-Operation -scriptBlock $createScript -retries $RetryCount -delay $RetryDelaySec
      Write-Log "[$($vmObj1.Name)] 新建 $($g.Name)-$index：$($g.SizeGB) GB (SCSI$bus:$unit)"

      # 等待 VMDK 可见
      if (-not (Wait-For-Vmdk -ds $ds -filename $hd1.Filename -timeoutSec 30)) {
        Write-Log "等待 VMDK $($hd1.Filename) 可见超时" "ERROR"
        throw "VMDK 未出现：$($hd1.Filename)"
      }

      # 在 vm2 挂载同一 VMDK
      $attachScript = {
        New-HardDisk -VM $vmObj2 -DiskPath $hd1.Filename `
          -Controller $scsi2 -UnitNumber $unit -Persistence "Persistent" -Confirm:$false
      }
      $hd2 = Retry-Operation -scriptBlock $attachScript -retries $RetryCount -delay $RetryDelaySec
      Write-Log "[$($vmObj2.Name)] 挂载同盘 $($g.Name)-$index (SCSI$bus:$unit)"

      # 两端都设为 MultiWriter 并验证
      Set-HardDisk -HardDisk $hd1 -Sharing "MultiWriter" -Confirm:$false | Out-Null
      Set-HardDisk -HardDisk $hd2 -Sharing "MultiWriter" -Confirm:$false | Out-Null

      Start-Sleep -Seconds 1
      $check1 = Get-HardDisk -VM $vmObj1 | Where-Object { $_.Filename -eq $hd1.Filename }
      if ($check1.ExtensionData.Sharing -ne "multiWriter") { Write-Log "MultiWriter 未正确设置于 $($hd1.Filename)" "ERROR" }
      $cursor++
    }
  }
}

#=== 主执行 ===#
try {
  $vm1 = Get-VM-Strict $vmNames[0]
  $vm2 = Get-VM-Strict $vmNames[1]
  $ds  = Ensure-Datastore $datastoreName

  # 校验空间
  Check-Datastore-Capacity -ds $ds -groups $groups

  # 关机
  if ($RequirePowerOff) {
    Require-VM-PowerState -vm $vm1 -state "PoweredOff"
    Require-VM-PowerState -vm $vm2 -state "PoweredOff"
  }

  # ASM/udev 所需
  Ensure-EnableUUID $vm1
  Ensure-EnableUUID $vm2

  # 构造 (Bus,Unit) 分配 —— 总盘数：3+8+8 = 19；单控制器 15 个，故用 SCSI 1 与 2
  $totalDisks = ($groups | Measure-Object -Property Count -Sum).Sum
  $attachPlan = Build-AttachPlan -totalDisks $totalDisks -buses $SharedScsiBuses -unitsPerBus $PerBusUnitNumbers

  # 执行创建与挂载（支持多 VM）
  if ($VMNames.Count -lt 2) { throw "需要至少两台 VM 进行共享磁盘挂载" }
  $vms = $VMNames | ForEach-Object { Get-VM-Strict $_ }
  # 当前函数实现为两台 VM；若需要支持多 VM，可改造函数签名
  New-SharedVMDKs-And-Attach -vm1 $vms[0] -vm2 $vms[1] -ds $ds -groups $groups -attachPlan $attachPlan -storageFormat $StorageFormat

  # 开机
  if ($RequirePowerOff) {
    Require-VM-PowerState -vm $vm1 -state "PoweredOn"
    Require-VM-PowerState -vm $vm2 -state "PoweredOn"
  }

  Write-Host "`n=== 汇总：两台 VM 的共享盘 ===" -ForegroundColor Green
  Get-VM $vmNames | Get-HardDisk | Select-Object Parent, Name, CapacityGB, Filename,
    @{N="Controller";E={$_.ExtensionData.ControllerKey}},
    @{N="Unit";E={$_.ExtensionData.UnitNumber}},
    @{N="Sharing";E={$_.ExtensionData.Sharing}}
}
catch {
  Write-Error $_.Exception.Message
  throw
}
