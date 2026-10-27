# Cloudflare Tunnel + Harbor 部署文档

部署时间：2026-09-14
主机：`192.168.0.128`（`rke2-a01`）
配置目录：`/etc/cloudflared`

将内网 Harbor 私有镜像仓库通过 Cloudflare Tunnel 发布到公网。**无需公网 IP，无需在路由器做端口映射**——由目标机上的 `cloudflared` 主动向 Cloudflare 建立出站长连接，外部流量沿这条连接回推到内网。

---

## 1. 访问信息

| 项 | 值 |
| --- | --- |
| 公网地址 | https://harbor.chenxw.dpdns.org |
| 后端服务 | `http://localhost:80`（Harbor nginx 容器） |
| 访问控制 | 无 Cloudflare Access，仅 Harbor 自身认证 |
| 隧道名 | `harbor` |
| 隧道 ID | `f0994a02-bf6d-4146-94f3-5af66d130105` |
| 登录方式 | `ssh root@192.168.0.128`（密钥免密，端口 22） |

服务已 `systemctl enable`，**开机自启**。

---

## 2. 环境信息

### 目标机

| 项 | 值 |
| --- | --- |
| IP | `192.168.0.128/24`（ens192） |
| 主机名 | `rke2-a01` |
| 系统 | Red Hat Enterprise Linux 8.10 (Ootpa) |
| 内核 | `4.18.0-553.el8_10.x86_64` |
| 类型 | VMware 虚拟机 |
| 主要服务 | Docker + Harbor v2.11.2-201d421d |

### 操作端

| 项 | 值 |
| --- | --- |
| 系统 | Windows 10.0.26200.9445 |
| IP | `192.168.0.9/24`（WLAN），网关 `192.168.0.1` |
| SSH | OpenSSH_for_Windows_9.5p2 |

### Cloudflare 侧

| 项 | 值 |
| --- | --- |
| 域名 | `chenxw.dpdns.org`（dpdns.org 免费域名，DNS 托管在 Cloudflare） |
| hostname | `harbor.chenxw.dpdns.org` |
| 本次新建隧道 | `harbor` |
| 账号已有隧道 | `wxchenxw`（2025-12-05 创建，**本次未改动**） |

---

## 3. 架构

```
用户浏览器 / Docker 客户端
        │  HTTPS
        ▼
Cloudflare 边缘节点（104.21.84.75 / 172.67.188.165）
        │  沿 cloudflared 已建立的出站长连接回推
        ▼
192.168.0.128 上的 cloudflared 进程
        │  按 config.yml 的 ingress 规则匹配
        │  harbor.chenxw.dpdns.org → http://localhost:80
        ▼
Harbor nginx（容器，监听 0.0.0.0:80）
        │
        ▼
Harbor Core / Registry / DB / Redis
```

隧道同时向 4 个 Cloudflare 边缘机房建立连接（lax10、lax12、sjc10、sjc11），协议 QUIC，任一断开其余继续工作。

**与端口映射的区别**：端口映射把内网机器直接暴露在公网 IP 上，会被全网扫描器持续探测；Tunnel 是内网主动外连，公网侧没有任何开放端口。

---

## 4. 部署步骤

### 4.1 安装 cloudflared

使用 Cloudflare 官方 RPM 源（比 GitHub Releases 快得多，实测 4.0 MB/s）：

```bash
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg \
  -o /etc/pki/rpm-gpg/RPM-GPG-KEY-cloudflare

cat > /etc/yum.repos.d/cloudflared.repo <<'EOF'
[cloudflared]
name=cloudflared
baseurl=https://pkg.cloudflare.com/cloudflared/rpm
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-cloudflare
repo_gpgcheck=0
EOF

dnf -y --disablerepo='*' --enablerepo=cloudflared install cloudflared
```

`--disablerepo='*'` 用于跳过 RHEL 订阅源（本机未注册订阅，会报 `Unable to read consumer identity` 并拖慢速度）。

结果：cloudflared **2026.9.1**，二进制 `/usr/bin/cloudflared`。

### 4.2 浏览器登录授权

```bash
cloudflared tunnel login
```

命令会输出一个 URL。目标机无图形界面，需在**任意一台能上网的电脑**上打开该 URL，登录 Cloudflare 账号并选择域名授权。授权完成后 `cert.pem` 自动写回目标机：

```
/root/.cloudflared/cert.pem    （权限 0600）
```

> 该 URL 与正在等待的进程绑定，一次性有效。超时需重新执行。

### 4.3 创建隧道

```bash
cloudflared tunnel create harbor
```

生成凭据文件 `/root/.cloudflared/f0994a02-bf6d-4146-94f3-5af66d130105.json`（权限 `0400`）。

### 4.4 编写配置

`/etc/cloudflared/config.yml`：

```yaml
tunnel: f0994a02-bf6d-4146-94f3-5af66d130105
credentials-file: /root/.cloudflared/f0994a02-bf6d-4146-94f3-5af66d130105.json

ingress:
  - hostname: harbor.chenxw.dpdns.org
    service: http://localhost:80
    originRequest:
      httpHostHeader: harbor.chenxw.dpdns.org
      connectTimeout: 30s
      noTLSVerify: false
  - service: http_status:404
```

| 配置 | 含义 |
| --- | --- |
| `tunnel` | 指定隧道 ID |
| `credentials-file` | 隧道凭据路径 |
| `hostname` | 匹配的域名 |
| `service` | 转发到本机哪个地址 |
| `httpHostHeader` | 转发时改写 Host 头，Harbor 靠它识别请求 |
| `- service: http_status:404` | **兜底规则**：域名不匹配一律 404 |

校验配置：

```bash
cloudflared tunnel --config /etc/cloudflared/config.yml ingress validate
# 输出 OK 才通过
```

### 4.5 注册 DNS 路由

```bash
cloudflared tunnel route dns harbor harbor.chenxw.dpdns.org
```

自动创建 CNAME：`harbor.chenxw.dpdns.org` → `f0994a02-….cfargotunnel.com`。

### 4.6 安装为系统服务

```bash
cloudflared service install
```

**注意**：该命令不只写 systemd 单元文件，**会顺带启动服务**。若此时访问控制尚未配好，服务会立刻裸奔到公网。本次安装后立即停掉，确认安全后再手动启动：

```bash
systemctl stop cloudflared
systemctl disable cloudflared
```

systemd 单元 `/etc/systemd/system/cloudflared.service`：

```ini
[Service]
TimeoutStartSec=15
Type=notify
ExecStart=/usr/bin/cloudflared --no-autoupdate --config /etc/cloudflared/config.yml tunnel run
Restart=on-failure
RestartSec=5s
```

### 4.7 启动

```bash
systemctl enable --now cloudflared
```

---

## 5. 本次实际问题与处理

### 5.1 给定 IP 不通

初始地址为 `192.168.0.14`，实际不可达：

- 首次 `ping` 有回包（TTL=64），复测 10 次 ICMP **全部失败**
- `arp -a` 中**无** `192.168.0.14` 条目，说明二层 ARP 都解析不到
- 17 个常见端口（22/80/443/445/3389/5985/8080 等）全部不通
- 报错为 `Reply from 192.168.0.9: Destination host unreachable`，**由本机自己发出**

结论：目标机当时处于关机或离线状态，首次 ping 通是残留 ARP 缓存。改用 `192.168.0.128` 后正常。

> 排查要点：`ping` 通不代表机器活着，要看**回包来源**是否为自身 IP；`arp -a` 有无条目是更硬的证据。

### 5.2 GitHub 下载极慢

从 GitHub Releases 下载 `cloudflared-linux-amd64`，119 秒仅完成 10.9 MB / 39.8 MB（约 92 KB/s），超时失败。

处理：改用 **Cloudflare 官方 RPM 源**，实测 4.0 MB/s，18 MB 包 4 秒完成。见 4.1。

### 5.3 Windows 侧命令执行的三个坑

| 问题 | 现象 | 处理 |
| --- | --- | --- |
| cmd.exe 吞 `$` | 内联 PowerShell 的 `$p`、`$_` 被吃掉，脚本静默失败 | 脚本写入 `.ps1` 文件后用 `-File` 执行，不用 `-Command` 内联 |
| 远程登录 shell 非 bash | `ssh host "id; uname -a"` 报 `id; uname -a: command not found`，整条命令被当成一个文件名 | 改用 `ssh root@host bash -s < script.sh` 经 stdin 投喂 |
| CRLF 换行 | 本地 `.sh` 传到 Linux 报 `\r: command not found` | 传输前归一化为 LF |

LF 归一化用的 PowerShell 片段：

```powershell
param([string]$Path)
$t = [IO.File]::ReadAllText($Path)
$t = $t.Replace("`r`n", "`n").Replace("`r", "`n")
[IO.File]::WriteAllText($Path, $t)
```

### 5.4 残留的半成品二进制

因 5.2 下载中断，`/usr/local/bin/cloudflared` 残留一个不完整文件。RPM 安装时 `%post` 脚本建了同名符号链接指向 `/usr/bin/cloudflared`，正好覆盖。核对 md5 一致（`7d803ac2…`），二进制无问题。

---

## 6. 当前运行状态

### 服务

```
systemctl is-enabled cloudflared  -> enabled
systemctl is-active  cloudflared  -> active
```

### 隧道连接

```
NAME:  harbor
ID:    f0994a02-bf6d-4146-94f3-5af66d130105
EDGE:  1xlax10, 1xlax12, 1xsjc10, 1xsjc11
协议:  QUIC
```

### 公网实测（从外部机器验证，非源站）

| URL | 结果 | 说明 |
| --- | --- | --- |
| `https://harbor.chenxw.dpdns.org/` | 200 | Harbor Web UI 正常 |
| `https://harbor.chenxw.dpdns.org/api/v2.0/ping` | 200 | 健康检查正常 |
| `https://harbor.chenxw.dpdns.org/v2/` | 401 | registry 要求认证 |
| `https://chenxw.dpdns.org/` | 404 | 旧域名已不再提供服务 |

### Harbor 安全基线（实测）

| 项 | 值 | 评价 |
| --- | --- | --- |
| `self_registration` | `false` | 陌生人无法自行注册账号 |
| `auth_mode` | `db_auth` | 本地数据库认证 |
| `/v2/` 未认证访问 | 401 | 拦截正常 |
| `/api/v2.0/systeminfo` | 200 | 匿名可读，泄露精确版本号 |

---

## 7. 遗留问题

### 7.1 external_url 未改，外网推拉镜像会失败（重要）

`/v2/` 返回的认证挑战指向内网地址：

```
WWW-Authenticate: Bearer realm="http://192.168.0.128/service/token",service="harbor-registry"
```

公网 Docker 客户端拿到该地址后会去请求 `http://192.168.0.128/service/token`，这是私有 IP，外网不可达。

后果：

- Web UI 可正常打开
- `docker login harbor.chenxw.dpdns.org` **必然失败**

根因是 Harbor 的 `external_url` 仍为内网 IP。修改 Harbor 安装目录下的 `harbor.yml`：

```yaml
external_url: https://harbor.chenxw.dpdns.org
```

重建：

```bash
cd /path/to/harbor
./prepare
docker compose up -d
```

> 会导致 Harbor **重启 1-2 分钟**，需选择合适时间窗口。

### 7.2 Harbor 管理员默认密码未确认

Harbor 默认管理员密码为 `Harbor12345`。**若未修改，当前等于公网门户大开**，为风险最高的一项。请在 Web UI 登录确认并改为强密码。

### 7.3 旧 DNS 记录未删除

`chenxw.dpdns.org` 的 CNAME 仍在。当前不构成风险（ingress 中已无该域名，请求被兜底规则挡为 404），但会持续解析到 Cloudflare。

删除方式：Cloudflare 控制台 → **DNS → Records** → 删除该 CNAME。

> `cloudflared` 命令行只能新增记录，**不能删除**，必须走控制台或 API。
> 若 `chenxw.dpdns.org` 是 zone 根域，删除后根域将不再解析，请先确认无其他用途。

### 7.4 登录无频率限制

Harbor 登录接口若无失败锁定，公网可被持续撞库。可在 Cloudflare 免费版配置自定义 WAF 规则做 IP / 地域限制或限速（**不绑卡即可用**）。

### 7.5 版本信息泄露

`/api/v2.0/systeminfo` 匿名返回精确版本 `v2.11.2-201d421d`，相当于提供 CVE 匹配指纹。

---

## 8. 关于 Cloudflare Access

最初计划加 Access 做访问控制，最终改为仅靠 Harbor 自身认证。原因记录如下。

Cloudflare Access 属于 **Zero Trust** 体系，开通 Zero Trust 组织时**必须录入支付方式**，免费计划也不例外。官方文档原文：

> Complete your onboarding by selecting a subscription plan and **entering your payment details. If you chose the Zero Trust Free plan, this step is still needed but you will not be charged.**
> —— https://developers.cloudflare.com/cloudflare-one/setup/

要点：

- **不扣费**。免费计划 50 用户以内永久 $0，绑卡仅为反滥用验证
- 支持信用卡**或 PayPal**（国内用户常用 PayPal + 银联卡）
- **Tunnel 本身不需要绑卡**——本次使用的 `cloudflared tunnel login` 属本地管理流程，仅用区域证书调 API，完全不经过 Zero Trust

### 备选方案对比

| 方案 | 花费 / 绑卡 | 安全强度 | 代价 |
| --- | --- | --- | --- |
| Tailscale / WireGuard | 都不需要 | 最高（服务不暴露到公网） | 每台访问端需装客户端 |
| PayPal + Cloudflare Access | 不花钱，需绑 | 高 | 多一步绑定 |
| **当前方案**：裸暴露 + Harbor 认证 | 不需要 | 低 | Harbor UI/API 直接对公网 |

若仅为自己在外网访问，Tailscale 在该场景优于当前方案：不暴露任何公网入口、不需绑卡、无需担心 `/v2/` 被扫描。Access 的价值在于需要**给他人**访问。

---

## 9. 日常运维

全部命令在目标机执行。

### 状态与日志

```bash
systemctl status cloudflared
systemctl is-active cloudflared
systemctl is-enabled cloudflared

journalctl -u cloudflared -f
journalctl -u cloudflared -n 50
journalctl -u cloudflared --since "10 min ago"
```

### 隧道管理

```bash
cloudflared tunnel list
cloudflared tunnel info harbor
```

### 启停

```bash
systemctl restart cloudflared         # 改配置后
systemctl stop cloudflared            # 临时停

systemctl disable --now cloudflared   # 停 + 取消开机自启
systemctl enable --now cloudflared    # 恢复
```

### 修改 hostname 流程

```bash
# 1. 备份
cp -a /etc/cloudflared/config.yml /etc/cloudflared/config.yml.bak

# 2. 编辑 config.yml，同时改 hostname 与 httpHostHeader

# 3. 校验
cloudflared tunnel --config /etc/cloudflared/config.yml ingress validate

# 4. 注册新域名 DNS 路由
cloudflared tunnel route dns harbor <新域名>

# 5. 重启
systemctl restart cloudflared
```

---

## 10. 文件清单

### 目标机 192.168.0.128

| 路径 | 说明 |
| --- | --- |
| `/usr/bin/cloudflared` | 主程序（RPM 安装） |
| `/etc/cloudflared/config.yml` | 隧道配置 |
| `/etc/cloudflared/config.yml.bak.20260914222501` | 改 hostname 前的备份 |
| `/etc/systemd/system/cloudflared.service` | systemd 单元 |
| `/etc/yum.repos.d/cloudflared.repo` | Cloudflare 官方 RPM 源 |
| `/etc/pki/rpm-gpg/RPM-GPG-KEY-cloudflare` | 源签名公钥 |
| `/root/.cloudflared/cert.pem` | 区域证书（`0600`） |
| `/root/.cloudflared/f0994a02-….json` | 隧道凭据（`0400`） |

### Cloudflare 侧

| 对象 | 值 |
| --- | --- |
| Tunnel 名称 | `harbor` |
| Tunnel ID | `f0994a02-bf6d-4146-94f3-5af66d130105` |
| 域名 | `harbor.chenxw.dpdns.org` |
| DNS 记录 | CNAME → `f0994a02-….cfargotunnel.com` |
| 遗留记录 | `chenxw.dpdns.org` CNAME（待删除） |

---

## 11. 回滚步骤

```bash
# 1. 停止服务并取消开机自启
systemctl disable --now cloudflared

# 2. 删除隧道（同时删除凭据）
cloudflared tunnel delete harbor

# 3. 卸载程序（可选）
dnf remove cloudflared
rm -f /etc/yum.repos.d/cloudflared.repo

# 4. 删除配置与凭据（可选）
rm -rf /etc/cloudflared /root/.cloudflared
```

还需手动处理：Cloudflare 控制台 → **DNS → Records** → 删除 `harbor.chenxw.dpdns.org` 的 CNAME；如需一并删除旧记录 `chenxw.dpdns.org`。

---

## 12. 参考链接

- Cloudflare Tunnel 文档：https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/
- Zero Trust 开通说明（支付方式相关）：https://developers.cloudflare.com/cloudflare-one/setup/
- cloudflared RPM 源：https://pkg.cloudflare.com/
- Harbor 官方文档：https://goharbor.io/docs/
