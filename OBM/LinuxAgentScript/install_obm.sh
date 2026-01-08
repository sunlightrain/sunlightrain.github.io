
#!/usr/bin/env bash
# OBM Linux_x64 自动化安装脚本
# Author: chenxuewen
# Date: 2026-01-06

set -euo pipefail

# ===== 配置默认值 =====
REPO_URL_DEFAULT="http://10.68.37.105/iso/app/linux/obm/package/"
TARGET_DIR_DEFAULT="/tmp/obm/1.0"
SERVER_FQDN=""
REPO_URL="$REPO_URL_DEFAULT"
TARGET_DIR="$TARGET_DIR_DEFAULT"
ADD_HOSTS_ENTRY=""
SHORT_HOSTNAME="$(hostname -s)"
LOG_FILE="/var/log/obm_install_$(date +%F_%H%M%S).log"

# ===== 打印用法 =====
usage() {
  cat <<EOF
用法: sudo $0 --server <dlobm.hynix-dl.com> [选项]

必填参数:
  --server <FQDN>         OBM服务器FQDN，例如: dlobm.hynix-dl.com

可选参数:
  --repo <URL>            安装包仓库URL (默认: ${REPO_URL_DEFAULT})
  --target <DIR>          下载/解压目标目录 (默认: ${TARGET_DIR_DEFAULT})
  --set-hosts "<IP FQDN>" 在 /etc/hosts 添加条目，例如: "10.68.37.105 dlobm.hynix-dl.com"
  --hostname <name>       设置短主机名 (默认: $(hostname -s))
  -h, --help              显示帮助

示例:
  sudo $0 --server dlobm.hynix-dl.com \\
          --repo ${REPO_URL_DEFAULT} \\
          --target /tmp/obm/1.0 \\
          --set-hosts "10.68.40.130 dlobm.hynix-dl.com" \\
          --hostname $(hostname -s)
EOF
}

# ===== 日志函数 =====
log() {
  echo -e "[$(date +'%F %T')] $*" | tee -a "$LOG_FILE"
}

# ===== 参数解析 =====
if [[ $# -eq 0 ]]; then usage; exit 1; fi
while [[ $# -gt 0 ]]; do
  case "$1" in
    --server) SERVER_FQDN="$2"; shift 2 ;;
    --repo) REPO_URL="$2"; shift 2 ;;
    --target) TARGET_DIR="$2"; shift 2 ;;
    --set-hosts) ADD_HOSTS_ENTRY="$2"; shift 2 ;;
    --hostname) SHORT_HOSTNAME="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) log "未知参数: $1"; usage; exit 1 ;;
  esac
done

# ===== 前置校验 =====
if [[ $EUID -ne 0 ]]; then
  echo "请使用 sudo 以 root 权限运行本脚本。"; exit 1
fi
if [[ -z "$SERVER_FQDN" ]]; then
  echo "错误: 必须指定 --server <FQDN>."; usage; exit 1
fi

log "日志文件: $LOG_FILE"
log "参数: SERVER_FQDN=${SERVER_FQDN}, REPO_URL=${REPO_URL}, TARGET_DIR=${TARGET_DIR}, SHORT_HOSTNAME=${SHORT_HOSTNAME}"

# ===== 创建目标目录 =====
log "创建目标目录: ${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"

# ===== 可选: 更新 /etc/hosts =====
if [[ -n "${ADD_HOSTS_ENTRY}" ]]; then
  IP_ENTRY="$(echo "${ADD_HOSTS_ENTRY}" | awk '{print $1}')"
  NAME_ENTRY="$(echo "${ADD_HOSTS_ENTRY}" | awk '{print $2}')"
  if [[ -z "$IP_ENTRY" || -z "$NAME_ENTRY" ]]; then
    log "警告: --set-hosts 参数格式不正确，应为 \"IP FQDN\"，已跳过。"
  else
    if grep -qE "^[[:space:]]*${IP_ENTRY}[[:space:]]+${NAME_ENTRY}\b" /etc/hosts; then
      log "/etc/hosts 已存在条目: ${IP_ENTRY} ${NAME_ENTRY}，跳过添加。"
    else
      log "向 /etc/hosts 添加条目: ${IP_ENTRY} ${NAME_ENTRY}"
      echo "${IP_ENTRY} ${NAME_ENTRY}" >> /etc/hosts
    fi
  fi
fi

# ===== 下载安装包 =====
log "开始下载安装包: ${REPO_URL} -> ${TARGET_DIR}"
wget -d -r -np -nd "${REPO_URL}" -P "${TARGET_DIR}"

# ===== 解压安装包 =====
log "查找压缩包并解压..."
shopt -s nullglob
TARS=("${TARGET_DIR}"/Linux_x64*.tar.gz "${TARGET_DIR}"/*.tar.gz)
if [[ ${#TARS[@]} -eq 0 ]]; then
  log "错误: 未找到 *.tar.gz 压缩包，请检查仓库地址或网络。"
  exit 1
fi
for TAR in "${TARS[@]}"; do
  log "解压: ${TAR}"
  tar -xvf "${TAR}" -C "${TARGET_DIR}"
done

# ===== 查找安装脚本 oainstall.sh =====
log "查找安装脚本 oainstall.sh..."
INSTALLER_PATH="$(find "${TARGET_DIR}" -maxdepth 2 -type f -name 'oainstall.sh' | head -n 1)"
if [[ -z "${INSTALLER_PATH}" ]]; then
  log "错误: 未找到 oainstall.sh，请确认解压内容。"
  exit 1
fi
log "安装脚本位置: ${INSTALLER_PATH}"

# ===== 校验 hosts 名称解析（OBM与本机） =====
log "校验名称解析..."
if ! getent hosts "${SERVER_FQDN}" >/dev/null; then
  log "警告: 无法解析 OBM 服务器 ${SERVER_FQDN}，请确认 DNS 或 /etc/hosts。"
fi
if ! getent hosts "$(hostname -f)" >/dev/null; then
  log "警告: 无法解析本机 FQDN $(hostname -f)，建议在 /etc/hosts 补充。"
fi

# ===== 执行安装 =====
log "执行安装: ${INSTALLER_PATH} -i -a -s ${SERVER_FQDN}"
bash "${INSTALLER_PATH}" -i -a -s "${SERVER_FQDN}"

# ===== 验证运行状态 =====
OV_BIN="/opt/OV/bin"
log "验证运行状态..."
if [[ -x "${OV_BIN}/ovc" ]]; then
  "${OV_BIN}/ovc" -status | tee -a "$LOG_FILE" || true
else
  log "警告: 未找到 ${OV_BIN}/ovc"
fi
if [[ -x "${OV_BIN}/opcagt" ]]; then
  "${OV_BIN}/opcagt" -status | tee -a "$LOG_FILE" || true
else
  log "警告: 未找到 ${OV_BIN}/opcagt"
fi

# ===== 设置短主机名 =====
log "设置短主机名为: ${SHORT_HOSTNAME}"
if [[ -x "${OV_BIN}/ovconfchg" ]]; then
  "${OV_BIN}/ovconfchg" -ns xpl.net -set LOCAL_NODE_NAME "${SHORT_HOSTNAME}"
  "${OV_BIN}/ovconfchg" -ns eaagt   -set OPC_NODE_NAME   "${SHORT_HOSTNAME}"
else
  log "错误: 未找到 ${OV_BIN}/ovconfchg，无法设置主机名参数。"
  exit 1
fi

# ===== 重启服务 =====
if [[ -x "${OV_BIN}/opcagt" ]]; then
  log "重启服务: opcagt -cleanstart"
  "${OV_BIN}/opcagt" -cleanstart || { log "警告: opcagt -cleanstart 失败，请手动检查。"; }
else
  log "警告: 未找到 ${OV_BIN}/opcagt，跳过重启。"
fi

# ===== 最终状态展示 =====
log "最终状态检查..."
if [[ -x "${OV_BIN}/opcagt" ]]; then
  "${OV_BIN}/opcagt" -status | tee -a "$LOG_FILE" || true
fi
if [[ -x "${OV_BIN}/ovc" ]]; then
  "${OV_BIN}/ovc" -status | tee -a "$LOG_FILE" || true
fi

log "安装流程完成。若遇到问题，请查看日志: ${LOG_FILE}"
