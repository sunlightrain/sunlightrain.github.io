# 192.168.56.128 Docker 统计与清理记录

统计时间：2026-09-11  
主机：`192.168.56.128`（`boot.local`，RHEL/CentOS 8）  
Docker：`29.0.0` / Compose `v2.40.3`

---

## 1. 磁盘对比

| 阶段 | 根分区占用 | 可用 | 使用率 |
| --- | --- | --- | --- |
| 清理前 | 43G / 96G | 54G | **45%** |
| 清理后（当前） | **25G / 96G** | **72G** | **26%** |

本次约腾出 **18GB**。

---

## 2. 当前 Docker 用量摘要

| 类型 | 数量 | 占用 | 可回收（工具估算） |
| --- | --- | --- | --- |
| Images | 10 个活跃（去重 ID） | 7.906GB | Docker 29 显示 100% 为统计口径问题，**实际均在使用，勿 prune -a** |
| Containers | 10 个，全部 Running | 可写层 476.2MB | 0B |
| Local Volumes | 6 个（5 个在用） | 3.673GB | **3.605GB**（见下文匿名卷） |
| Build Cache | 0 | 0B | 0B |

---

## 3. 当前运行容器

| 名称 | 镜像 | 状态 | 端口 | 可写层 |
| --- | --- | --- | --- | --- |
| patchmon-server-1 | ghcr.io/patchmon/patchmon-server:latest | healthy | **3001** | 0B |
| patchmon-database-1 | postgres:17-alpine | healthy | 内部 5432 | 4.1kB |
| patchmon-redis-1 | redis:7-alpine | healthy | 内部 6379 | 0B |
| patchmon-guacd-1 | guacamole/guacd:1.6.0 | healthy | 内部 4822 | 0B |
| homepage | ghcr.io/gethomepage/homepage:latest | healthy | **3000** | 106kB |
| vaultwarden | 10.68.37.208/library/vaultwarden/server:latest | healthy | 经 Caddy | 0B |
| caddy | 10.68.37.208/library/vaultwarden/caddy:latest | Up | **80 / 443** | 258kB |
| rackpeek | aptacode/rackpeek:latest | healthy | **880** | 12.3kB |
| portainer | portainer/portainer-ce:sts | Up | **9443** | 0B |
| maxkb | registry.fit2cloud.com/maxkb/maxkb | Up | **8080** | **476MB** |

访问入口：

- PatchMon：http://192.168.56.128:3001
- Homepage：http://192.168.56.128:3000
- MaxKB：http://192.168.56.128:8080
- RackPeek：http://192.168.56.128:880
- Portainer：https://192.168.56.128:9443
- Vaultwarden：经 80/443（Caddy）

---

## 4. 当前镜像清单

同一 `IMAGE ID` 的多标签不重复占空间。

| 仓库 | 标签 | ID 前缀 | 大小 | 用途 |
| --- | --- | --- | --- | --- |
| ghcr.io/patchmon/patchmon-server | latest | 9eba4008c8e2 | 752MB | PatchMon |
| postgres / docker.m.daocloud.io/library/postgres | 17-alpine | 18cfe3ef5e68 | 422MB | PatchMon DB |
| redis / docker.m.daocloud.io/library/redis | 7-alpine | ff02b58f971e | 56.8MB | PatchMon Redis |
| guacamole/guacd / docker.m.daocloud.io/guacamole/guacd | 1.6.0 | 8974eaa9ba32 | 376MB | PatchMon RDP |
| registry.fit2cloud.com/maxkb/maxkb | latest | eefa1f4fdabe | **4.48GB** | MaxKB |
| aptacode/rackpeek | latest | 5138a35a3f1b | 439MB | RackPeek |
| ghcr.io/gethomepage/homepage | latest | cc84f2f5eb3c | 373MB | 首页 |
| portainer/portainer-ce 与 10.68.37.208/library/portainer-ce | sts | df76590a901e | 246MB | Portainer |
| 10.68.37.208/library/vaultwarden/server | latest | 8e78ab4188b4 | 329MB | 密码库 |
| 10.68.37.208/library/vaultwarden/caddy | latest | e6f10676251c | 86.7MB | 反代 |

去重后约 **10 个镜像层，合计 ~7.9GB**。

---

## 5. 当前数据卷

| 卷名 | LINKS | 大小 | 说明 |
| --- | --- | --- | --- |
| patchmon_postgres_data | 1 | 67.92MB | PatchMon 数据库，保留 |
| patchmon_redis_data | 1 | 8.5kB | PatchMon Redis，保留 |
| portainer_data | 1 | 526kB | Portainer，保留 |
| rackpeek_rackpeek-config | 1 | 2.2kB | RackPeek，保留 |
| bd7777ee6545... | 1 | 0B | 匿名卷，有容器引用 |
| **63f714f3edcb...** | **0** | **3.605GB** | **无容器引用，可回收** |

`docker system df` 中 “Volumes RECLAIMABLE 3.605GB” 即该匿名卷。本次 1/2/3 步未删除（避免误伤历史数据）。确认无用后可执行：

```bash
docker volume rm 63f714f3edcbd13cc4de0a4da526726640ce711bf6ea4206d0e69dc4b5a82eac
```

---

## 6. 本次已执行的清理（步骤 1 / 2 / 3）

### 步骤 1：构建缓存

```bash
docker builder prune -af
```

回收 **1.711GB**，当前 Build Cache 为 0。

### 步骤 2：闲置业务镜像与卷

已删除：

- ELK：`docker-elk-elasticsearch` / `kibana` / `logstash` / `setup`
- `spiritlhl/oneclickvirt:latest`
- 卷：`docker-elk_elasticsearch`、`oneclickvirt-data`、`oneclickvirt-storage`
- 全部 `registry.cn-beijing.aliyuncs.com/yunionio/*`（云管 v3.11.13 及 mariadb/etcd/influxdb）

### 步骤 3：闲置 Kind 节点

```bash
docker rm tkg-kind-d7su3f301ohctifdlo3g-control-plane
docker rmi projects.registry.vmware.com/tkg/kind/node:v1.29.15_vmware.1-tkg.1_v0.26.0
```

容器原状态为 `Exited (137)`。

**未执行：** `docker system prune -a --volumes`（会误删在用镜像/数据）。

---

## 7. 后续可选

1. 确认后删除 3.605GB 匿名卷（见第 5 节）。
2. MaxKB 可写层 476MB 偏大，若为日志可考虑轮转或重建容器（注意挂载数据）。
3. `docker.m.daocloud.io/...` 与官方同 ID 的重复标签可不删，不占额外空间。

---

## 8. 常用核查命令

```bash
df -h /
docker system df
docker ps -a
docker images
docker volume ls
```
