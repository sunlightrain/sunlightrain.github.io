#尽管出于安全标准，所有 ESXi 主机上的 SSH 都应禁用，但在很多情况下仍需保持其开放状态。故障排除就是其中之一。能够通过脚本在所有主机上启动和停止 SSH 服务，往往比手动操作更有帮助，尤其是在主机数量众多的情况下。
#在上一篇文章中，我探讨了如何创建一个安全的凭证文件。
#基于此，我们在创建启动 SSH 服务的脚本时会用到它。
#首先，我们需要导入凭证文件并获取凭证对象。
## 启动SSH服务
# Define the path to the credential file
$CredentialFilePath = "C:\vCenterCredentials.xml"

# Check if the credential file exists
if (Test-Path $CredentialFilePath) {
    # Import credentials from the file
    $Credential = Import-CliXml -Path $CredentialFilePath
    $Username = $Credential.UserName
    $Password = $Credential.GetNetworkCredential().Password

    # Connect to vCenter using the credentials
    try {
        Connect-VIServer -Server "<vCenter_Server_Name>" -User $Username -Password $Password
        Write-Host "Connected to vCenter successfully."
    } catch {
        Write-Host "Failed to connect to vCenter. Please check the credentials or network connectivity."
        exit
    }

    # Enable SSH on all ESXi hosts
    try {
        Get-VMHost | ForEach-Object {
            $hostServices = Get-VMHostService -VMHost $_
            $sshService = $hostServices | Where-Object { $_.Key -eq "TSM-SSH" }
            if ($sshService) {
                Start-VMHostService -HostService $sshService -Confirm:$false
                Write-Output "SSH enabled on host: $($_.Name)"
            } else {
                Write-Output "SSH service not found on host: $($_.Name)"
            }
        }
    } catch {
        Write-Host "An error occurred while enabling SSH on the hosts."
    }

    # Disconnect from vCenter
    Disconnect-VIServer -Confirm:$false
    Write-Host "Disconnected from vCenter."
} else {
    Write-Host "Credential file not found at $CredentialFilePath. Please create the file first."
}

## 停止SSH
# Define the path to the credential file
$CredentialFilePath = "C:\vCenterCredentials.xml"

# Check if the credential file exists
if (Test-Path $CredentialFilePath) {
    # Import credentials from the file
    $Credential = Import-CliXml -Path $CredentialFilePath
    $Username = $Credential.UserName
    $Password = $Credential.GetNetworkCredential().Password

    # Connect to vCenter using the credentials
    try {
        Connect-VIServer -Server "<vCenter_Server_Name>" -User $Username -Password $Password
        Write-Host "Connected to vCenter successfully."
    } catch {
        Write-Host "Failed to connect to vCenter. Please check the credentials or network connectivity."
        exit
    }

    # Stop SSH on all ESXi hosts
    try {
        Get-VMHost | ForEach-Object {
            $hostServices = Get-VMHostService -VMHost $_
            $sshService = $hostServices | Where-Object { $_.Key -eq "TSM-SSH" }
            if ($sshService) {
                Stop-VMHostService -HostService $sshService -Confirm:$false
                Write-Output "SSH stopped on host: $($_.Name)"
            } else {
                Write-Output "SSH service not found on host: $($_.Name)"
            }
        }
    } catch {
        Write-Host "An error occurred while stopping SSH on the hosts."
    }

    # Disconnect from vCenter
    Disconnect-VIServer -Confirm:$false
    Write-Host "Disconnected from vCenter."
} else {
    Write-Host "Credential file not found at $CredentialFilePath. Please create the file first."
}

#------
{Credential File Handling:
凭证文件处理：

The script reads the encrypted credentials from C:\vCenterCredentials.xml.
该脚本从  C:\vCenterCredentials.xml  读取加密的凭证。
If the file is missing, it prompts the user to create it first.
如果文件缺失，它会提示用户先创建该文件。
vCenter Connection: vCenter连接:

The Connect-VIServer cmdlet uses the imported credentials to log into vCenter.
此 cmdlet 使用导入的凭据登录到 vCenter。
Errors during connection (e.g., invalid credentials or network issues) are caught and handled.
连接过程中出现的错误（例如，无效的凭证或网络问题）会被捕获并处理。
Enable SSH: 使SSH:

The script retrieves all ESXi hosts using Get-VMHost.
该脚本使用  Get-VMHost  检索所有 ESXi 主机。
It checks for the SSH service (TSM-SSH) and starts it using Start-VMHostService.
它会检查 SSH 服务（ TSM-SSH ）是否存在，并使用  Start-VMHostService  启动该服务。
Logs are written for each host to indicate whether SSH was successfully enabled or not.
为每个主机都写入了日志，以表明 SSH 是否已成功启用。
Stop SSH: 停止SSH:

The script retrieves all ESXi hosts using Get-VMHost.
该脚本使用  Get-VMHost  检索所有 ESXi 主机。
It checks for the SSH service (TSM-SSH) and stops it using Stop-VMHostService.
它会检查 SSH 服务（ TSM-SSH ），并使用  Stop-VMHostService  命令将其停止。
Logs are written for each host to indicate whether SSH was successfully stopped or not.
为每个主机都写入了日志，以表明 SSH 是否已成功停止。
Error Handling: 错误处理:

Try-catch blocks are used to handle errors gracefully during connection and SSH enabling.
在连接和启用 SSH 期间，try-catch 块用于优雅地处理错误。
Disconnect from vCenter: 断开与 vCenter 的连接：

After operations are complete, the script disconnects from vCenter using Disconnect-VIServer.
操作完成后，脚本使用  Disconnect-VIServer  与 vCenter 断开连接。}
#------