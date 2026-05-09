
#$domain = "corp.hynix-dl.com"
#$ou = "OU=Production,OU=Infrastructure,OU=NDTMwx,DC=corp,DC=hynix-dl,DC=com"  
#$user = "hynixdl\infraadmin"
#$password = "DL@infra1!"


# Setting Domain Information
$domain = "corp.hynix-dl.com"
$ou = "OU=Develop,OU=CORP,OU=Servers,OU=DMTM-INFRA,DC=corp,DC=hynix-dl,DC=com" # Optional: Specify the organizational unit to join
$user = "hynixdl\infraadmin"
$password = "DL@infra1!"



# Converting Secure Credentials
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($user, $securePassword)

# Joining the Domain
Add-Computer -DomainName $domain -OUPath $ou -Credential $credential -Restart