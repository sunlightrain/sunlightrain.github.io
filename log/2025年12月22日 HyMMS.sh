
#------------------------
#1 Create hymmsadmin user
#------------------------
groupadd -g 1002 hymmsadmin
useradd -g 1002 -u 1002 -s /bin/bash hymmsadmin
echo "hymmsadmin:Hynixdl@123" | chpasswd

#------------------------
#2 Configure /data mount point
#------------------------
pvcreate /dev/sdb
vgcreate datavg /dev/sdb
lvcreate -l 100%FREE -n datalv datavg
mkfs.xfs /dev/mapper/datavg-datalv
mkdir /data
cat << EOF >> /etc/fstab
/dev/mapper/datavg-datalv  /data      xfs     defaults        0 0
EOF
mount -a
chown -R hymmsadmin:hymmsadmin /data
df -hT

#------------------------
#3 检查NTP DNS YUM
#------------------------
cat /etc/yum.repos.d/local-repos.repo

#内部YUM源方便安装需要的组件，加速安装速度。

vi  /etc/yum.repos.d/local-repos.repo

[redhat]
name = RHEL - Redhat Enterprise Linux 8
baseurl = http://10.68.37.105/iso/rhel8.10/BaseOS
enabled = 1
gpgcheck = 0

[appstream]
name = RHEL - Redhat Enterprixe Linux 8 appStream
baseurl = http://10.68.37.105/iso/rhel8.10/AppStream
enabled = 1
gpgcheck = 0

cat /etc/resolv.conf

#配置DNS解析服务器
cat << EOF >> /etc/resolv.conf
nameserver 10.68.121.7
nameserver 10.68.121.8
EOF


cat /etc/chrony.conf

server 10.68.121.7 iburst
server 10.68.121.8 iburst

systemctl restart chronyd.service
chronyc sources -v

--------------------

#添加备份网络

ip link show
nmcli connection show
#dlhymmsweb01~04
nmcli connection add type ethernet con-name ens35 ifname ens35
nmcli connection modify ens35 ipv4.addresses 10.250.131.121/24
nmcli connection modify ens35 ipv4.method manual
nmcli connection up ens35

nmcli connection add type ethernet con-name ens35 ifname ens35
nmcli connection modify ens35 ipv4.addresses 10.250.131.122/24
nmcli connection modify ens35 ipv4.method manual
nmcli connection up ens35

nmcli connection add type ethernet con-name ens35 ifname ens35
nmcli connection modify ens35 ipv4.addresses 10.250.131.123/24
nmcli connection modify ens35 ipv4.method manual
nmcli connection up ens35

nmcli connection add type ethernet con-name ens35 ifname ens35
nmcli connection modify ens35 ipv4.addresses 10.250.131.124/24
nmcli connection modify ens35 ipv4.method manual
nmcli connection up ens35

#change MTU 9000
nmcli connection modify ens35 802-3-ethernet.mtu 9000
nmcli connection down ens35
nmcli connection up ens35
nmcli device show | grep MTU

#dlhymmsdb01-02

nmcli connection add type ethernet con-name ens35 ifname ens35
nmcli connection modify ens35 ipv4.addresses 10.250.161.61/24
nmcli connection modify ens35 ipv4.method manual
nmcli connection up ens35

nmcli connection add type ethernet con-name ens36 ifname ens36
nmcli connection modify ens36 ipv4.addresses 10.250.131.125/24
nmcli connection modify ens36 ipv4.method manual
nmcli connection up ens36

nmcli connection add type ethernet con-name ens35 ifname ens35
nmcli connection modify ens35 ipv4.addresses 10.250.161.62/24
nmcli connection modify ens35 ipv4.method manual
nmcli connection up ens35

nmcli connection add type ethernet con-name ens36 ifname ens36
nmcli connection modify ens36 ipv4.addresses 10.250.131.126/24
nmcli connection modify ens36 ipv4.method manual
nmcli connection up ens36

#change MTU 9000
nmcli connection modify ens35 802-3-ethernet.mtu 9000
nmcli connection modify ens36 802-3-ethernet.mtu 9000
nmcli connection down ens35
nmcli connection down ens36
nmcli connection up ens35
nmcli connection up ens36
nmcli device show | grep MTU

#---------------------------------

#OBM Hosts 
##HyMMS
10.68.40.71 dlhymmsweb01
10.68.40.72 dlhymmsweb02
10.68.40.74 dlhymmswas01
10.68.40.75 dlhymmswas02
10.68.39.61 dlhymmsdb01
10.68.39.62 dlhymmsdb02

#---------------------------------
#Mount NFS for DB Backup
#10.250.131.100:/dlhymmsdb_backup_01

mkdir /NAS_DB_BACKUP
cat << EOF >> /etc/fstab
10.250.131.100:/dlhymmsdb_backup_01 /NAS_DB_BACKUP nfs defaults,_netdev,noatime,bg,intr,tcp,actimeo=1800 0 0
EOF
mount -a 
df -hT

#--------------------------------   
mkdir /NAS_DB_BACKUP
cat << EOF >> /etc/fstab
10.250.131.100:/dlhymmsdb_backup_01 /NAS_DB_BACKUP  nfs rw,hard,bg,vers=3,proto=tcp,nointr,timeo=600,rsize=32768,wsize=32768,suid 0 0
EOF
mount -a 
df -hT

---------------------------------
#10.250.131.100:/dlhymmsdb_backup_01 /NAS_DB_BACKUP  nfs rw,hard,bg,vers=3,proto=tcp,nointr,timeo=600,rsize=32768,wsize=32768,suid 0 0



#------------------------
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
chown -R oracle:dba /oragrid
chown -R oracle:dba /oratrace
chown -R oracle:dba /NAS_DB_BACKUP

chmod 755 /dbawork
chmod 755 /orahome
chmod 755 /oratrace
chmod 755 /oragrid
chmod 755 /oraarch

#虚拟化平台创建新的共享磁盘，并挂载到2台DB服务器上，后期考虑使用powercli脚本实现自动化创建共享磁盘。
#------------------------
#!/bin/bash 
for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr sds sdt sdu;
do
parted /dev/$disk mklabel gpt
parted /dev/$disk mkpart primary "1 -1"
done
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
