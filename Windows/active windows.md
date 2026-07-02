#激活
slmgr /dlv
slmgr /skms kms.hynix-dl.com
slmgr /ato

#修改模板，增加 KMS 配置
#KMS 激活
slmgr /skms kms.hynix-dl.com
slmgr /ato

slmgr /skms dlkms01.corp.hynix-dl.com
slmgr /ato

tnc dlkms.hynix-dl.com -port 1688

dlkms01.corp.hynix-dl.com
dlkms02.corp.hynix-dl.com

tnc dlkms.hynix-dl.com -port 1688
tnc dlkms01.corp.hynix-dl.com -port 1688
tnc dlkms02.corp.hynix-dl.com -port 1688


###----------------------
## DEV env
10.68.38.111
#DEV env 未加域激活：
tnc 10.68.38.111 -port 1688
slmgr /dlv
# 2️⃣ 设置 KMS 服务器地址
slmgr /skms 10.68.38.111:1688
# 3️⃣ 执行激活
slmgr /ato
# 4️⃣ 查看激活状态
slmgr /xpr
# 查看kms地址
slmgr /dli

# 查询时间同步
w32tm /query /status
# 配置NTP Server
w32tm /config /manualpeerlist:"10.68.121.7" /syncfromflags:manual /update
# 同步时间 ✅
w32tm /resync
# 查询时间同步
w32tm /query /status
###----------------------


##-----------------------
## 在已加入域的 Windows Server 2022 主机上安全重命名的做法
# 先改计算机名 → 自动在域里更新对象 → 重启 → 校验 DNS/AD 记录与依赖服务。

Rename-Computer -NewName "NEW-SRV01" -DomainCredential "域名\域管理员" -Restart

说明：
-DomainCredential：用于向域更新计算机对象（你也可以用当前登录的域管权限省略这项）
-Restart：重启生效（建议直接重启）

Rename-Computer -NewName "dlops01" -DomainCredential "hynixdl\infraadmin" -Restart

---------------------------------------
PS C:\Users\infraadmin> hostname
dlops01
PS C:\Users\infraadmin> whoami
hynixdl\infraadmin
PS C:\Users\infraadmin> nltest.exe /dsgetdc:hynixdl
           DC: \\DLBRAD02
      Address: \\10.68.56.22
     Dom Guid: 8d929ef5-6cb6-4629-9c25-bed2599e41ef
     Dom Name: HYNIXDL
  Forest Name: corp.hynix-dl.com
 Dc Site Name: DL-Wuxi
Our Site Name: DL-Wuxi
        Flags: GC DS LDAP KDC TIMESERV WRITABLE DNS_FOREST CLOSE_SITE FULL_SECRET WS DS_8 DS_9 DS_10 KEYLIST
The command completed successfully
PS C:\Users\infraadmin> ipconfig

Windows IP Configuration


Ethernet adapter Ethernet0:

   Connection-specific DNS Suffix  . :
   IPv4 Address. . . . . . . . . . . : 10.68.38.156
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.68.38.1

Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . :
   Autoconfiguration IPv4 Address. . : 169.254.46.25
   Subnet Mask . . . . . . . . . . . : 255.255.0.0
   Default Gateway . . . . . . . . . :

---------------------------------------