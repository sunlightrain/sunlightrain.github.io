param(
    [string]$CsvPath,
    [string]$vCenterFQDN,
    [string]$Username,
    [string]$Password
)

Write-Host "- - Setting Variables - -" -ForegroundColor Cyan

# =============================
# CSV 处理
# =============================
if (-not $CsvPath) {
    Write-Host "CSV File" -ForegroundColor Green
    $CsvPath = Read-Host -Prompt 'Enter the CSV File Path (i.e. D:\Files\MyVMs.csv)'
}

$DeployVMs = Import-Csv $CsvPath

# =============================
# vCenter 连接信息
# =============================
Write-Host "vCenter Server Connection and Credentials" -ForegroundColor Green

if (-not $vCenterFQDN) {
    $vCenterFQDN = Read-Host -Prompt 'Enter the vCenter Server FQDN (i.e. vcs01.lab.vmw)'
}

# 凭据处理逻辑（支持自动 + 手动）
if ($Username -and $Password) {
    # 自动模式（传明文）
    $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    $vCenterCreds = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
}
elseif ($Username) {
    # 只传用户名 → 弹窗输入密码
    $vCenterCreds = Get-Credential -UserName $Username -Message ("Enter password for "+$vCenterFQDN)
}
else {
    # 全交互
    $vCenterCreds = Get-Credential -Message ("Enter the Credentials for vCenter Server "+$vCenterFQDN)
}

# =============================
# 连接 vCenter
# =============================
Write-Host "Connecting to vCenter Server $vCenterFQDN" -ForegroundColor Green

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false | Out-Null
Connect-VIServer -Server $vCenterFQDN -Credential $vCenterCreds | Out-Null

# =============================
# VM 配置
# =============================
$DiskFormat = 'EagerZeroedThick'

<#
.SYNOPSIS
		Create Virtual Machines from a CSV file
.DESCRIPTION
		The scripts create and configure virtual machines based on a CSV file
                The VM is customized and powered on after deployment
            
.INSTRUCTIONS
            -> Create the CSV file based on the template provided and enter the required details
            -> Add new vDisks columns as required, the script will create vDisks accordingly
                Put zero where vDisks are not required
            -> Validate if all proper values are correct on the spreadsheet:
                - Specs: vCenter Customization Specifications Name 
                - OSType: Windows or Linux (Only for a condition in the script) 
                - Folder: If the folder name exists in 2 different locations, you might get errors. No spaces is also helpful.
                All the rest is self-explanatory
            -> Create the Customization Specifications on vCenter Server
                In Linux Specifications add the required DNS Servers in Network section
                There's no specific setting to be configured in the Specifications
                Recommend to create a new one specific for the PS Script, as some values will be overwritten everytime you run the script
            -> Change Disk Format in "#.VM Configuration Details" line 63, if required
            -> Save the spreadsheet as *.csv
            -> Run the script and enter the values as prompted
            -> The script also creates a transcript on users' Documents folder
.How to Use

		& ".\NewVM.ps1" `
  -CsvPath "C:\Documents\Archive\DeployVM\DeployVMs-oracledb11.csv" `
  -vCenterFQDN "vc-mgmt-a.corp.dev" `
  -Username "administrator@vsphere.local" `
  -Password "P@ssw0rd123!"

.AUTHOR
		Rafael Moura @ VirtuallyAnything.net - Dec/2021
.VERSION
		1.0 (Dec/2021)
        1.1 (Fev/2023)
                 Added command for the network card to start and stay connected at power on (Suggested/Commented by Gab)
		1.2 (Jun/2026)
                    Added support for passing credentials as parameters (chenxuewen)
#>
#.VM Configuration Details
$DiskFormat = 'EagerZeroedThick' # Options: Thin / Thick / EagerZeroedThick  
#.--------------------------------------------------------------------------------------------------.#
#. Don't change any value below .#
#.--------------------------------------------------------------------------------------------------.#
#.
Start-Transcript
Write-Host "::: Action Phase :::" -ForegroundColor Green
Write-Host "::: Virtual Machines Deployment in Progress :::" -ForegroundColor Green
Start-Sleep 2
#.
foreach($vm in $DeployVMs){
    Write-host "Deploying VM: " -ForegroundColor Green -NoNewline; Write-Host $vm.Name -ForegroundColor Cyan; Write-Host "IP Address: "-ForegroundColor Green -NoNewline; Write-Host $vm.IP -ForegroundColor Cyan; Write-Host "ESXi Host: "-ForegroundColor Green -NoNewline; Write-Host $vm.ESXi -ForegroundColor Cyan; Write-Host "Datastore: "-ForegroundColor Green -NoNewline; Write-Host $vm.Datastore -ForegroundColor Cyan; Write-host "VM Folder: " -ForegroundColor Green -NoNewline; Write-Host $vm.VMFolder -ForegroundColor Cyan; Write-Host "";
        If($vm.OSType -eq "Windows"){
        Get-OSCustomizationSpec $vm.Specs -Server $vCenterFQDN | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress $vm.IP -SubnetMask $vm.Subnet -DefaultGateway $vm.Gateway -Dns $vm.Dns1,$vm.Dns2 | Out-Null
        }
        else 
        {
        Get-OSCustomizationSpec $vm.Specs -Server $vCenterFQDN | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress $vm.IP -SubnetMask $vm.Subnet -DefaultGateway $vm.Gateway | Out-Null
        }
    Get-OSCustomizationSpec $vm.Specs -Server $vCenterFQDN | Set-OSCustomizationSpec -NamingScheme fixed -NamingPrefix $vm.Name | Out-Null
    New-VM -Name $vm.Name -VMhost $vm.ESXi -Template $vm.Template -OSCustomizationSpec $vm.Specs -confirm:$false -Datastore $vm.Datastore -Location $vm.VMFolder -Notes $vm.Notes | Out-Null
}
#.
foreach($vm in $DeployVMs){
    $VMDisks = ($DeployVMs | Get-Member -MemberType All) | Where-Object {$_.Name -match 'vDisk'}
    $VMCores = ($vm.vCPU/2)
    $VMPg = Get-VDPortgroup -Name $vm.vNetwork
    Write-host "Configuring VM: " -ForegroundColor Green -NoNewline; Write-Host $vm.Name -ForegroundColor Cyan; Write-Host "vCPU: "-ForegroundColor Green -NoNewline; Write-Host $vm.vCPU -ForegroundColor Cyan; Write-Host "vRAM: "-ForegroundColor Green -NoNewline; Write-Host $vm.vRAM -ForegroundColor Cyan; Write-Host "vNetwork: "-ForegroundColor Green -NoNewline; Write-Host $vm.vNetwork -ForegroundColor Cyan; Write-Host "";
    Get-VM $vm.Name | Set-VM -NumCPU $vm.vCPU -MemoryGB $vm.vRAM -CoresPerSocket $VMCores -Confirm:$false | Out-Null
        foreach($vdisk in $VMDisks){
            If($vm.($vdisk.Name) -ne '0'){
            Get-VM $vm.Name | New-HardDisk -CapacityGB $vm.($vdisk.Name) -Datastore $vm.Datastore -StorageFormat $DiskFormat | Out-Null
            }
        }
    Get-VM $vm.Name | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $VMPg -Confirm:$false | Out-Null

    Get-VM $vm.Name | Get-NetworkAdapter -Name "Network adapter 1" |
Set-NetworkAdapter -StartConnected:$true -Confirm:$false | Out-Null

    Get-VM $vm.Name | Start-VM | Out-Null
}
#.
Write-Host "::: Virtual Machines Deployment Complete :::" -ForegroundColor Green
Stop-Transcript