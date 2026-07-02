# Create a new VM using the NewVM.ps1 script with specified parameters	
    & ".\NewVM.ps1" `
  -CsvPath "C:\Users\x7020856\Documents\WindowsPowerShell\DeployVMs-VeeamProxy.csv" `
  -vCenterFQDN "dlisnvcsa01.corp.hynix-dl.com" `
  -Username "administrator@vsphere.local" `
  -Password "DL@infra12!@"

# 关闭提示
  Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false
# 查询计算机的OU
Get-ADComputer dlveempmis03 | Select-Object DistinguishedName

