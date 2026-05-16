dlpntdb01 / 10.68.39.101
dlpntdb02 / 10.68.39.102

虚拟机回收操作：
dlpntdb01 / 10.68.39.101
dlpntdb02 / 10.68.39.102

#0. 检查systemlist，确认虚拟机是否在systemlist中，如果存在，确认IP,请先删除systemlist中的虚拟机信息。
#1. 检查虚拟机是否安装SSR，如果存在，请先删除SSR agent。
 Move to the Agent install path, and run the delete command     

c:\SSR>.\Uninstaller-x64.exe

#2. 检查虚拟机是否在OBM中，如果存在，请先删除OBM中的虚拟机信息。
    删除node 节点
    删除hosts文件 obmapp1-2
    运行命令生效:sh /data01/mfsw/scripts/bin/mksvrping.sh

#3. 检查虚拟机是否安装ontune，如果存在，请先删除onTune agent。
4. 虚拟机关机，标记删除时间。
5. 删除虚拟机。
#6. 更新IP Management List，删除虚拟机IP地址。


#-----
[root@minio-01 ~]# mc alias set dev-minio http://minio-01:9000 \minioadmin \minioadmin123
Added `dev-minio` successfully.
[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]# mc admin info prod-minio
mc: <ERROR> Unable to initialize admin connection. No valid configuration found for 'prod-minio' host alias.
[root@minio-01 ~]# mc admin info dev-minio
●  minio-01:9000
   Uptime: 3 weeks
   Version: 2026-03-25T00:00:00Z
   Network: 4/4 OK
   Drives: 0/4 OK
   Pool: 1

●  minio-02:9000
   Uptime: 3 weeks
   Version: 2026-03-25T00:00:00Z
   Network: 4/4 OK
   Drives: 4/4 OK
   Pool: 1

●  minio-03:9000
   Uptime: 3 weeks
   Version: 2026-03-25T00:00:00Z
   Network: 4/4 OK
   Drives: 4/4 OK
   Pool: 1

●  minio-04:9000
   Uptime: 3 weeks
   Version: 2026-03-25T00:00:00Z
   Network: 4/4 OK
   Drives: 4/4 OK
   Pool: 1

┌──────┬───────────────────────┬─────────────────────┬──────────────┐
│ Pool │ Drives Usage          │ Erasure stripe size │ Erasure sets │
│ 1st  │ 0.7% (total: 800 GiB) │ 16                  │ 1            │
└──────┴───────────────────────┴─────────────────────┴──────────────┘

12 drives online, 4 drives offline, EC:4
[root@minio-01 ~]# mc alias list
dev-minio
  URL       : http://minio-01:9000
  AccessKey : minioadmin
  SecretKey : minioadmin123
  API       : s3v4
  Path      : auto
  Src       : /root/.mc/config.json

gcs
  URL       : https://storage.googleapis.com
  AccessKey : YOUR-ACCESS-KEY-HERE
  SecretKey : YOUR-SECRET-KEY-HERE
  API       : S3v2
  Path      : dns
  Src       : /root/.mc/config.json

local
  URL       : http://localhost:9000
  AccessKey :
  SecretKey :
  API       :
  Path      : auto
  Src       : /root/.mc/config.json

play
  URL       : https://play.min.io
  AccessKey : Q3AM3UQ867SPQQA43P2F
  SecretKey : zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG
  API       : S3v4
  Path      : auto
  Src       : /root/.mc/config.json

s3
  URL       : https://s3.amazonaws.com
  AccessKey : YOUR-ACCESS-KEY-HERE
  SecretKey : YOUR-SECRET-KEY-HERE
  API       : S3v4
  Path      : dns
  Src       : /root/.mc/config.json

[root@minio-01 ~]# mc ls dev-minio
[root@minio-01 ~]# mc mb dev-minio/test
Bucket created successfully `dev-minio/test`.
[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]# ls
append_hosts.sh  host_list.txt  update_hosts.sh
[root@minio-01 ~]# mc cp host_list.txt dev-minio/test/
/root/host_list.txt:       1.17 KiB / 1.17 KiB ┃▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓┃ 125.89 KiB/s 0s[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]#
[root@minio-01 ~]# mc ls dev-minio/test
[2026-05-12 11:16:09 CST] 1.2KiB STANDARD host_list.txt
[root@minio-01 ~]#
[root@minio-01 ~]#

#-----
