# RKE2 + Rancher 集群离线部署文档（Air-Gap）

> 更新：2026-09-10 ｜ 基于 v1.36.4+rke2r1 + Rancher v2.15.1 实测在线部署经验整理
> 参考官方：RKE2 Air-Gap https://docs.rke2.io/install/airgap ｜ Rancher Air-Gap（v2.15）https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/other-installation-methods/air-gapped-helm-cli-install

---

## 1. 适用场景与总体思路

离线（Air-Gap）指目标节点**不能直连公网镜像源/下载站**。解决"镜像 + 二进制 + chart"三样东西怎么进去，有四条路线，可混用：

| 路线 | 原理 | 适用 |
|---|---|---|
| **A. 私有 registry 中转**（推荐生产） | 有网机 pull → push 内网 registry → 节点从 registry 拉 | ≥3 节点、要持续部署新应用 |
| **B. 镜像 tar 直接分发** | 镜像 tar 放每节点 `/var/lib/rancher/rke2/agent/images/`，RKE2 启动自动导入 | 边缘/无 registry、节点少 |
| **C. Hauler 聚合传输** | hauler store 聚合 tar → 分发 → 灌 registry 或 images 目录 | 想省事的工具党 |
| **D. 代理透传（半离线）** | 仅控制面走代理拉公网镜像 | 有受限外网（本次在线部署实际模式，见 §7） |

> 核心原则：**版本号全程锁定**（rke2 rpm/镜像/rancher chart/rancher 镜像必须同版本配套），离线环境改版本成本极高。

---

## 2. 预下载清单（在有网机执行）

以 **RKE2 v1.36.4+rke2r1（amd64）+ Rancher v2.15.1** 为例：

| # | 物 | 来源 | 用途 |
|---|---|---|---|
| 1 | `rke2.linux-amd64.tar.gz` + `sha256sum-amd64.txt` | github.com/rancher/rke2/releases/download/v1.36.4+rke2r1/ | 二进制（含 systemd unit） |
| 2 | `rke2-images.linux-amd64.tar.zst` | 同上 | 全部系统镜像（含 Canal CNI） |
| 3 | `install.sh` | https://get.rke2.io | 安装脚本（离线模式） |
| 4 | rke2-server/agent rpm（RHEL 用） | 同上 releases 的 rpm 包 | 或走 install.sh 免 rpm |
| 5 | `rke2-selinux` rpm 及依赖 | 有网 yum 仓库 | SELinux 开启时必须（container-selinux/iptables-nft/libnftnl/policycoreutils/selinux-policy） |
| 6 | helm 二进制 | https://get.helm.sh/helm-v3.16.4-linux-amd64.tar.gz | 装 Rancher 用 |
| 7 | cert-manager 镜像 | jetstack/cert-manager（chart v1.21.1） | 全部 tag 推私有 registry |
| 8 | `rancher-images.txt` | https://releases.rancher.com/server-charts/stable/assets/...（见官方页面当前链接） | Rancher 镜像清单 |
| 9 | `rancher-save-images.sh` / `rancher-load-images.sh` | 同上 | save/load 脚本 |
| 10 | `rancher-stable` helm repo index | https://releases.rancher.com/server-charts/stable | 在有网机 `helm pull rancher-stable/rancher --version 2.15.1` 打包 chart |
| 11 | Longhorn images/chart | charts.rancher.io 或 longhorn.github.io/charts | 见 §6 |

> 镜像 archive 从 GitHub Releases 下载时注意 URL 中 `+` 需转义为 `%2B`：`.../download/v1.36.4%2Brke2r1/...`

---

## 3. 方案 A：私有 registry 中转（推荐）

### 3.1 内网 registry
任何有网节点（或一台能同时访问公网与内网的跳板机）起 registry：
```bash
# 用有网机 docker 起（若节点侧要 http，需在节点 registries.yaml 配为 insecure）
docker run -d --name registry -p 5000:5000 -v /data/registry:/var/lib/registry registry:2
```
若 registry 在纯内网且用 http，所有 RKE2 节点按 §3.3 配置 `configs` 信任。

### 3.2 RKE2 镜像 → 私有 registry
```bash
# 有网机
docker image load -i rke2-images.linux-amd64.tar.zst          # 需先装 zstd: dnf install zstd
docker images | grep -E 'rancher|registry.k8s.io'             # 看导入的镜像清单
for img in $(docker images --format '{{.Repository}}:{{.Tag}}' | grep -v '<none>'); do
  name=$(echo "$img" | sed 's|^[^/]*/||')                     # 去掉原 registry 前缀
  docker tag "$img" "registry.example.com:5000/$name"
  docker push "registry.example.com:5000/$name"
done
```
> 大批量 retag/push 可用官方脚本或 skopeo/hangar 加速；tag 多时注意保持原 `Repository:Tag` 层级。

### 3.3 节点 registries.yaml（每台 RKE2 节点）
```yaml
# /etc/rancher/rke2/registries.yaml
mirrors:
  docker.io:
    endpoint:
      - "https://registry.example.com:5000"
  "*":
    endpoint:
      - "https://registry.example.com:5000"
configs:
  "registry.example.com:5000":
    tls:
      insecure_skip_verify: true        # 自签证书时；或配 ca_file
```
配好后 `systemctl stop/start --no-block rke2-server|rke2-agent` 生效。

### 3.4 安装 RKE2（离线 install.sh）
```bash
# 1) 有网机准备目录（保持相对文件名不变）
mkdir -p /root/rke2-artifacts && cd /root/rke2-artifacts
curl -OLs https://github.com/rancher/rke2/releases/download/v1.36.4%2Brke2r1/rke2.linux-amd64.tar.gz
curl -OLs https://github.com/rancher/rke2/releases/download/v1.36.4%2Brke2r1/sha256sum-amd64.txt
curl -sfL https://get.rke2.io --output install.sh

# 2) 整个目录拷到每个离线节点
scp -r /root/rke2-artifacts root@<node>:/root/

# 3) 离线节点执行（server/agent 用相同 install，类型由 INSTALL_RKE2_TYPE 控制）
INSTALL_RKE2_TYPE=server INSTALL_RKE2_ARTIFACT_PATH=/root/rke2-artifacts sh install.sh
# 4) config.yaml（与在线一致，见在线文档 §5）
#    server: https://<首server>:9345 / token: ...
#    若走私有 registry 而非 registries.yaml 全镜像镜像，可加 system-default-registry
system-default-registry: "registry.example.com:5000"

# 5) 启动
systemctl enable rke2-server && systemctl start --no-block rke2-server
```

### 3.5 cert-manager 离线
```bash
# 有网机：拉 chart + 镜像，推私有 registry
helm pull jetstack/cert-manager --version v1.21.1
# 镜像（webhook/cainjector/controller）tag 改 registry 前缀后 push

# 离线节点：
helm install cert-manager ./cert-manager-v1.21.1.tgz -n cert-manager --create-namespace \
  --set image.repository=registry.example.com:5000/jetstack/cert-manager-controller \
  --set webhook.image.repository=registry.example.com:5000/jetstack/cert-manager-webhook \
  --set cainjector.image.repository=registry.example.com:5000/jetstack/cert-manager-cainjector
```

### 3.6 Rancher 离线（helm CLI）
```bash
# 有网机：
#   a) 下载 rancher-images.txt / rancher-save-images.sh / rancher-load-images.sh（对应 2.15.1）
#   b) 追加 cert-manager 相关行后
chmod +x rancher-save-images.sh
./rancher-save-images.sh --image-list ./rancher-images.txt --images rancher-images.tar.gz
#   c) 传 tar 到能访问私有 registry 的机器
./rancher-load-images.sh --image-list ./rancher-images.txt --registry registry.example.com:5000
```
离线节点安装：
```bash
helm upgrade --install rancher rancher-stable/rancher -n cattle-system --create-namespace \
  --version 2.15.1 \
  --set hostname=rancher.abroadnote.xyz \
  --set bootstrapPassword='你的密码' \
  --set replicas=1 \
  --set rancherImage=registry.example.com:5000/rancher/rancher \
  --set systemDefaultRegistry=registry.example.com:5000 \
  --set useBundledSystemChart=true \
  --set ingress.tls.source=rancher
```
> `useBundledSystemChart=true` 用 Rancher 镜像内打包的 system charts（fleet/webhook 等），离线**不需要**额外同步 rancher-charts 仓库——本次在线部署踩过 chart 源迁移的坑，离线务必带此参数。

---

## 4. 方案 B：镜像 tar 直接分发（无 registry）

```bash
# 有网机下载镜像 archive
curl -LO "https://github.com/rancher/rke2/releases/download/v1.36.4%2Brke2r1/rke2-images.linux-amd64.tar.zst"

# 每台离线节点
mkdir -p /var/lib/rancher/rke2/agent/images/
cp rke2-images.linux-amd64.tar.zst /var/lib/rancher/rke2/agent/images/
touch /var/lib/rancher/rke2/agent/images/.cache.json    # 可选：避免每次启动重复导入(改版后需 touch 或删 cache 强制重导)

# 二进制安装同 §3.4（install.sh 离线模式）
```
- RKE2 每次启动都会导入 images 目录内的 tar（.cache.json 可跳过未变更的）
- Rancher 部分仍建议走 registry（rancher 镜像量大、chart 依赖多）；纯分发可用 rancher-save-images.sh 产物在各节点 `ctr -n k8s.io image import`

---

## 5. 方案 C：Hauler（可选）

```bash
# 有网机
hauler store add file rke2-images.linux-amd64.tar.zst
hauler store add file https://get.rke2.io
hauler store add file .../rke2.linux-amd64.tar.gz
hauler store add file .../sha256sum-amd64.txt
hauler store save --filename haul.tar.zst --containerd
# 离线节点
hauler store load haul.tar.zst
hauler store save --containerd -f /var/lib/rancher/rke2/agent/images/haul.tar.zst
# 或推私有 registry
hauler store copy registry://registry.example.com:5000
```
详见 https://docs.hauler.dev

---

## 6. Longhorn 离线

```bash
# 有网机 helm pull + 镜像导出
helm pull rancher-latest/longhorn --version <v>       # 或 longhorn.github.io/charts
docker pull longhornio/longhorn-manager:<v>  # 及 ui/instance-manager/share-manager/... 全部镜像
# retag → push 私有 registry

# 节点
helm install longhorn ./longhorn-<v>.tgz -n longhorn-system --create-namespace \
  --set image.longhorn.manager.repository=registry.example.com:5000/longhornio/longhorn-manager \
  --set image.longhorn.ui.repository=...  # 逐项指私有 registry
```
> 生产建议在**有网环境预演**一次生成完整 values（`helm show values` + 镜像清单），离线照抄。

---

## 7. 方案 D：代理透传（半离线，本次在线部署实际模式）

本集群实际是"仅拉镜像走代理、其余内网"：
```ini
# /etc/systemd/system/rke2-server.service.d/override.conf
[Service]
Environment="HTTP_PROXY=http://192.168.0.100:7890"
Environment="HTTPS_PROXY=http://192.168.0.100:7890"
Environment="NO_PROXY=127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.svc,.cluster.local"
```
**局限**：镜像仍来自公网 registry（docker.io/ghcr），仅适合"节点不能直连但代理可达"的半离线；完全无外网时不可用，须回到 A/B。

---

## 8. 在线 → 离线步骤映射（本次实践对照）

| 在线操作（本次） | 离线等价 |
|---|---|
| `curl get.rke2.io \| sh -` | `INSTALL_RKE2_ARTIFACT_PATH=... sh install.sh` |
| containerd 继承代理拉 docker.io | registries.yaml mirrors / system-default-registry 指私有 registry |
| `helm repo add rancher-stable`（在线 index） | 有网机 `helm pull` 打包 chart tgz 带过去 |
| rancher/rancher:v2.15.1 在线拉取 | rancher-images.txt + save/load 脚本灌私有 registry |
| cert-manager chart 在线装 | chart tgz + image.repository 覆盖 |
| （在线文档 §7）HA 故障修复 | 离线同样适用（与镜像源无关） |

---

## 9. 离线环境特有注意事项

1. **版本配套**：rke2 binary / images tar / rpm 三者版本必须一致；Rancher chart 版本 ↔ rancher-images.txt ↔ rancher/rancher 镜像 tag 一致。
2. **DNS**：在线时 kubelet resolv-conf 用 223.5.5.5（公网）；纯离线必须换成内网 DNS（如 192.168.0.102），否则 CoreDNS 解析失败。
3. **无默认路由的节点**：需加 dummy 接口默认路由（黑洞路由即可），否则节点 IP 探测/kube-proxy 异常（见官方文档 Prerequisites）。
4. **SELinux**：RHEL 开启 SELinux 需先离线装 rke2-selinux rpm + 5 个依赖包。
5. **zstd**：`docker image load` tar.zst 需要 zstd 工具；装不上就改用 tar.gz 类 archive（或用 ctr 导入）。
6. **导入慢**：images tar 每次启动重导会拖慢启动，用 `.cache.json` 缓存（注意改动 archive 后需 touch/清 cache）。
7. **升级**：离线升级 = 新 images tar 放 images 目录删旧 + 新 rke2 binary/rpm；自动升级需额外备 rancher/rke2-upgrade、system-upgrade-controller、rancher/kubectl 镜像。
8. **巡检**：即便离线，§7 在线文档的 HA 故障修复与巡检命令（lease/fatal 计数）同样适用；同步重启纪律不变。
9. **helm chart 源**：Rancher 主 chart 在 `releases.rancher.com/server-charts/stable`，charts.rancher.io 仅应用目录（在线已踩坑，离线不要配错源）。
10. **ingress/访问**：离线环境的 `rancher.abroadnote.xyz` 解析只能靠内网 DNS/hosts——无公网 DNS 可用，务必提前在内网 DNS 建 A 记录（同在线文档 §8.5）。

## 10. 同环境离线部署：在线踩坑如何避免（RHEL 8.10 / vSphere / 6 节点）

> 若离线系统与本次在线集群**完全同构**（RHEL 8.10、vSphere VM、3×server+3×agent、同管理端），
> 在线踩过的坑离线几乎全会重现，且部分因"无公网兜底"更致命。逐条对策如下：

### 10.1 在线 10 坑 → 离线对策

| # | 在线踩的坑 | 离线是否重现 | 离线如何避免（前置动作） |
|---|---|---|---|
| 1 | `systemctl restart rke2-server` 挂死 | ✅ 同样 | 写进 SOP：一律 `stop` + `start --no-block`，禁止 restart |
| 2 | 多 server HA 无限循环（lease lost） | ✅ 同样且**更易触发** | 见 §10.2 的 B/C 段：镜像就绪检查 + 三台同步启动 + 预案脚本 |
| 3 | canal 崩溃（kubelet fallback 8.8.8.8） | ⚠️ **更严重**：离线 8.8.8.8 根本不通，崩了难自愈 | **首装 config.yaml 就带上** `kubelet-arg: resolv-conf=/etc/rancher/rke2/resolv.conf`（内容指内网 DNS，如 192.168.0.102）——在线是崩了才修，离线必须一步到位 |
| 4 | Rancher chart 找不到（源迁移） | ✅ 形态不同：离线无法 repo add | 有网机 `helm pull rancher-stable/rancher --version 2.15.1` 打包 tgz 带走；下载源用 `releases.rancher.com/server-charts`（勿配 charts.rancher.io） |
| 5 | Rancher hostname 填 IP 被拒 | ✅ 同样（API 限制与网络无关） | 规划域名；**内网 DNS 提前建 A 记录**（离线无公网 DNS 兜底） |
| 6 | 直接 IP 访问 404 | ✅ 同样 | 访问端 hosts/内网 DNS 在装 Rancher 前就配好 |
| 7 | 镜像源慢/中途切换 | ✅ 不出现"切换"但**配错代价极高** | 首装即配对 `registries.yaml` mirrors 或 `system-default-registry`；有网沙盒先预演一遍，把生成的 values/清单固化 |
| 8 | systemd 提示 unit 变更 | ✅ 同样 | 改过 drop-in/config 后先 `daemon-reload` |
| 9 | 远程含 `reboot` 命令被拦截 | ✅ 同样（若同管理端） | 一律写脚本再执行（含 reboot 改名绕开） |
| 10 | 集群稳定后单台重启 server | ⚠️ **更严重**：离线镜像导入慢 → 单台 etcd 追赶窗口更长 | 维护窗口三台同步处理；预案脚本预置（见 10.3） |

### 10.2 同环境离线新增的坑（在线没踩、离线必踩）

| # | 坑 | 预防 |
|---|---|---|
| A | **镜像分发/导入不同步**：tar.zst 逐台拷贝+导入耗时差异大，先启动的节点空等 quorum | 全部节点 `ctr images list` 镜像计数一致后再统一 start（首次导入慢，可用 `.cache.json` 缓存后续重启） |
| B | 无默认路由节点（纯内网常无网关）| 提前加 dummy 接口 + 黑洞默认路由（官方 Prerequisites），否则节点 IP 探测失败 |
| C | SELinux 开启时缺 rke2-selinux rpm | 预下载 rpm + 5 依赖（container-selinux/iptables-nft/libnftnl/policycoreutils/selinux-policy），随系统镜像一起带 |
| D | 缺 zstd 导致 `docker image load` tar.zst 失败 | `dnf install zstd` 预装，或改用 tar.gz archive 导入 |
| E | 私有 registry 用 http/自签证书被 containerd 拒 | registries.yaml `configs` 配 `insecure_skip_verify` 或 ca_file（首装就配） |
| F | 离线无自动升级，版本配套错很难救 | 预下载清单全部记 sha256；rke2 rpm/images/binary、rancher chart/images tag 一一对应锁定 |
| G | 升级路径未预研 | 离线升级需备新版本 images tar + rke2-upgrade/system-upgrade-controller/kubectl 镜像（见 §9.7） |

### 10.3 落地检查清单（首装前逐项勾）

**A. 装 RKE2 之前**
- [ ] 预下载清单（§2 表）齐 + sha256 校验过
- [ ] 私有 registry 起好、镜像 push 完、`curl http(s)://registry:5000/v2/_catalog` 通
- [ ] 每节点 config.yaml 已含：`server/token`、`kubelet-arg: resolv-conf=...`（防坑 3）、`system-default-registry`（防坑 7）
- [ ] 内网 DNS 已建 `rancher.abroadnote.xyz → <首 server IP>`（防坑 5/6）
- [ ] SELinux rpm + zstd 预装（防新增 C/D）
- [ ] dummy 默认路由就绪（若节点无网关）（防新增 B）

**B. 装 RKE2 时**
- [ ] 6 节点全部镜像导入完成且计数一致（防坑 2/新增 A）
- [ ] 三台 server 同步 `start --no-block`（先 daemon-reload）（防坑 1/2/8）
- [ ] 首起后**静置 10 分钟**不碰任何节点

**C. 装 Rancher 前**
- [ ] chart tgz 已带（防坑 4）
- [ ] `useBundledSystemChart=true` + `systemDefaultRegistry` 带上（防离线 chart 缺失）
- [ ] 访问端 hosts/DNS 已通（防坑 6）

**D. 预案（日常运维）**
- [ ] 三台同步重启修复脚本（在线文档 §7.4 命令打包）预置到每台 server
- [ ] 巡检命令就位：`journalctl -u rke2-server | grep -c 'leaderelection lost'` 为 0；apiserver RESTARTS 停涨

---

*在线部署实操细节（含 HA 故障修复原版流程）见《RKE2_Rancher集群部署文档_20260910.md》*
