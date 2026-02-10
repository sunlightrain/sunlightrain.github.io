C:\Users\x7020856\Downloads\DeployVMs.csv


sudo pvcreate /dev/sdc
sudo vgextend datavg /dev/sdc
sudo lvextend -l +100%FREE /dev/datavg/datalv
sudo xfs_growfs /data/

----------------
10.68.38.165    dlsyslog01.corp.hynix-dl.com dlsyslog01
10.68.38.167    dlloglnx11.corp.hynix-dl.com dlloglnx11

-----
免密登录：
✅ 1. 在客户端生成SSH密钥
在需要免密登录的客户端执行：

ssh-keygen -t rsa -b 4096
✅ 2. 将公钥复制到目标服务器
使用ssh-copy-id命令将生成的公钥复制到目标服务器的authorized_keys文件
ssh-copy-id user@remote_host

ssh-copy-id root@dlsyslog01

user：远程服务器用户名
remote_host：远程服务器IP或域名

如果没有 ssh-copy-id，可以手动：
cat ~/.ssh/id_rsa.pub | ssh user@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
✅ 3. 测试免密登录
ssh user@remote_host
如果一切设置正确，应该可以直接登录而不需要输入密码。
----------------

DNS解析：
    主机名	"ESXi MGMT/vMotion"	带外
dlisnesxi23	10.68.37.75	    10.68.47.75
dlisnesxi24	10.68.37.76	    10.68.47.76
dlisnesxi25	10.68.37.77	    10.68.47.77
dldevvcsa01	10.68.37.200	
dldevesxi01	10.68.37.201	10.68.47.201
dldevesxi02	10.68.37.202	10.68.47.202
dldevesxi03	10.68.37.203	10.68.47.203


echo "" > /etc/udev/rules.d/99-oracle-asmdevices.rules
disknum=1
for i in `cat /proc/partitions | awk {'print $4'} |grep sd|grep -v sda |grep -v sdb|grep -v grep`; do
RESULT=`/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/$i`
echo "KERNEL==\"sd?1\", SUBSYSTEM==\"block\", PROGRAM==\"/usr/lib/udev/scsi_id --whitelisted --replace-whitespace --device=/dev/\$name\", RESULT==\"$RESULT\", SYMLINK+=\"asm_disk$disknum\",  OWNER=\"grid\",  GROUP=\"asmadmin\", MODE=\"0660\"" >>/etc/udev/rules.d/99-oracle-asmdevices.rules
disknum=`expr $disknum + 1` 
done




/usr/lib/udev/scsi_id -g -u -d /dev/sdd1

cat /etc/udev/rules.d/99-oracle-asmdevices.rules
udevadm control --reload-rules
udevadm trigger
sleep 3
ls -l /dev/sd* |grep -v sda
ls -l /dev/asm*


cat /proc/partitions | awk {'print $4'} |grep sd|grep -v sda |grep -v sdb|grep -v grep

#!/usr/bin/env bash
set -euo pipefail

# 目标规则文件
OUT="/etc/udev/rules.d/99-oracle-asmdevices.rules"
TMP="${OUT}.tmp"

# 自动定位 scsi_id 的路径
SCSI_ID="/sbin/scsi_id"
[ -x "$SCSI_ID" ] || SCSI_ID="/usr/lib/udev/scsi_id"
[ -x "$SCSI_ID" ] || SCSI_ID="/lib/udev/scsi_id"

if [ ! -x "$SCSI_ID" ]; then
  echo "ERR: scsi_id 不存在，无法生成规则。请确认系统已安装 udev/scsi_id。"
  exit 1
fi

# 原子生成临时文件
: > "$TMP"

disknum=1

# 仅取“整盘”的名称（sdX），排除 sda/sdb，再映射到其第一个分区 sdX1
# 确保只处理存在的第一个分区
for disk in $(ls -1 /sys/block | grep -E '^sd[a-z]$' | grep -Ev '^sd[a-b]$'); do
  part="/dev/${disk}1"
  if [ ! -b "$part" ]; then
    # 没有第一个分区则跳过
    continue
  fi

  # 读取该分区对应整盘的 WWID（scsi_id）
  RESULT="$("$SCSI_ID" -g -u -d "$part" 2>/dev/null || true)"
  # 为空则跳过，避免产生错误规则
  [ -n "$RESULT" ] || continue

  # 生成规则：
  #   - 仅匹配块设备分区：KERNEL=="sd*[0-9]"（避免整盘 sdX 被匹配）
  #   - PROGRAM 再次调用 scsi_id（udev 运行时展开 $name）
  #   - RESULT 与上面的 RESULT 一致才匹配
  #   - 生成 /dev/asm_diskN 的符号链接，并设置权限/属主/属组
  echo "SUBSYSTEM==\"block\", KERNEL==\"sd*[0-9]\", PROGRAM==\"$SCSI_ID -g -u -d /dev/\\\$name\", RESULT==\"$RESULT\", SYMLINK+=\"asm_disk${disknum}\", OWNER=\"grid\", GROUP=\"asmadmin\", MODE=\"0660\"" >> "$TMP"

  disknum=$((disknum+1))
done

# 原子替换
mv "$TMP" "$OUT"

# 重新加载并触发 udev
udevadm control --reload
udevadm trigger --subsystem-match=block --action=add

echo "生成完成：$OUT"
ls -l /dev/asm_disk* 2>/dev/null || true



---
2026年2月9日
#lvm 磁盘管理data磁盘挂载
pvcreate /dev/sdb
vgcreate datavg /dev/sdb
lvcreate -l 100%FREE -n datalv datavg
mkfs.xfs /dev/mapper/datavg-datalv
mkdir /data
cat << EOF >> /etc/fstab
/dev/mapper/datavg-datalv  /data      xfs     defaults        0 0
EOF
mount -a
df -hT
---


dldevharbor01.corp.hynix-dl.com


sudo mkdir -p /etc/docker
echo "{}" | sudo tee /etc/docker/daemon.json


{
  "insecure-registries": ["10.68.37.208"]
}
