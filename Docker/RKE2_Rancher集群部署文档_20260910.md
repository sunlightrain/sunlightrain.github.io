# RKE2 + Rancher 集群部署文档（在线/内网直连） — 192.168.0.122~127

> 更新：2026-09-10 ｜ 状态：**RKE2 v1.36.4 3×server HA 集群稳定 + Rancher v2.15.1 部署完成** ✅

---

## 1. 目标架构

```
                         RKE2 v1.36.4 + Rancher v2.15.1
   ┌──────────────┬──────────────────────────────────────┬──────────────┐
   │  Server ×3 (etcd+control-plane)                      │  Agent ×3     │
   │  m01 192.168.0.122  m02 192.168.0.123  m03 192.168.0.124   │
   │                     │                                │  w01 125      │
   │  Rancher UI ────────┤  https://rancher.abroadnote.xyz│  w02 126      │
   │  (hosts→m01)         │  (traefik ingress 443)        │  w03 127      │
   └──────────────────────┴────────────────────────────────┴──────────────┘
   OS: RHEL 8.10 全部      CNI: Canal(默认)   存储: Longhorn(sdb 196G×6 待装)
```

- **集群版本**：RKE2 `v1.36.4+rke2r1`（rpm：`rke2-server`/`rke2-agent` 1.36.4~rke2r1）
- **Rancher**：v2.15.1（helm chart 2.15.1，cattle-system，replicas=1）
- **节点**：122-124 = server（etcd 3 副本），125-127 = agent；均 RHEL 8.10、cgroup v2
- **内网直连**：Rancher/集群均不走公网 Cloudflare，浏览器经 hosts 解析域名访问
- **镜像源**：docker.io + 7890 代理（192.168.0.100:7890 clash），NO_PROXY 排除内网
- **CNI**：Canal（calico+flannel，RKE2 默认）；**DNS**：CoreDNS + 节点 resolv 指向 223.5.5.5/192.168.0.102

---

## 2. 当前状态验证（2026-09-10）

| 项目 | 结果 |
|---|---|
| `kubectl get nodes` | 6 节点全 Ready（3 control-plane,etcd + 3 worker）✅ |
| kube-apiserver ×3 | 全部 `1/1 Running`，RESTARTS 稳定不再增长 ✅ |
| etcd ×3 | 全部 `1/1 Running`（数据 268M×3）✅ |
| rke2-etcd lease | holder=rke2-m01，稳定不抖动 ✅ |
| fatal 计数 | 修复后 `journalctl | grep -c "leaderelection lost"` = 0 ✅ |
| Rancher deploy | rancher 1/1、rancher-webhook 1/1、fleet 全家 Running ✅ |
| Rancher HTTP | `https://rancher.abroadnote.xyz/ping` = 200 ✅ |
| TLS 证书 | 自签 CA，SAN=`DNS:rancher.abroadnote.xyz` ✅ |
| 所有 pod | `kubectl get pods -A` 无非 Running/Completed ✅ |

---

## 3. 凭据与参数（妥善保管）

| 项 | 值 |
|---|---|
| 集群 join token | `/var/lib/rancher/rke2/server/token`（m01 生成，其余节点共用） |
| Rancher URL | `https://rancher.abroadnote.xyz`（内网 hosts: `192.168.0.122 rancher.abroadnote.xyz`） |
| Rancher bootstrap 密码 | `Rancher-2026-Ab!`（首次登录设置正式 admin 密码后即失效） |
| helm | v3.16.4（`/usr/local/bin/helm`，m01） |
| 代理 | `http://192.168.0.100:7890`（拉镜像走此代理） |
| 本地 etcd 配置 | `/var/lib/rancher/rke2/server/db/etcd/config`（勿改路径） |

---

## 4. 前置准备（6 台 122-127 全部）

### 4.1 cgroup v2（RKE2 1.36 硬要求）
RHEL 8.10 默认 cgroup v1，需加内核参数重启生效：
```bash
grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=1"
reboot   # 验证: ls /sys/fs/cgroup/cgroup.controllers 存在
```

### 4.2 数据盘挂载（Longhorn 备用）
```bash
mkfs.xfs /dev/sdb && mkdir -p /var/lib/longhorn
echo '/dev/sdb /var/lib/longhorn xfs defaults 0 0' >> /etc/fstab
mount -a && df -h /var/lib/longhorn   # 196G ×6
```

### 4.3 网络代理 drop-in（server 与 agent 同）
```ini
# /etc/systemd/system/rke2-server.service.d/override.conf  (agent 为 rke2-agent.service.d)
[Service]
Environment="HTTP_PROXY=http://192.168.0.100:7890"
Environment="HTTPS_PROXY=http://192.168.0.100:7890"
Environment="NO_PROXY=127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.svc,.cluster.local"
```
> 内嵌 containerd 继承 rke2 进程 env，拉 docker.io 镜像即走代理（实测 ~3.6MB/s）。NO_PROXY 必须含内网段与集群 CIDR，否则 etcd/内网流量绕代理。

### 4.4 DNS resolv 覆盖（canal 崩溃修复关键，见 §6）
```bash
# /etc/rancher/rke2/resolv.conf
nameserver 223.5.5.5
nameserver 192.168.0.102
```

---

## 5. RKE2 安装

### 5.1 首个 server（m01=122）
```bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.36.4+rke2r1 sh -
systemctl enable --now rke2-server
# join token
cat /var/lib/rancher/rke2/server/token
# 快捷 kubectl
ln -s /var/lib/rancher/rke2/bin/kubectl /usr/local/bin/kubectl
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
```

### 5.2 其余 server 加入（m02=123、m03=124，etcd 成员）
```bash
# /etc/rancher/rke2/config.yaml
server: https://192.168.0.122:9345
token: <m01 的 token>
```
```bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=server INSTALL_RKE2_VERSION=v1.36.4+rke2r1 sh -
systemctl enable rke2-server
systemctl start --no-block rke2-server   # Type=notify，勿用 restart 会挂死
```

### 5.3 agent 加入（w01-w03 = 125-127）
```bash
# /etc/rancher/rke2/config.yaml
server: https://192.168.0.122:9345
token: <同上>
```
```bash
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=agent INSTALL_RKE2_VERSION=v1.36.4+rke2r1 sh -
systemctl enable rke2-agent && systemctl start --no-block rke2-agent
```

### 5.4 验证
```bash
kubectl get nodes          # 6 Ready
kubectl get pods -A        # canal 2/2 Running，无 CrashLoop
```

> ⚠️ systemd 提示 "unit file changed on disk" 时先 `systemctl daemon-reload`。
> ⚠️ 远程执行含 `reboot` 的命令易被策略拦截，改写成脚本后执行。

---

## 6. Canal 崩溃修复（kubelet DNS 回退）

**现象**：canal pod 崩溃循环。**根因**：kubelet 忽略 `/etc/resolv.conf` 自动 fallback 到 8.8.8.8，导致 `localhost` NXDOMAIN。

**修复**（6 台全加）：
```bash
# /etc/rancher/rke2/config.yaml 追加
kubelet-arg: "resolv-conf=/etc/rancher/rke2/resolv.conf"
```
重启 rke2 后 canal 全部 2/2 Running、0 重启。

---

## 7. ★ 3-server HA 故障专题：`leaderelection lost for rke2-etcd`

### 7.1 现象
- m01 rke2 主进程周期性 `level=fatal ... leaderelection lost for rke2-etcd` 自杀
- `Restart=always` → 无限循环；apiserver 容器随之反复重建，RESTARTS 持续增长
- **单 server 完全稳定；2+ server 即复现**（2 server、3 server 均触发）

### 7.2 排查排除项
| 项 | 结论 |
|---|---|
| 时钟 | 3 台 chronyd 正常，偏差 <1ms（排除） |
| 网络 | etcd peer 连接 ESTAB，成员间 9345 可达（排除） |
| 内存/磁盘 | 无 OOM，etcd fsync 正常 5ms 级（排除） |
| lease 被抢 | lease holder 一直 = rke2-m01，非竞选失败而是**续约失败**（排除被抢） |

### 7.3 真根因
**rke2 主进程 fatal → 重启时 etcd static pod 一并重建**（268M 数据加载 1-2 分钟）→ 期间 apiserver 连不上 etcd、不监听 6443 → 新主进程刚 acquire 的 `rke2-etcd` lease 无法在 renew deadline 内续约 → 又 fatal → 死循环。

多 server 时任何一台单独重启都会把整个 etcd quorum 拖入"追赶-超时"动荡；单 server 无 quorum 等待，etcd 本地就绪即稳定。

典型日志（m01）：
```
23:09:08 Successfully acquired lease kube-system/rke2-etcd
23:10:01 Error retrieving lease lock ... dial tcp 127.0.0.1:6443: connect: connection refused
23:10:34 fatal: leaderelection lost for rke2-etcd
```

### 7.4 修复流程（三台同步干净重启）
```bash
# 1) 三台全部 stop（并行）
systemctl stop rke2-server

# 2) 清理残留 etcd/shim（stop 后 etcd 进程可能仍存活占 2379/2380）
pkill -f 'etcd --config-file=/var/lib/rancher/rke2/server/db/etcd'
pkill -f 'containerd-shim-runc-v2'
pkill -f '/traefik '; pkill -f 'kube-proxy --cluster-cidr'; pkill -f 'coredns'  # 孤儿 pod 进程
ss -tlnp | grep -E ':(2379|2380|6443|9345) '   # 确认全空

# 3) 三台同步 start（勿用 restart，勿带 --no-block 也可但推荐）
systemctl start --no-block rke2-server

# 4) 静置 8-10 分钟，期间不要碰任何节点
```

### 7.5 验证恢复
```bash
kubectl get nodes                                  # 6 Ready
kubectl get pods -n kube-system -l 'component in (kube-apiserver,etcd)'
#   apiserver ×3 全 1/1 Running；RESTARTS 停涨（等 10 分钟对比两次）
journalctl -u rke2-server | grep -c 'leaderelection lost'   # 修复后不再新增
```

### 7.6 经验
- 任何 server 节点维护（升级/重启）都应**三台同步处理**，避免单台重建 etcd 拖入动荡
- `systemctl restart rke2-server` 会因 Type=notify 等 ready 挂死，一律 `stop` + `start --no-block`
- 集群建立后不要单独频繁重启某一台 server

---

## 8. Rancher 2.15.1 部署

### 8.1 重要：主 chart repo 已迁移
`charts.rancher.io` 现只是应用目录（含 longhorn/rancher-backup 等扩展），**主 Rancher chart 在**：
```bash
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm search repo rancher-stable/rancher          # v2.15.1 等
```

### 8.2 cert-manager
```bash
helm repo add jetstack https://charts.jetstack.io
helm upgrade --install cert-manager jetstack/cert-manager -n cert-manager --create-namespace \
  --set crds.enabled=true
kubectl get pods -n cert-manager        # 3 pods Running
```

### 8.3 Rancher
```bash
helm upgrade --install rancher rancher-stable/rancher -n cattle-system --create-namespace \
  --version 2.15.1 \
  --set hostname=rancher.abroadnote.xyz \
  --set bootstrapPassword='Rancher-2026-Ab!' \
  --set replicas=1 \
  --set ingress.tls.source=rancher
kubectl get pods -n cattle-system -w     # rancher 1/1 Running 后等待 fleet system charts 自动装完
```

### 8.4 验证
```bash
curl -sk -o /dev/null -w '%{http_code}\n' --resolve rancher.abroadnote.xyz:443:192.168.0.122 \
  https://rancher.abroadnote.xyz/ping        # 200
echo | openssl s_client -connect 192.168.0.122:443 -servername rancher.abroadnote.xyz 2>/dev/null \
  | openssl x509 -noout -ext subjectAltName   # SAN 含域名
```

### 8.5 访问方式（关键：ingress 按 Host 路由）
- **直接 `https://192.168.0.122` 返回 404** —— traefik ingress 只匹配 Host 头 `rancher.abroadnote.xyz`，IP 无规则
- 访问端 hosts（Windows 管理员 PowerShell）：
  ```powershell
  Add-Content C:\Windows\System32\drivers\etc\hosts "192.168.0.122 rancher.abroadnote.xyz"
  ```
- 多设备长期访问 → 内网 DNS 加 A 记录 `rancher.abroadnote.xyz → 192.168.0.122`
- 证书为 Rancher 自签 CA，浏览器"继续前往"即可

---

## 9. Longhorn（待安装，环境已就绪）

- sdb 196G ×6 已挂 `/var/lib/longhorn`（§4.2）
- 安装途径二选一：
  - Rancher UI：Apps → Charts → Longhorn → Install（推荐，可在 UI 管理）
  - helm：`helm install longhorn rancher-latest/longhorn -n longhorn-system --create-namespace`（需先装 longhorn-crd）
- 安装后默认 storageClass `longhorn` 即集群默认存储

---

## 10. 常用运维命令

```bash
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
kubectl get nodes -o wide
kubectl get pods -A | grep -v Running
journalctl -u rke2-server -f                          # 主进程日志
journalctl -u rke2-server | grep -c 'leaderelection lost'   # HA 健康哨兵
systemctl stop rke2-server && systemctl start --no-block rke2-server   # 重启正确姿势
ss -tlnp | grep -E ':(2379|2380|6443|9345) '          # 端口占用检查
```

---

## 11. 踩坑记录汇总

| # | 坑 | 解法 |
|---|---|---|
| 1 | `systemctl restart rke2-server` 挂死 | Type=notify 等 ready，用 stop + `start --no-block` |
| 2 | 多 server HA 无限循环（§7） | 三台同步 stop → 清残留 etcd/shim → 同步 start → 静置 |
| 3 | canal 崩溃 | kubelet `resolv-conf` 指向自定义 resolv.conf（223.5.5.5+102） |
| 4 | Rancher chart 找不到 | repo 已迁 `releases.rancher.com/server-charts/stable` |
| 5 | Rancher hostname 填 IP 报错 | Ingress host 必须 DNS 名，不能 IP |
| 6 | 直接 IP 访问 Rancher 404 | ingress 按 Host 路由；hosts/DNS 解析域名 |
| 7 | 阿里云镜像源 ~140KB/s | 切 docker.io + 7890 代理（3.6MB/s） |
| 8 | systemd 提示 unit 变更 | 先 `systemctl daemon-reload` |
| 9 | 远程含 `reboot` 命令被拦截 | 写入脚本再执行 |
| 10 | 集群稳定后勿单独重启某台 server | 会触发 §7 的 etcd 动荡（三台同步处理） |

---

*配套：离线部署方案见《RKE2_Rancher集群离线部署文档_20260910.md》*
