
#------------------------
#1 检查NTP DNS YUM
#------------------------
# YUM源配置
cat /etc/yum.repos.d/local-repo.repo
#-------------------------
[RedHat]
name=RHEL -  Redhat Enterprise Linux 8
baseurl=http://10.68.37.105/iso/rhel8.10/BaseOS
enabled=1
gpgcheck=0

[AppStream]
name=RHEL -  Redhat Enterprise Linux 8 AppStream
baseurl=http://10.68.37.105/iso/rhel8.10/AppStream
enabled=1
gpgcheck=0
#-------------------------
#配置DNS解析服务器
cat /etc/resolv.conf
#配置DNS解析服务器nameserver
cat << EOF >> /etc/resolv.conf
nameserver 10.68.121.7
nameserver 10.68.121.8
EOF
#--------------------------
#配置NTP时间同步服务器
cat /etc/chrony.conf  
chronyc sources -v
#--------------------------

#添加备份网络
ip link show
nmcli connection show
#dlfmeadb01-02
#------------------------

#db1
nmcli connection show
nmcli connection add type ethernet con-name ens224 ifname ens224
nmcli connection modify ens224 ipv4.addresses 10.250.161.93/24
nmcli connection modify ens224 ipv4.method manual
nmcli connection up ens224

#---------
#db1
nmcli connection show
nmcli connection add type ethernet con-name ens256 ifname ens256
nmcli connection modify ens256 ipv4.addresses 10.250.131.93/24
nmcli connection modify ens256 ipv4.method manual
nmcli connection up ens256

#------------------------
#db2
nmcli connection show
nmcli connection add type ethernet con-name ens224 ifname ens224
nmcli connection modify ens224 ipv4.addresses 10.250.161.94/24
nmcli connection modify ens224 ipv4.method manual
nmcli connection up ens224
#-----------
#db2
nmcli connection show
nmcli connection add type ethernet con-name ens256 ifname ens256
nmcli connection modify ens256 ipv4.addresses 10.250.131.94/24
nmcli connection modify ens256 ipv4.method manual
nmcli connection up ens256

#修改MTU
#查看当前连接名称
nmcli connection show

nmcli connection modify "ens224" 802-3-ethernet.mtu 9000
nmcli connection modify "ens256" 802-3-ethernet.mtu 9000
nmcli connection down "ens224"
nmcli connection down "ens256"
nmcli connection up "ens224"
nmcli connection up "ens256"
nmcli device show | grep MTU

#------------------------
#2 Configure /data mount point
#------------------------
#------------------------
#配置磁盘
lsblk
# 2 node执行
pvcreate /dev/sdb
vgcreate datavg /dev/sdb
lvcreate -l 50%FREE -n dbaworklv datavg
lvcreate -l 100%FREE -n oraarchlv datavg
mkfs.xfs /dev/mapper/datavg-dbaworklv
mkfs.xfs /dev/mapper/datavg-oraarchlv
mkdir /dbawork
mkdir /oraarch
cat << EOF >> /etc/fstab
/dev/mapper/datavg-dbaworklv  /dbawork      xfs     defaults        0 0
/dev/mapper/datavg-oraarchlv  /oraarch      xfs     defaults        0 0
EOF
mount -a


chown -R oracle:dba /dbawork
chown -R oracle:dba /oraarch
chown -R oracle:dba /orahome
# chown -R oracle:dba /oragrid
chown -R oracle:dba /oratrace
# 修改如下：
chown -R oragrid:dba /oragrid

chmod 755 /dbawork
chmod 755 /orahome
chmod 755 /oratrace
chmod 755 /oragrid
chmod 755 /oraarch

#------------------------
#NFS
mkdir /NAS_DB_BACKUP
cat << EOF >> /etc/fstab
10.250.131.100:/dlfmeabufdb_backup_01 /NAS_DB_BACKUP  nfs rw,hard,bg,vers=3,proto=tcp,nointr,timeo=600,rsize=32768,wsize=32768,suid 0 0
EOF
systemctl daemon-reload
mount -a 
df -hT
#--------------------------
#NAS 权限
chown -R oracle:dba /NAS_DB_BACKUP
##

##
#虚拟化平台创建新的共享磁盘，并挂载到2台DB服务器上
#node1
#------------------------
#!/bin/bash 
for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu;
do
parted /dev/$disk mklabel gpt
parted /dev/$disk mkpart primary "1 -1"
done
#------------------------

#node2
for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu;
do
partprobe /dev/$disk
done
#------------------------

#------------------------
#--OS 参数
#------------------------
kernel.sem                        250 32000 100 1024 #ok    
kernel.shmmni                     4096               #ok
kernel.shmmax                     364320600883     #change     
kernel.shmall                     88945459         #change       
kernel.panic_on_oops              1         #ok                
vm.swappiness                     10        #ok             
fs.file-max                       6815744 #ok               
fs.aio-max-nr                     49152000  #ok             
net.ipv4.ip_local_port_range      9000 65500    #ok         
net.core.rmem_default             16777216  #ok             
net.core.rmem_max                 16777216  #ok             
net.core.wmem_default             16777216  #ok             
net.core.wmem_max                 16777216  #ok             
vm.min_free_kbytes                4194304   #ok           
kernel.randomize_va_space         0         #ok             
net.ipv4.conf.default.rp_filter   2         #ok
#------------------------
#在各 RAC 节点的 Linux 内部使用udev 进行磁盘绑定：
#------------------------
for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu;
do
/usr/lib/udev/scsi_id -g -u -d /dev/$disk
done
#------------------------
# /usr/lib/udev/scsi_id -g -u -d /dev/sdc 

36000c294738552533e2cd77a80cd91d2
36000c29175dd3e69aeb07b0ee78b0fc7
36000c29c7d55684d64fa1b09f004d7c8
36000c29f4f4e78416f2f6b3e702b7ad4
36000c299a4a7e24641b255a6f281809e
36000c29413953833e1d1b8e2bcbb3632
36000c29f21bb970ea5a83221c0c502dc
36000c290f02c2b3219e0f763eb6d41b4
36000c295ab99d9b779d45a170f97b3a1
36000c295e8d7ded35a4d22eaf35b5dbd
36000c290fd4c16fa7b633adcf853a8c1
36000c294dfac04f8f5e0ced7246fea75
36000c295d1a26249f88c752c86586941
36000c29588f49a6b1405af0f8c9199eb
36000c2933757b1875c040b97e8b3ea0d
36000c29cdd7d9c83a645c4342737feca
36000c298ffb7c62c2e83cecfe9dee3ad
36000c2975b773815941ebcb0d43effbb
36000c29fd21ec6145e41aa860ac6ba41
#------------------------

vim /etc/udev/rules.d/90-oracleasm.rules

#------------------------
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c294738552533e2cd77a80cd91d2", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asms01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29175dd3e69aeb07b0ee78b0fc7", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asms02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29c7d55684d64fa1b09f004d7c8", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asms03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29f4f4e78416f2f6b3e702b7ad4", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmr01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c299a4a7e24641b255a6f281809e", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmr02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29413953833e1d1b8e2bcbb3632", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmr03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29f21bb970ea5a83221c0c502dc", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmr04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c290f02c2b3219e0f763eb6d41b4", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmm01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c295ab99d9b779d45a170f97b3a1", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmm02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c295e8d7ded35a4d22eaf35b5dbd", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmm03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c290fd4c16fa7b633adcf853a8c1", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmm04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c294dfac04f8f5e0ced7246fea75", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c295d1a26249f88c752c86586941", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29588f49a6b1405af0f8c9199eb", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2933757b1875c040b97e8b3ea0d", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29cdd7d9c83a645c4342737feca", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd05", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c298ffb7c62c2e83cecfe9dee3ad", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd06", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2975b773815941ebcb0d43effbb", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd07", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29fd21ec6145e41aa860ac6ba41", SYMLINK+="dlfmeabufdb_asm/dlfmeabufdb_asmd08", OWNER="oragrid", GROUP="dba", MODE="0660"

udevadm control --reload-rules
udevadm trigger

ll /dev/dlfmeabufdb_asm/*

安装OBM agent


以下为AI建议：
# 8C / 32G Oracle RAC VM
# 文件：/etc/sysctl.d/99-oracle-rac.conf
#################################################
# Oracle 19c RAC - 8C / 32G VM
#################################################

# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

# Kernel panic & debug
kernel.panic_on_oops = 1
kernel.unknown_nmi_panic = 1
kernel.panic_on_unrecovered_nmi = 1
kernel.panic_on_io_nmi = 1
kernel.sysrq = 1
kernel.randomize_va_space = 0

# Semaphores
kernel.sem = 250 32000 100 1024

# Shared memory
kernel.shmmni = 4096
kernel.shmmax = 34359738368
kernel.shmall = 8388608

# File handles & AIO
fs.file-max = 6815744
fs.aio-max-nr = 49152000
kernel.pid_max = 32768

# Memory behavior
vm.swappiness = 1
vm.min_free_kbytes = 2097152

# Network (RAC interconnect)
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 16777216
net.core.rmem_max = 16777216
net.core.wmem_default = 16777216
net.core.wmem_max = 16777216
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2

# HugePages (示例：SGA ≈ 20G)
# 20G / 2MB = 10240
vm.nr_hugepages = 10240

## 2️⃣ 8C / 64G Oracle RAC VM
## 文件：/etc/sysctl.d/99-oracle-rac.conf
#################################################
# Oracle 19c RAC - 8C / 64G VM
#################################################

# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

# Kernel panic & debug
kernel.panic_on_oops = 1
kernel.unknown_nmi_panic = 1
kernel.panic_on_unrecovered_nmi = 1
kernel.panic_on_io_nmi = 1
kernel.sysrq = 1
kernel.randomize_va_space = 0

# Semaphores
kernel.sem = 250 32000 100 1024

# Shared memory
kernel.shmmni = 4096
kernel.shmmax = 68719476736
kernel.shmall = 16777216

# File handles & AIO
fs.file-max = 6815744
fs.aio-max-nr = 49152000
kernel.pid_max = 32768

# Memory behavior
vm.swappiness = 1
vm.min_free_kbytes = 4194304

# Network (RAC interconnect)
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 16777216
net.core.rmem_max = 16777216
net.core.wmem_default = 16777216
net.core.wmem_max = 16777216
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2

# HugePages (示例：SGA ≈ 24G)
# 24G / 2MB = 12288
vm.nr_hugepages = 12288


## limits 模板（必须，HugePages 依赖）
文件：/etc/security/limits.d/99-oracle.conf

#################################################
# Oracle 19c RAC limits
#################################################

oracle soft nproc 16384
oracle hard nproc 16384：
oracle soft nofile 102400
oracle hard nofile 102400
oracle soft stack 10240
oracle hard stack 32768
oracle soft memlock unlimited
oracle hard memlock unlimited

grid soft nproc 16384
grid hard nproc 16384
grid soft nofile 102400
grid hard nofile 102400
grid soft stack 10240
grid hard stack 32768
grid soft memlock unlimited
grid hard memlock unlimited