# KB：VCSA 9.0.2 文件级备份失败（BackupManager encountered an exception）故障排查案例

## KB编号

VCSA-KB-20260722-01

## 适用范围

- VMware vCenter Server Appliance (VCSA)
- vCenter Server 9.0.2
- Build 25148086
- VAMI File-Based Backup

---

# 问题描述

VCSA 定时文件级备份失败。

VAMI 中显示：

```text
BackupManager encountered an exception
```

备份任务每天固定时间失败。

---

# 故障现象

登录：

```text
https://<VCSA>:5480
```

查看：

```text
Backup > Activity
```

备份任务状态：

```text
Failed
BackupManager encountered an exception
```

在 `/var/log/vmware/applmgmt/backup.log` 中发现以下报错：

```text
Failed to dispatch WAL directory structure.
```

```text
Underlying process status. rc:255
```

```text
BackupManager encountered an exception
```

部分日志中还出现：

```text
BrokenPipeError: [Errno 32] Broken pipe
```

```text
Process returncode is 120
```

---

# 环境信息

检查版本：

```bash
vpxd -v
```

返回：

```text
VMware VirtualCenter 9.0.2 build-25148086
```

检查 Build 信息：

```bash
cat /etc/vmware/.buildInfo
```

返回：

```text
NAME:9.0.2.0
BUILDNUMBER:25148086
```

---

# 故障排查过程

## Step 1：检查 PostgreSQL 数据库状态

查看日志发现：

```text
Current WAL file is:
000000010000001000000076
```

说明 PostgreSQL 能够正常响应查询。

检查服务状态：

```bash
service-control --status vmware-vpostgres
```

结果：

```text
Running
```

### 结论

- PostgreSQL 正常运行
- VCDB 正常
- WAL 正常生成

✅ 排除数据库故障

---

## Step 2：检查 WAL 目录

检查目录：

```bash
ls -ld /storage/dblog/vpostgres/pg_xlog
```

返回：

```text
drwx------ 3 vpostgres root
```

检查归档目录：

```bash
ls -ld /storage/dblog/vpostgres/pg_xlog/archive_status
```

返回：

```text
drwx------ 2 vpostgres vpgmongrp
```

检查 WAL 文件：

```bash
ls -al /storage/dblog/vpostgres/pg_xlog
```

结果：

```text
0000000100000010000000B7
0000000100000010000000B8
...
0000000100000010000000BF
```

### 结论

- WAL 文件存在
- archive_status 存在
- 无损坏文件
- 无异常软链接

✅ 排除 WAL 目录损坏

---

## Step 3：检查磁盘空间

执行：

```bash
df -h
```

关键分区：

```text
/storage/db      3%
/storage/dblog   2%
/storage/log     7%
```

### 结论

空间充足。

✅ 排除磁盘满导致的备份失败

---

## Step 4：检查 Build 信息

日志中出现：

```text
Failed to get vCenter version
```

怀疑版本信息异常。

检查：

```bash
cat /etc/vmware/.buildInfo
```

结果完整且正常。

### 结论

✅ 排除 .buildInfo 文件损坏

---

## Step 5：验证 WAL 目录是否能够被打包

日志显示 VMware 实际执行命令：

```text
/usr/bin/tar -cz -C /
storage/dblog/vpostgres/pg_xlog
storage/dblog/vpostgres/pg_xlog/archive_status
```

手工测试：

```bash
cd /

tar -czf /tmp/wal.tar.gz \
storage/dblog/vpostgres/pg_xlog \
storage/dblog/vpostgres/pg_xlog/archive_status
```

检查返回值：

```bash
echo $?
```

结果：

```text
0
```

检查压缩包：

```bash
ls -lh /tmp/wal.tar.gz
```

结果：

```text
-rw-r--r-- 1 root root 40M
```

### 结论

- tar 正常
- 文件权限正常
- 文件系统正常
- WAL 目录可正常打包

✅ 排除 tar 失败

---

## Step 6：发现关键错误

执行：

```bash
grep -i "BrokenPipeError" \
-R /var/log/vmware/applmgmt/
```

结果：

```text
BrokenPipeError: [Errno 32] Broken pipe
```

出现多次。

进一步检查发现：

```text
Process returncode is 120
```

随后：

```text
Failed to dispatch WAL directory structure.
```

最终：

```text
rc=255
```

### 分析

备份流程：

```text
BackupManager
 └─ VCDB Backup
      └─ _wal_dir_structure_backup()
           └─ backupRestoreDispatch.py
                └─ dispatchFiles()
                     └─ BrokenPipeError
```

说明：

```text
Backup Framework 内部子进程通信异常
```

而非数据库故障。

---

## Step 7：检查 applmgmt 服务

初始误认为服务名为：

```bash
vmware-applmgmt
```

检查失败：

```text
Unable to locate service 'vmware-applmgmt'
```

查看服务列表：

```bash
service-control --status --all | grep -i appl
```

发现实际服务名称为：

```text
applmgmt
```

---

# 根因分析（Root Cause）

故障发生于：

```text
Backup Framework
└─ backupRestoreDispatch.py
```

在执行：

```text
WAL directory structure backup
```

过程中出现：

```text
BrokenPipeError: [Errno 32] Broken pipe
```

导致：

```text
dispatchFiles()
```

返回：

```text
rc=120
```

最终转换为：

```text
rc=255
```

并触发：

```text
BackupManager encountered an exception
```

---

# 已排除项目

| 项目 | 结果 |
|--------|--------|
| PostgreSQL故障 | 排除 |
| VCDB故障 | 排除 |
| WAL目录损坏 | 排除 |
| archive_status损坏 | 排除 |
| 磁盘空间不足 | 排除 |
| 文件权限问题 | 排除 |
| tar打包失败 | 排除 |
| BuildInfo损坏 | 排除 |
| 备份目标存储异常 | 排除 |

---

# 解决方案

重启 Appliance Management 服务：

```bash
service-control --restart applmgmt
```

检查状态：

```bash
service-control --status applmgmt
```

重新执行文件级备份。

结果：

```text
Backup Completed Successfully
```

---

# 最终结论

本案例中：

```text
BackupManager encountered an exception
```

仅为最终表现。

真正根因来自：

```text
BrokenPipeError: [Errno 32] Broken pipe
```

导致：

```text
Failed to dispatch WAL directory structure.
```

最终确认：

```text
applmgmt Backup Framework 内部状态异常
```

通过重启：

```bash
service-control --restart applmgmt
```

恢复正常。

---

# 快速排查命令

```bash
df -h

service-control --status vmware-vpostgres

ls -al /storage/dblog/vpostgres/pg_xlog

ls -al /storage/dblog/vpostgres/pg_xlog/archive_status

cat /etc/vmware/.buildInfo

grep -i "BrokenPipeError" \
/var/log/vmware/applmgmt/backup.log

tar -czf /tmp/wal.tar.gz \
/storage/dblog/vpostgres/pg_xlog \
/storage/dblog/vpostgres/pg_xlog/archive_status

service-control --restart applmgmt
```

---

# 经验总结

当 VCSA 文件级备份出现：

```text
BackupManager encountered an exception
```

并伴随：

```text
Failed to dispatch WAL directory structure
```

以及：

```text
BrokenPipeError: [Errno 32] Broken pipe
```

时，应优先排查：

```text
applmgmt Backup Framework
```

而不是首先怀疑：

- 数据库
- 存储空间
- WAL 文件
- 备份目标

在确认数据库、WAL 和 tar 功能正常后，可优先尝试：

```bash
service-control --restart applmgmt
```

多数情况下即可恢复备份功能。
