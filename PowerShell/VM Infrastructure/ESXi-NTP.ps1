# 连接到vCenter服务器
# prod
Connect-VIServer -Server "dlisnvcsa01.corp.hynix-dl.com" -Protocol "https" -User "administrator@vsphere.local" -Password "DL@infra12!@"
# dev
Connect-VIServer -Server "dldevvcsa01.corp.hynix-dl.com" -Protocol "https" -User "administrator@vsphere.local" -Password "DL@infra12!@"
# VCF9-dev
Connect-VIServer -Server "vc-mgmt-a.corp.hynix-dl.dev" -Protocol "https" -User "administrator@vsphere.local" -Password "P@ssw0rd123!@#$"
#✅ 忽略证书警告 ✅ 关闭 CEIP 提示
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false



# 查看每台 ESXi 的 NTP Server
Get-VMHost | Select Name,
@{N="NTP Server";E={(Get-VMHostNtpServer $_) -join ","}}

#  查看 NTP 服务状态
Get-VMHost | Get-VMHostService |
Where-Object {$_.Key -eq "ntpd"} |
Select VMHost,Running,Policy



# 生产可以使用的配置
$ntpServers = @(
  "10.68.121.7",
  "10.68.121.8"
)

Get-VMHost | Where-Object {$_.ConnectionState -eq "Connected"} |
ForEach-Object {

    Write-Host "Configuring NTP for $($_.Name)"

    # 1️⃣ 获取并清理旧 NTP Server（如果存在）
    $oldNtp = Get-VMHostNtpServer -VMHost $_ -ErrorAction SilentlyContinue
    if ($oldNtp) {
        Remove-VMHostNtpServer -VMHost $_ -NtpServer $oldNtp -Confirm:$false
        Write-Host "  Old NTP servers removed"
    }

    # 2️⃣ 添加新 NTP Server
    Add-VMHostNtpServer -VMHost $_ -NtpServer $ntpServers -Confirm:$false
    Write-Host "  New NTP servers added"

    # 3️⃣ 确保 NTP 服务启动并开机自启
    $ntpService = Get-VMHostService -VMHost $_ | Where-Object {$_.Key -eq "ntpd"}
    Set-VMHostService -HostService $ntpService -Policy On -Confirm:$false
    Start-VMHostService -HostService $ntpService -Confirm:$false
}