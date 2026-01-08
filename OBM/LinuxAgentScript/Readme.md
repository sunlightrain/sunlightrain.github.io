📦 脚本功能概述

自动下载安装包到指定目录
自动解压并查找安装脚本
校验并可选地更新 /etc/hosts（确保 OBM 和本机解析）
执行安装
验证服务状态
设置短主机名（LOCAL_NODE_NAME、OPC_NODE_NAME）
重启服务并输出结果

🧩 使用方法

保存脚本为 install_obm.sh
赋予执行权限：

chmod +x install_obm.shShow more lines

运行（示例）：

sudo ./install_obm.sh \  --server dlobm.hynix-dl.com \  --repo http://10.68.37.105/iso/app/linux/obm/package/ \  --target /tmp/obm/1.0 \  --set-hosts "10.68.40.130 dlobm.hynix-dl.com" \  --hostname "$(hostname -s)"

说明

--server：OBM服务器FQDN（必填）
--repo：安装包目录URL（默认：http://10.68.37.105/iso/app/linux/obm/package/）
--target：下载并解压的目标目录（默认：/tmp/obm/1.0）
--set-hosts：可选，自动添加到 /etc/hosts 的条目，如 "IP FQDN"
--hostname：可选，设置短主机名（默认取 hostname -s）

✅ 说明与注意

必须使用 root 权限（建议直接 sudo）。
如果网络不能访问 10.68.37.105，可以先把包手动放到 --target 目录，脚本会直接解压并安装。
--set-hosts 仅添加 一条 IP FQDN，如果需要多个条目可重复运行或让我们扩展为多条。
脚本对 ovc/opcagt/ovconfchg 做了存在性检查，避免路径不一致时直接失败。
运行结束会生成日志在 /var/log/obm_install_YYYY-MM-DD_HHMMSS.log