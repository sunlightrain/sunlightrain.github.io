# Semaphore UI 部署文档

部署时间：2026-09-11  
主机：`192.168.56.128`  
目录：`/opt/semaphore`

Semaphore UI 用于在浏览器中运行 Ansible / Terraform / OpenTofu / Bash 等任务。官方文档：https://docs.semaphoreui.com/

---

## 访问信息

| 项 | 值 |
| --- | --- |
| 地址 | http://192.168.56.128:3002 |
| 用户名 | `admin` |
| 密码 | `QE07D4YHWXVTAtJu`（保存在 `/opt/semaphore/.env`） |
| 端口说明 | 3000 Homepage、3001 PatchMon，Semaphore 使用 **3002** |

登录后请尽快在界面中修改密码。

---

## 架构

单容器 + SQLite（新版本已不支持 `bolt` 方言）：

- 镜像：`semaphoreui/semaphore:latest`（v2.19.14）
- 配置卷：`semaphore_semaphore_config` → `/etc/semaphore`
- 数据卷：`semaphore_semaphore_data` → `/var/lib/semaphore`

---

## 部署要点

1. Docker Hub 直连失败，使用镜像源：

```bash
docker pull docker.1ms.run/semaphoreui/semaphore:latest
docker tag docker.1ms.run/semaphoreui/semaphore:latest semaphoreui/semaphore:latest
```

2. `SEMAPHORE_DB_DIALECT=bolt` 会报 `Unknown database dialect: bolt`，改为 **`sqlite`**。
3. 必须设置 `SEMAPHORE_ACCESS_KEY_ENCRYPTION`（`openssl rand -base64 32`）。

编排文件：`/opt/semaphore/docker-compose.yml`。

---

## 运维

```bash
cd /opt/semaphore
docker compose ps
docker compose logs -f --tail=100
docker compose restart
```

升级：

```bash
docker pull docker.1ms.run/semaphoreui/semaphore:latest
docker tag docker.1ms.run/semaphoreui/semaphore:latest semaphoreui/semaphore:latest
cd /opt/semaphore && docker compose up -d
```
