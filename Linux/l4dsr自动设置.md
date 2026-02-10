当然可以 👍 下面我给你一份 **RHEL 8.2 一键配置脚本**，特点是：

*   ✅ **VIP 可配置**（支持脚本参数 `-v` 或修改 `/etc/sysconfig/l4dsr`）
*   ✅ 生成并部署：`/opt/scripts/start_realsrv.sh`、`/etc/sysctl.d/99-l4dsr.conf`、`/etc/systemd/system/l4dsr.service`
*   ✅ **systemd 标准管理**：`start/stop/restart/status`
*   ✅ **幂等**：重复执行不会反复添加 VIP
*   ✅ 自动备份旧文件（带时间戳）
*   ✅ 提供 `--uninstall` 卸载回滚

***

# 一键安装脚本（复制保存为 `setup_l4dsr.sh`）

> 建议：`vi setup_l4dsr.sh` 粘贴 → `chmod +x setup_l4dsr.sh` → 执行

```bash
#!/bin/bash
set -euo pipefail

# =========================
# L4 DSR One-Click Setup for RHEL8.x
# - Installs:
#   /etc/sysconfig/l4dsr
#   /opt/scripts/start_realsrv.sh
#   /etc/sysctl.d/99-l4dsr.conf
#   /etc/systemd/system/l4dsr.service
# - Enables and starts l4dsr service
# - Supports uninstall
# =========================

DEFAULT_VIP="10.68.229.13"

CONFIG_FILE="/etc/sysconfig/l4dsr"
SCRIPT_DIR="/opt/scripts"
RS_SCRIPT="${SCRIPT_DIR}/start_realsrv.sh"
SYSCTL_CONF="/etc/sysctl.d/99-l4dsr.conf"
SERVICE_FILE="/etc/systemd/system/l4dsr.service"

VIP="${DEFAULT_VIP}"
FORCE=0
UNINSTALL=0

log(){ echo -e "[INFO] $*"; }
warn(){ echo -e "[WARN] $*" >&2; }
err(){ echo -e "[ERR ] $*" >&2; }

usage() {
  cat <<EOF
Usage:
  $0 [-v VIP] [--force]
  $0 --uninstall

Options:
  -v VIP       Set VIP address (default: ${DEFAULT_VIP})
  --force      Overwrite existing files (also creates backups)
  --uninstall  Stop/disable service and remove installed files

Examples:
  sudo $0 -v 10.68.229.13
  sudo $0 --uninstall
EOF
}

need_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    err "Please run as root (use sudo)."
    exit 1
  fi
}

check_env() {
  # OS check (soft)
  if [[ -f /etc/redhat-release ]]; then
    log "Detected OS: $(cat /etc/redhat-release)"
  else
    warn "Cannot detect RHEL release file. Continue anyway."
  fi

  command -v ip >/dev/null 2>&1 || { err "'ip' command not found."; exit 1; }
  command -v systemctl >/dev/null 2>&1 || { err "'systemctl' command not found."; exit 1; }
  command -v sysctl >/dev/null 2>&1 || { err "'sysctl' command not found."; exit 1; }
}

backup_if_exists() {
  local f="$1"
  if [[ -f "$f" ]]; then
    local ts
    ts="$(date +%Y%m%d%H%M%S)"
    cp -a "$f" "${f}.bak.${ts}"
    log "Backed up $f -> ${f}.bak.${ts}"
  fi
}

write_file_safe() {
  local f="$1"
  local content="$2"

  if [[ -f "$f" && "$FORCE" -ne 1 ]]; then
    warn "$f exists. Use --force to overwrite. Skipping write."
    return 0
  fi

  backup_if_exists "$f"
  printf "%s" "$content" > "$f"
  log "Wrote $f"
}

valid_ipv4() {
  local ip="$1"
  [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1
  IFS='.' read -r o1 o2 o3 o4 <<<"$ip"
  for o in "$o1" "$o2" "$o3" "$o4"; do
    ((o >= 0 && o <= 255)) || return 1
  done
  return 0
}

install_all() {
  if ! valid_ipv4 "$VIP"; then
    err "Invalid VIP: $VIP"
    exit 1
  fi

  log "Installing L4 DSR configuration with VIP=${VIP}"
  mkdir -p "${SCRIPT_DIR}"

  # 1) config file
  local cfg_content
  cfg_content=$(cat <<EOF
# L4 DSR settings
VIP=${VIP}
EOF
)
  write_file_safe "${CONFIG_FILE}" "${cfg_content}"

  # 2) realserver script
  local rs_content
  rs_content=$(cat <<'EOF'
#!/bin/bash
set -euo pipefail

CONFIG_FILE="/etc/sysconfig/l4dsr"
if [[ -f "$CONFIG_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$CONFIG_FILE"
fi

: "${VIP:?VIP is not set. Please set VIP in /etc/sysconfig/l4dsr}"

vip_exists() {
  ip -o addr show dev lo | grep -qE "\b${VIP}/32\b"
}

apply_runtime_sysctl() {
  sysctl -w net.ipv4.conf.lo.arp_ignore=1 >/dev/null
  sysctl -w net.ipv4.conf.lo.arp_announce=2 >/dev/null
  sysctl -w net.ipv4.conf.all.arp_ignore=1 >/dev/null
  sysctl -w net.ipv4.conf.all.arp_announce=2 >/dev/null
}

reset_runtime_sysctl() {
  sysctl -w net.ipv4.conf.lo.arp_ignore=0 >/dev/null
  sysctl -w net.ipv4.conf.lo.arp_announce=0 >/dev/null
  sysctl -w net.ipv4.conf.all.arp_ignore=0 >/dev/null
  sysctl -w net.ipv4.conf.all.arp_announce=0 >/dev/null
}

case "${1:-}" in
  start)
    echo "[L4DSR] start: VIP=${VIP}"
    apply_runtime_sysctl
    if vip_exists; then
      echo "[L4DSR] VIP ${VIP}/32 already on lo (skip)"
    else
      ip addr add "${VIP}/32" dev lo
      echo "[L4DSR] added VIP ${VIP}/32 to lo"
    fi
    ;;
  stop)
    echo "[L4DSR] stop: VIP=${VIP}"
    if vip_exists; then
      ip addr del "${VIP}/32" dev lo
      echo "[L4DSR] removed VIP ${VIP}/32 from lo"
    else
      echo "[L4DSR] VIP ${VIP}/32 not found on lo (skip)"
    fi
    reset_runtime_sysctl
    ;;
  status)
    echo "[L4DSR] status: VIP=${VIP}"
    sysctl net.ipv4.conf.lo.arp_ignore net.ipv4.conf.lo.arp_announce \
          net.ipv4.conf.all.arp_ignore net.ipv4.conf.all.arp_announce
    ip -o addr show dev lo | grep -E "\b${VIP}/32\b" || true
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
    ;;
esac
EOF
)
  write_file_safe "${RS_SCRIPT}" "${rs_content}"
  chmod +x "${RS_SCRIPT}"

  # 3) sysctl persistent
  local sysctl_content
  sysctl_content=$(cat <<'EOF'
# L4 DSR ARP settings (persistent)
net.ipv4.conf.lo.arp_ignore = 1
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
EOF
)
  write_file_safe "${SYSCTL_CONF}" "${sysctl_content}"

  # 4) systemd service
  local svc_content
  svc_content=$(cat <<'EOF'
[Unit]
Description=L4 DSR Real Server VIP on lo and ARP tuning
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
EnvironmentFile=-/etc/sysconfig/l4dsr
ExecStart=/opt/scripts/start_realsrv.sh start
ExecStop=/opt/scripts/start_realsrv.sh stop
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
)
  write_file_safe "${SERVICE_FILE}" "${svc_content}"

  # Apply sysctl
  log "Applying sysctl persistent settings..."
  sysctl --system >/dev/null

  # Enable and start service
  log "Reloading systemd and enabling service..."
  systemctl daemon-reload
  systemctl enable --now l4dsr.service

  log "Done. Verification:"
  systemctl --no-pager --full status l4dsr.service || true
  log "Check VIP on lo:"
  ip -o addr show dev lo | grep -E "\b${VIP}/32\b" || true
}

uninstall_all() {
  warn "Uninstall mode: stopping/disabling service and removing files."

  if systemctl list-unit-files | grep -q '^l4dsr\.service'; then
    systemctl disable --now l4dsr.service || true
  fi

  rm -f "${SERVICE_FILE}"
  systemctl daemon-reload || true

  # Stop will remove VIP and reset runtime sysctl (best-effort)
  if [[ -x "${RS_SCRIPT}" ]]; then
    "${RS_SCRIPT}" stop || true
  fi

  rm -f "${RS_SCRIPT}"
  rm -f "${SYSCTL_CONF}"

  warn "Note: ${CONFIG_FILE} is kept by default (contains your VIP)."
  warn "If you also want to remove it: rm -f ${CONFIG_FILE}"

  log "Uninstall completed."
}

# -------------------------
# Parse arguments
# -------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
    -v)
      VIP="${2:-}"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --uninstall)
      UNINSTALL=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      err "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

need_root
check_env

if [[ "$UNINSTALL" -eq 1 ]]; then
  uninstall_all
else
  install_all
fi
```

***

# 使用方法

## 1) 安装（默认 VIP=10.68.229.13）

```bash
sudo chmod +x setup_l4dsr.sh
sudo ./setup_l4dsr.sh
```

## 2) 安装并指定 VIP

```bash
sudo ./setup_l4dsr.sh -v 10.68.229.13
```

## 3) 重新覆盖写入（如果你已经跑过一次）

```bash
sudo ./setup_l4dsr.sh -v 10.68.229.13 --force
```

## 4) 卸载

```bash
sudo ./setup_l4dsr.sh --uninstall
```

***

# 常用运维命令

```bash
# 查看状态
systemctl status l4dsr --no-pager

# 查看日志
journalctl -u l4dsr -n 100 --no-pager

# 重启服务（修改VIP后常用）
systemctl restart l4dsr

# 手动检查脚本状态
/opt/scripts/start_realsrv.sh status
```

***

## 小提醒（非常常见）

DSR 场景有时还需要处理 `rp_filter` 或防火墙导致的回包问题（跟拓扑有关）。如果你愿意，我可以把 **rp\_filter 自动检测 + 可选自动配置** 也加到一键脚本里。

你告诉我两点就行：

1.  RS 的业务网卡名是哪个？（如 `ens192` / `eth0`）
2.  VIP 是否和 RS 实际 IP 同网段？还是跨网段/隧道？

我就能给你“更贴近生产环境”的增强版一键脚本。
