# oracle RAC 12c 2.0 on ESXi 6.7 NTP 配置脚本
#------------------------
#1 检查NTP DNS YUM
#------------------------
# YUM源配置
[root@dltestoradb11 ~]# cat /etc/yum.repos.d/local-repo.repo
[RedHat]
name=RHEL -  Redhat Enterprise Linux 8
baseurl=http://10.68.228.100/iso/rhel8.10/BaseOS
enabled=1
gpgcheck=0

[AppStream]
name=RHEL -  Redhat Enterprise Linux 8 AppStream
baseurl=http://10.68.228.100/iso/rhel8.10/AppStream
enabled=1
gpgcheck=0
[root@dltestoradb11 ~]#

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


#添加备份网络 这次不做
ip link show
nmcli connection show
#------------------------

#添加RAC网络 

#db1
nmcli connection show
nmcli connection add type ethernet con-name ens224 ifname ens224
nmcli connection modify ens224 ipv4.addresses 10.250.161.221/24
nmcli connection modify ens224 ipv4.method manual
nmcli connection up ens224

#db2
nmcli connection show
nmcli connection add type ethernet con-name ens224 ifname ens224
nmcli connection modify ens224 ipv4.addresses 10.250.161.222/24
nmcli connection modify ens224 ipv4.method manual
nmcli connection up ens224

#修改MTU
#查看当前连接名称
nmcli connection show

nmcli connection modify "ens224" 802-3-ethernet.mtu 9000
#nmcli connection modify "ens256" 802-3-ethernet.mtu 9000
nmcli connection down "ens224"
#nmcli connection down "ens256"
nmcli connection up "ens224"
#nmcli connection up "ens256"
nmcli device show | grep MTU


#------------------------
# Configure /data mount point
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
chown -R oracle:dba /oratrace

#chown -R oracle:dba /orahome
#chown -R oragrid:dba /oragrid

#------------------------
#NFS 这次不做

##
#虚拟化平台创建新的共享磁盘，并挂载到2台DB服务器上
#node1

磁盘组   数量 × 单盘大小  用途 
+SYSTEM  3 × 10 GB      OCR / Voting Disk 

+DATA    2 × 128 GB     数据文件 

+REDO    4 × 16 GB      重做日志 

+MIRROR  4 × 16 GB      冗余镜像

+ARCH    2 × 128 GB     归档日志 

手动VMware 平台添加共享磁盘，分配给两台DB服务器。
#node1
#------------------------
#!/bin/bash 
for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq;
do
parted /dev/$disk mklabel gpt
parted /dev/$disk mkpart primary "1 -1"
done
#------------------------

#node2
for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq;
do
partprobe /dev/$disk
done
#------------------------




###
为了测试SCP 修改MTU
ping -M do -s 8972 10.250.161.234


nmcli connection show

nmcli connection modify "ens224" 802-3-ethernet.mtu 9000
#nmcli connection modify "ens256" 802-3-ethernet.mtu 9000
nmcli connection down "ens224"
#nmcli connection down "ens256"
nmcli connection up "ens224"
#nmcli connection up "ens256"
nmcli device show | grep MTU

#修改MTU回1500
nmcli connection modify "ens224" 802-3-ethernet.mtu 1500
#nmcli connection modify "ens256" 802-3-ethernet.mtu 9000
nmcli connection down "ens224"
#nmcli connection down "ens256"
nmcli connection up "ens224"
#nmcli connection up "ens256"
nmcli device show | grep MTU

#添加Backup网络 
#db1
nmcli connection show
nmcli connection add type ethernet con-name ens225 ifname ens225
nmcli connection modify ens225 ipv4.addresses 10.250.131.221/24
nmcli connection modify ens225 ipv4.method manual
nmcli connection up ens225

#db2
nmcli connection show
nmcli connection add type ethernet con-name ens225 ifname ens225
nmcli connection modify ens225 ipv4.addresses 10.250.131.222/24
nmcli connection modify ens225 ipv4.method manual
nmcli connection up ens225