#证书相关命令
Get-ChildItem Cert:\LocalMachine\Root |
Where-Object { $_.Subject -like "*SKhynix*" }

Get-ChildItem Cert:\LocalMachine\Root |
Select-Object Subject, Issuer, Thumbprint, NotAfter

Get-ChildItem Cert:\LocalMachine\Root

Get-ChildItem Cert:\CurrentUser\Root

