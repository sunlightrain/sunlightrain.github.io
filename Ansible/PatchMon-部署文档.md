# PatchMon 自托管部署文档

本文记录在内网 Linux 主机上使用 Docker Compose 部署 PatchMon 的实际步骤、踩坑与运维说明。官方项目：<https://github.com/PatchMon/PatchMon>。

---

## 1. 环境信息

| 项 | 值 |
| --- | --- |
| 主机 IP | `192.168.56.128` |
| 主机名 | `boot.local` |
| 系统 | RHEL / CentOS 8 系（内核 `4.18.0-553.el8_10.x86_64`） |
| Docker | `29.0.0` |
| Compose | `v2.40.3` |
| 部署目录 | `/opt/patchmon` |
| 访问地址 | http://192.168.56.128:3001 |
| 时区 | `Asia/Shanghai` |

**端口说明：** 主机 `3000` 已被 Homepage 容器占用，因此 PatchMon 对外映射为 **3001**。

---

## 2. 架构

PatchMon 官方 Compose 包含 4 个服务，均在内部网桥 `patchmon-internal` 中通信：

```
浏览器  --HTTP:3001-->  server (ghcr.io/patchmon/patchmon-server)
                           |-- PostgreSQL 17 (database)
                           |-- Redis 7 (队列 / 会话)
                           `-- guacd 1.6.0 (Windows RDP 控制台，可选)
```

Agent 由受管主机主动出站连到 Server，无需在受管机上开放入站端口。

---

## 3. 前置条件

- 已安装 Docker 与 Docker Compose v2
- 能访问 GitHub raw（下载 compose / env 模板）
- 能拉取镜像（见第 5 节镜像源）
- 建议：2 vCPU / 2 GB RAM / 15 GB 磁盘（官方最低）

登录示例（请用本机凭据，不要把密码写入仓库）：

```bash
ssh root@192.168.56.128
```

---

## 4. 部署步骤

### 4.1 创建目录并下载官方文件

```bash
mkdir -p /opt/patchmon
cd /opt/patchmon

curl -fsSL -o docker-compose.yml \
  https://raw.githubusercontent.com/PatchMon/PatchMon/refs/heads/main/docker/docker-compose.yml

curl -fsSL -o env.example \
  https://raw.githubusercontent.com/PatchMon/PatchMon/refs/heads/main/docker/env.example
```

也可使用官方交互脚本（本环境因非交互与镜像源问题未采用）：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PatchMon/PatchMon/refs/heads/main/docker/setup-env.sh)"
```

### 4.2 生成密钥并编写 `.env`

```bash
JWT=$(openssl rand -hex 64)
AIK=$(openssl rand -hex 64)
SESS=$(openssl rand -hex 64)
PG=$(openssl rand -hex 32)
RD=$(openssl rand -hex 32)

cat > /opt/patchmon/.env << EOF
CORS_ORIGIN=http://192.168.56.128:3001,http://localhost:3001
JWT_SECRET=${JWT}
POSTGRES_HOST=database
POSTGRES_PASSWORD=${PG}
POSTGRES_USER=patchmon_user
POSTGRES_DB=patchmon_db
DATABASE_URL=postgresql://patchmon_user:${PG}@database:5432/patchmon_db
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=${RD}
REDIS_DB=0
SESSION_SECRET=${SESS}
AI_ENCRYPTION_KEY=${AIK}
GUACD_ADDRESS=guacd:4822
PORT=3001
APP_ENV=production
TZ=Asia/Shanghai
EOF

chmod 600 /opt/patchmon/.env
```

注意：

- `CORS_ORIGIN` 必须与浏览器实际访问 URL 一致（含协议、IP、端口）。
- `PORT` 同时控制容器内监听端口和 Compose 映射端口。
- 密钥生成后不要提交到 Git；备份时单独保管 `.env`。

### 4.3 拉取镜像并启动

```bash
cd /opt/patchmon
docker compose pull
docker compose up -d
docker compose ps
curl -sI http://127.0.0.1:3001 | head
```

期望：四个服务均为 `healthy`，本机探测返回 `HTTP/1.1 200 OK`。

---

## 5. 本次环境实际问题与处理

### 5.1 Docker Hub 无法直连

`docker.io` 解析到海外地址后出现 `connection refused`，`postgres` / `redis` / `guacd` 拉取失败。

处理：经 DaoCloud 镜像拉取后打回官方标签。

```bash
docker pull docker.m.daocloud.io/library/redis:7-alpine
docker pull docker.m.daocloud.io/library/postgres:17-alpine
docker pull docker.m.daocloud.io/guacamole/guacd:1.6.0

docker tag docker.m.daocloud.io/library/redis:7-alpine redis:7-alpine
docker tag docker.m.daocloud.io/library/postgres:17-alpine postgres:17-alpine
docker tag docker.m.daocloud.io/guacamole/guacd:1.6.0 guacamole/guacd:1.6.0
```

`ghcr.io/patchmon/patchmon-server:latest` 可直连 GHCR，但较慢，可后台拉取：

```bash
nohup docker pull ghcr.io/patchmon/patchmon-server:latest > /tmp/pm-pull.log 2>&1 &
```

DaoCloud 对 `ghcr.io/patchmon/...` 返回 403，不可用。

可选长期方案：在 `/etc/docker/daemon.json` 增加 `registry-mirrors`（本机原仅有 `insecure-registries: ["10.68.37.208"]`），改完后需 `systemctl restart docker`。

### 5.2 端口冲突

```
Bind for 0.0.0.0:3000 failed: port is already allocated
```

占用方：`homepage` 容器。将 `.env` 中 `PORT` 改为 `3001`，并同步 `CORS_ORIGIN` 后 `docker compose up -d`。

### 5.3 首次 `up` 中断

中间 SSH 断开时，`database` / `guacd` 已 Running，`redis` / `server` 停在 `Created`。处理：重新 `docker compose up -d`（并解决 3000 占用）。

---

## 6. 当前运行状态（部署完成时）

| 容器 | 镜像 | 状态 | 端口 |
| --- | --- | --- | --- |
| patchmon-server-1 | ghcr.io/patchmon/patchmon-server:latest | healthy | `0.0.0.0:3001->3001` |
| patchmon-database-1 | postgres:17-alpine | healthy | 内部 5432 |
| patchmon-redis-1 | redis:7-alpine | healthy | 内部 6379 |
| patchmon-guacd-1 | guacamole/guacd:1.6.0 | healthy | 内部 4822 |

数据卷：`patchmon_postgres_data`、`patchmon_redis_data`。

---

## 7. 初始化与接入 Agent

1. 浏览器打开 http://192.168.56.128:3001
2. 按向导创建管理员账号
3. 进入 **Hosts** 添加主机，复制生成的一键安装命令
4. 在目标机器以 root/sudo 执行该命令完成 Agent 注册

支持平台：Linux / FreeBSD / Windows（多架构）。Agent 出站访问 PatchMon 的 `http://192.168.56.128:3001`。

---

## 8. 日常运维

```bash
cd /opt/patchmon

# 状态 / 日志
docker compose ps
docker compose logs -f --tail=100 server

# 停止 / 启动
docker compose stop
docker compose start

# 升级（官方小版本通常只需 pull + up）
docker compose pull
docker compose up -d
```

备份建议：

- 备份 `/opt/patchmon/.env` 与 `docker-compose.yml`
- 备份 Postgres 卷或执行：

```bash
docker compose exec -T database pg_dump -U patchmon_user patchmon_db > patchmon-$(date +%F).sql
```

---

## 9. 目录结构

```
/opt/patchmon/
├── docker-compose.yml   # 官方生产编排
├── env.example          # 官方环境变量模板
└── .env                 # 本机密钥与 CORS / PORT（权限 600）
```

---

## 10. 参考链接

- 项目仓库：https://github.com/PatchMon/PatchMon
- 文档：https://patchmon.net/docs/
- Docker 安装说明：https://patchmon.net/docs/patchmon-operator-guide#installing-patchmon-server-on-docker
- 环境变量：https://patchmon.net/docs/patchmon-operator-guide#patchmon-environment-variables-reference
