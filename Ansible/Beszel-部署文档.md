# Beszel 部署文档

部署时间：2026-09-12  
主机：`192.168.56.128`  
目录：`/opt/beszel`  
项目：https://github.com/henrygd/beszel  
文档：https://beszel.dev/

Beszel 是轻量服务器/Docker 监控：Hub 提供 Web 与历史数据，Agent 采集本机与容器指标。

---

## 1. 访问

| 项 | 值 |
| --- | --- |
| Hub 地址 | http://192.168.56.128:8090 |
| 首次打开 | 创建管理员账号（无默认密码） |
| PocketBase 后台 | http://192.168.56.128:8090/_/ |
| Agent 监听（接入后） | `45876`（host 网络） |

本机已占用端口：Homepage 3000、PatchMon 3001、Semaphore 3002。Beszel Hub 使用官方默认 **8090**。

---

## 2. 当前状态

Hub 容器 `beszel` 已运行（HTTP 200）。本机 Agent `beszel-agent` 已接入，日志为 `WebSocket connected host=127.0.0.1:8090`（新版本 Agent 主动连 Hub，不必对外开放 45876）。

| 路径 | 说明 |
| --- | --- |
| `/opt/beszel/docker-compose.yml` | Hub 编排 |
| `/opt/beszel/beszel_data` | Hub 数据（用户、历史） |
| `/opt/beszel/beszel_socket` | 本机 Unix 套接字目录（预留） |
| `/opt/beszel/docker-compose.agent.yml` | 本机 Agent 模板（需填 KEY/TOKEN） |

镜像：`henrygd/beszel:latest`。Docker Hub 不通时经 `docker.1ms.run` 拉取再打标签。

---

## 3. Hub 编排（已落地）

```yaml
name: beszel
services:
  beszel:
    image: henrygd/beszel:latest
    container_name: beszel
    restart: unless-stopped
    ports:
      - "8090:8090"
    volumes:
      - ./beszel_data:/beszel_data
      - ./beszel_socket:/beszel_socket
    environment:
      TZ: Asia/Shanghai
```

启动：

```bash
cd /opt/beszel
docker compose up -d
```

---

## 4. 初始化与接入本机 Agent

1. 浏览器打开 http://192.168.56.128:8090 ，注册管理员。
2. 添加系统（Add system），主机填 `127.0.0.1` 或 `192.168.56.128`，端口 `45876`。
3. 复制界面给出的 **KEY**、**TOKEN**（以及 HUB_URL）。
4. 编辑 `/opt/beszel/docker-compose.agent.yml`，替换 `PASTE_TOKEN_HERE` / `PASTE_KEY_HERE`。
5. 拉取并启动 Agent：

```bash
# 镜像源失败时：
docker pull docker.1ms.run/henrygd/beszel-agent:latest
docker tag docker.1ms.run/henrygd/beszel-agent:latest henrygd/beszel-agent:latest

cd /opt/beszel
docker compose -f docker-compose.agent.yml up -d
```

Agent 使用 `network_mode: host`，并只读挂载 `/var/run/docker.sock` 以采集容器统计。

其他机器：在目标机同样跑 `beszel-agent`，`HUB_URL` 填 `http://192.168.56.128:8090`，保证 Hub 能访问该机 `45876`（或按官方文档用反向连接/套接字方式）。

---

## 5. 运维

```bash
cd /opt/beszel
docker compose ps
docker compose logs -f --tail=100
docker compose restart
```

备份：拷贝 `/opt/beszel/beszel_data`。

升级 Hub：

```bash
docker pull docker.1ms.run/henrygd/beszel:latest
docker tag docker.1ms.run/henrygd/beszel:latest henrygd/beszel:latest
cd /opt/beszel && docker compose up -d
```

---

## 6. 与现有服务关系

| 服务 | 地址 | 角色 |
| --- | --- | --- |
| Homepage | :3000 | 门户，可加 Beszel Widget |
| PatchMon | :3001 | 补丁 |
| Semaphore UI | :3002 | 自动化 |
| Beszel | :8090 | 主机与 Docker 监控 |
| Portainer | :9443 | 容器管理 |
