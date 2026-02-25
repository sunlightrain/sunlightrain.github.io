Setting name                        Value   
Queue Length                        2000 (up from default of 1000)
Idle Time-out (minutes)             0 (down from the default of 20)
Ping Enabled                        False (from default of True)
Private Memory Limit (KB)           0 (unlimited, up from the default of 1,843,200 KB)
Regular Time Interval (minutes)     0 (to prevent a recycle, and modified from the default of 1740)



http://dlwsus01.corp.hynix-dl.com:8530/SimpleAuthWebService/SimpleAuth.asmx

http://dlwsus01.corp.hynix-dl.com:8530/selfupdate/iuident.cab

net stop wuauserv
net stop bits
net start bits
net start wuauserv


Get-WindowsUpdateLog


Get-Service MpsSvc

http://dlwsus01.corp.hynix-dl.com:8530/selfupdate/iuident.cab

Test-netconnection dlwsus01.corp.hynix-dl.com -port 8530

	dlsmab1bkcimc-t.corp.hynix-dl.com	10.68.112.85	Windows Server 2016 Datacenter	1/22/2026 9:29 AM	99%
	dlsmab1prcimc-t.corp.hynix-dl.com	10.68.112.84	Windows Server 2016 Datacenter	1/21/2026 4:17 PM	99%
	dlsmaf1bkcimf-t.corp.hynix-dl.com	10.68.97.71	Windows Server 2016 Datacenter	1/21/2026 2:19 PM	99%
	dlsmaf1prcimf-t.corp.hynix-dl.com	10.68.97.70	Windows Server 2016 Datacenter	1/22/2026 9:50 AM	99%
	dlsmaf2bkcimf-t.corp.hynix-dl.com	10.68.97.73	Windows Server 2016 Datacenter	1/22/2026 9:56 AM	99%
	dlsmaf2prcimf-t.corp.hynix-dl.com	10.68.97.72	Windows Server 2016 Datacenter	1/21/2026 2:12 PM	99%
	dlsmag1bkcimh-t.corp.hynix-dl.com	10.68.112.149	Windows Server 2016 Datacenter	1/21/2026 2:24 PM	99%
	dlsmag1prcimh-t.corp.hynix-dl.com	10.68.112.148	Windows Server 2016 Datacenter	1/21/2026 3:58 PM	99%
	dlsmag2bkcimh-t.corp.hynix-dl.com	10.68.112.151	Windows Server 2016 Datacenter	1/22/2026 9:53 AM	99%
	dlsmag2prcimh-t.corp.hynix-dl.com	10.68.112.150	Windows Server 2016 Datacenter	Not yet reported	0%
	dlsmau1bkcimf-t.corp.hynix-dl.com	10.68.97.75	Windows Server 2016 Datacenter	1/22/2026 8:22 AM	99%
	dlsmau1prcimf-t.corp.hynix-dl.com	10.68.97.74	Windows Server 2016 Datacenter	1/21/2026 4:01 PM	99%
	dlsmaw1bkcimf-t.corp.hynix-dl.com	10.68.97.77	Windows Server 2016 Datacenter	1/21/2026 4:01 PM	99%
	dlsmaw1prcimf-t.corp.hynix-dl.com	10.68.97.76	Windows Server 2016 Datacenter	1/21/2026 4:01 PM	99%
	dlsrsbkcimf-t.corp.hynix-dl.com	10.68.97.69	Windows Server 2016 Datacenter	1/22/2026 9:05 AM	99%

dlsmab1bkcimc-t restart ok 1  ok
DLSMAF1BKCIMF-T restart ok 1  ok
DLSMAG1PRCIMH-T restart ok 1  ok

DLSMAF2PRCIMF-T restart ok 1  ok
DLSMAG1BKCIMH-T restart ok 1  ok

DLSMAU1BKCIMF-T restart ok 1  ok
DLSMAW1PRCIMF-T restart ok 1  ok

DLSMAW1BKCIMF-T restart ok 1  ok
DLSMAU1PRCIMF-T restart ok 1  ok

DLSMAF2BKCIMF-T restart ok 1  ok
DLSMAF1PRCIMF-T restart ok 1  ok

DLSMAG2PRCIMH-T            1  ok

DLSRSPRCIMF-T（DLSLBTEST04-T ?
DLSMAB1PRCIMC-T error       1 ok
DLSMAG2BKCIMH-T error  case 1 ok
DLSRSBKCIMF-T

-------------------------------------
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f


net start bits

net start wuauserv

wuauclt /resetauthorization /detectnow

PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()
 
 
 test-netconnection -computername dlwsus01.corp.hynix-dl.com -port 8530
 
 
 sc queryex wuauserv
 
 taskkill /PID 21324 /f
net stop bits

net stop wuauserv

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f

rd /s /q "%SystemRoot%\SoftwareDistribution"

net start bits

net start wuauserv

wuauclt /resetauthorization /detectnow

PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()
 -------------------------------------

2025-12KB5071543（累计更新，安全更新）
2025-11KB5068864（累计更新）、KB5070247（SSU）
2025-10KB5070882、KB5066836、KB5066584（SSU）
2025-09KB5065427、KB5065687（SSU）
2025-08KB5063871
2025-07KB5062560、KB5062799（SSU）
2025-06KB5061010
2025-05KB5058383
2025-04KB5055521、KB5055170（.NET）

---------------------------
net stop bits

net stop wuauserv

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f

rd /s /q "%SystemRoot%\SoftwareDistribution"

net start bits

net start wuauserv

wuauclt /resetauthorization /detectnow

PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()


---------------------------

sc queryex wuauserv

taskkill /PID 21324 /f
