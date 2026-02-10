好的，RHEL 8.2 我建议用 **systemd + EnvironmentFile** 来实现“VIP 可配置”，并且不用 `ifconfig/lo:0/rc.local` 这些旧方式。下面给你一套 **RHEL8.2 兼容、可重复执行（幂等）、可配置 VIP、支持 start/stop/status、重启自动生效** 的完整方案。

***

## ✅ 目标效果

*   VIP 通过配置文件 `/etc/sysconfig/l4dsr` 设置（可随时改）
*   `systemctl start|stop|status l4dsr` 管理
*   lo 上绑定 `VIP/32`
*   ARP 参数按 DSR 要求设置并持久化
*   多次运行不会重复添加 VIP / 报错

***

# 1) 创建可配置文件（VIP 在这里改）

```bash
sudo tee /etc/sysconfig/l4dsr >/dev/null <<'EOF'
# L4 DSR settings
VIP=10.68.229.13
# 如需改端口/更多参数可继续扩展
EOF
```

> 以后只要改这个文件里的 `VIP=...`，然后 `systemctl restart l4dsr` 即可生效。

***

# 2) 写 RealServer 启停脚本（RHEL8 推荐 ip 命令）

```bash
sudo mkdir -p /opt/scripts

sudo tee /opt/scripts/start_realsrv.sh >/dev/null <<'EOF'
#!/bin/bash
set -euo pipefail

# 读取配置（systemd 会通过 EnvironmentFile 传入 VIP；手动执行也可以 source）
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

sudo chmod +x /opt/scripts/start_realsrv.sh
```

***

# 3) 持久化 sysctl（重启后仍生效）

> DSR 常用 arp\_ignore/arp\_announce 的持久化方式是写入 `/etc/sysctl.d/`。

```bash
sudo tee /etc/sysctl.d/99-l4dsr.conf >/dev/null <<'EOF'
# L4 DSR ARP settings (persistent)
net.ipv4.conf.lo.arp_ignore = 1
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
EOF

sudo sysctl --system >/dev/null
```

***

# 4) 创建 systemd 服务（正确方式：直接调用你的脚本）

```bash
sudo tee /usr/lib/systemd/system/l4dsr.service >/dev/null <<'EOF'
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

sudo systemctl daemon-reload
sudo systemctl enable --now l4dsr.service
```

***

# 5) 验证

```bash
# 服务状态
systemctl status l4dsr.service --no-pager

# VIP 是否绑定到 lo
ip -o addr show dev lo | grep -E "\b$(. /etc/sysconfig/l4dsr; echo $VIP)/32\b"

# ARP 参数是否正确
sysctl net.ipv4.conf.lo.arp_ignore net.ipv4.conf.lo.arp_announce \
      net.ipv4.conf.all.arp_ignore net.ipv4.conf.all.arp_announce
```

***

# 6) 修改 VIP 的正确步骤（可配置的关键）

1.  编辑配置：

```bash
sudo vi /etc/sysconfig/l4dsr
# 修改 VIP=...
```

2.  重启服务让新 VIP 生效：

```bash
sudo systemctl restart l4dsr
```

3.  检查：

```bash
sudo /opt/scripts/start_realsrv.sh status
```

***

## ✅ 为什么不建议继续用 rc.local（尤其 RHEL8）

*   RHEL8 以 systemd 为主，rc.local 是兼容机制，容易引起启动顺序/权限/可执行等问题
*   你原脚本会**覆盖** rc.local，有风险
*   systemd 的 `ExecStart/ExecStop` 管理更可靠，日志也更清晰（`journalctl -u l4dsr`）

***

## 可选增强（建议你看一下）

DSR 有时还会遇到 **rp\_filter** 或防火墙导致回包/路由异常（取决于你的网络拓扑）。如果你希望我把这部分也一并加进安装脚本里，我需要你补充两点：

1.  你的 RS 有几块网卡？VIP 走哪块（例如 `ens192`）？
2.  DSR/LVS 的转发模式：DR（直连）还是隧道（TUN）？以及是否跨网段？

你回复这两点，我可以给你一个“更完整的生产版配置”（含 rp\_filter 建议、可选防火墙规则、以及更严格的健康检查）。
