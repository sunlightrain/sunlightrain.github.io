dlpntoutdb02
Get-ADComputer -Identity "dlpntoutdb02" | Select-Object Name, DistinguishedName

Get-ADComputer dlbfroot01  | Select-Object DistinguishedName

当前ou

OU=Production,OU=Infrastructure,OU=NDTMwx,DC=corp,DC=hynix-dl,DC=com

pntoutdb：

OU=DB,OU=Dev,OU=Servers,OU=DMTM-INFRA,DC=corp,DC=hynix-dl,DC=com

infra:
OU=Infra,OU=Dev,OU=Servers,OU=DMTM-INFRA,DC=corp,DC=hynix-dl,DC=com

# 查询当前OU
Get-ADComputer dlpntoutdb01  | Select-Object DistinguishedName

PS C:\Windows\system32> Get-ADComputer dlpntoutdb01  | Select-Object DistinguishedName

DistinguishedName
-----------------
CN=DLPNTOUTDB01,OU=Production,OU=Infrastructure,OU=NDTMwx,DC=corp,DC=hynix-dl,DC=com


PS C:\Windows\system32>

