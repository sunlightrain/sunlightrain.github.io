#windows restart
shutdown /r /t 0

#shutdown
shutdown /s /t 0

#shutdown with message
shutdown /s /t 0 /c "System is shutting down"

Rename-Computer -NewName "NewServerName" -DomainCredential Domain\Admin -Restart    
#Rename computer and restart    
Rename-Computer -NewName "dlsftp01" -DomainCredential hynixdl\infraadmin -Restart
