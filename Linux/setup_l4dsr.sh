#!/bin/bash
set -euo pipefail

# ======= 可修改区 =======
VIP="${1:-10.68.40.130}"     # 允许传参：./setup_l4dsr.sh 10.68.40.130
SCRIPT_DIR="/opt/scripts"
RS_SCRIPT="${SCRIPT_DIR}/start_realsrv.sh"
RCLOCAL="/etc/rc.d/rc.local"
SERVICE_FILE="/usr/lib/systemd/system/l4dsr.service"
# ========================

need_root() {
  if [[ "$(id -u)" -ne 0 ]]; then
    echo "[ERROR] 请使用 root 执行。"
    exit 1
  fi
}

backup_file() {
  local f="$1"
  if [[ -f "$f" ]]; then
    cp -a "$f" "${f}.bak.$(date +%F_%H%M%S)"
  fi
}

ensure_dir() {
  mkdir -p "$SCRIPT_DIR"
}

write_rs_script() {
  echo "[INFO] 写入 Real Server 脚本: ${RS_SCRIPT}"
  cat >"$RS_SCRIPT" <<EOF
#!/bin/bash

VIP=${VIP}

. /etc/rc.d/init.d/functions

case "\$1" in
    start)
        echo "Starting for Real Server"
        echo "1" > /proc/sys/net/ipv4/conf/lo/arp_ignore
        echo "2" > /proc/sys/net/ipv4/conf/lo/arp_announce
        echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore
        echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce
        ifconfig lo:0 \$VIP netmask 255.255.255.255 up
        ;;
     stop)
        echo "Stopping for Real Server"
        ifconfig lo:0 down
        echo "0" > /proc/sys/net/ipv4/conf/lo/arp_ignore
        echo "0" > /proc/sys/net/ipv4/conf/lo/arp_announce
        echo "0" > /proc/sys/net/ipv4/conf/all/arp_ignore
        echo "0" > /proc/sys/net/ipv4/conf/all/arp_announce
        ;;
     *)
        echo "Usage: \$0 {start|stop}"
        exit 1
esac
EOF
  chmod +x "$RS_SCRIPT"
}

ensure_rclocal() {
  echo "[INFO] 配置 rc.local 自启动"
  # 备份
  backup_file "$RCLOCAL"

  # 确保 rc.local 存在
  if [[ ! -f "$RCLOCAL" ]]; then
    cat >"$RCLOCAL" <<'EOF'
#!/bin/bash
# rc.local
exit 0
EOF
  fi

  # 确保可执行
  chmod +x "$RCLOCAL"

  # 写入自启动行（避免重复）
  if ! grep -qF "/opt/scripts/start_realsrv.sh start" "$RCLOCAL"; then
    # 在 exit 0 之前插入
    sed -i '/^exit 0/i # AutoStart DSR L4 Service\n/opt/scripts/start_realsrv.sh start\n' "$RCLOCAL"
  fi
}

write_systemd_service() {
  echo "[INFO] 写入 systemd 服务: ${SERVICE_FILE}"
  backup_file "$SERVICE_FILE"

  cat >"$SERVICE_FILE" <<'EOF'
[Unit]
Description=Runs /etc/rc.d/rc.local
Wants=network.target network-online.target
After=network.target network-online.target

[Service]
Type=forking
ExecStart=/etc/rc.d/rc.local

[Install]
WantedBy=multi-user.target
EOF
}

enable_service() {
  echo "[INFO] 重新加载 systemd 并启用服务"
  systemctl daemon-reload
  systemctl enable l4dsr.service
}

start_now() {
  echo "[INFO] 立即执行一次 start 配置"
  "$RS_SCRIPT" start || true
}

print_check() {
  echo
  echo "========== 配置完成，检查信息 =========="
  echo "[CHECK] 脚本 VIP 行："
  grep '^VIP' "$RS_SCRIPT" || true

  echo
  echo "[CHECK] lo:0 是否已绑定 VIP："
  ifconfig -a | grep -E "lo:0|${VIP}" || true

  echo
  echo "[CHECK] 当前 ARP 参数："
  echo -n "lo arp_ignore="; cat /proc/sys/net/ipv4/conf/lo/arp_ignore
  echo -n "lo arp_announce="; cat /proc/sys/net/ipv4/conf/lo/arp_announce
  echo -n "all arp_ignore="; cat /proc/sys/net/ipv4/conf/all/arp_ignore
  echo -n "all arp_announce="; cat /proc/sys/net/ipv4/conf/all/arp_announce

  echo
  echo "[CHECK] systemd 服务状态："
  systemctl status l4dsr.service --no-pager || true

  echo
  echo "======================================="
  echo "提示：重启后可验证 rc.local 是否执行："
  echo "  journalctl -u l4dsr.service -b --no-pager"
}

main() {
  need_root
  ensure_dir
  write_rs_script
  ensure_rclocal
  write_systemd_service
  enable_service
  start_now
  print_check
}

main