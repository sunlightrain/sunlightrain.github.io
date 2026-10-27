# Ansible 批量加域部署文档

更新日期：2026-10-24  
适用系统：RHEL / Rocky / AlmaLinux 8-9、Ubuntu 22.04+、Debian 12  
技术栈：`realmd` + `sssd` + `adcli`（RHEL 与 Ubuntu 官方推荐方案）  
前提：已有 AD 域环境，客户端 DNS 指向可解析 AD SRV 记录的域控

用 Ansible 把一批 Linux 服务器统一加入 Active Directory，实现域账号登录、sudo 授权与主机权限集中管理。重点是幂等、分批执行、失败可回滚。

---

## 1. 方案选型

| 方案 | 适用场景 | 说明 |
| --- | --- | --- |
| `realmd + sssd` | 纯登录、sudo、SSH 认证（推荐） | 不需要 Samba，配置简单 |
| `realmd + winbind` | 需要访问 SMB 共享或做文件服务器 | 会额外引入 winbind 服务 |
| `sssd` 手工配置 + `adcli` | 需要精细控制 | 本质同第一种，只是跳过 realmd |

本文按第一种实施。

---

## 2. 目录结构

```text
.
├── ansible.cfg
├── inventory/hosts.ini
├── group_vars/all/
│   ├── vars.yml          # 非敏感变量
│   └── vault.yml         # ansible-vault 加密，存放加域账号密码
├── join-ad.yml
└── templates/
    ├── sssd.conf.j2
    └── sudoers-admins.j2
```

`ansible.cfg`：

```ini
[defaults]
inventory = inventory/hosts.ini
host_key_checking = False
interpreter_python = auto_silent
stdout_callback = yaml
forks = 20

[privilege_escalation]
become = True
become_method = sudo
become_ask_pass = False
```

---

## 3. 清单与变量

`inventory/hosts.ini`：

```ini
[linux_servers]
srv01 ansible_host=10.0.10.11
srv02 ansible_host=10.0.10.12

[linux_servers:vars]
ansible_user=ops
ansible_ssh_private_key_file=~/.ssh/id_ed25519
```

`group_vars/all/vars.yml`：

```yaml
ad_domain: corp.example.com      # 小写 DNS 域名，传给 realm join
ad_realm: CORP.EXAMPLE.COM       # 大写 Kerberos realm
ad_dc_fqdn: dc01.corp.example.com
ad_join_user: svc-ansible-join   # 只需 "Domain Join" 权限的专用账号
ad_computer_ou: "OU=Linux,OU=Servers,DC=corp,DC=example,DC=com"
ad_login_group: "linux-admins"   # AD 安全组，成员可登录 + sudo
```

`group_vars/all/vault.yml` 由 `ansible-vault create group_vars/all/vault.yml` 生成：

```yaml
vault_ad_join_password: "加域账号密码"
```

---

## 4. 主 Playbook

`join-ad.yml`：

```yaml
---
- name: Join Linux servers to Active Directory
  hosts: linux_servers
  become: true
  gather_facts: true
  serial: "20%"                 # 分批，避免一次性打挂整个环境
  max_fail_percentage: 10

  vars_files:
    - group_vars/all/vars.yml
    - group_vars/all/vault.yml

  tasks:
    # ---------- 前置检查：DNS / 时间 / 主机名 ----------
    - name: Preflight - resolve domain controller
      ansible.builtin.command: getent hosts {{ ad_dc_fqdn }}
      register: dc_lookup
      changed_when: false
      retries: 3
      delay: 3
      until: dc_lookup.rc == 0
      failed_when: dc_lookup.rc != 0

    - name: Preflight - hostname must be FQDN
      ansible.builtin.assert:
        that:
          - ansible_facts.fqdn is defined
          - ansible_facts.fqdn != ansible_facts.hostname
        fail_msg: "主机名必须是 FQDN，当前 hostname={{ ansible_facts.hostname }}"

    - name: Preflight - time skew must be < 5 minutes
      ansible.builtin.command: chronyc tracking
      register: chrony
      changed_when: false
      failed_when: chrony.rc != 0
      when: ansible_facts.services['chronyd.service'] is defined

    - name: Preflight - realm discover
      ansible.builtin.command: realm discover {{ ad_domain }}
      register: realm_discover
      changed_when: false
      failed_when: realm_discover.rc != 0

    # ---------- 安装依赖 ----------
    - name: Install AD client packages (RHEL family)
      ansible.builtin.dnf:
        name:
          - realmd
          - sssd
          - sssd-ad
          - sssd-krb5
          - sssd-tools
          - adcli
          - krb5-workstation
          - samba-common-tools
          - oddjob
          - oddjob-mkhomedir
          - authselect
        state: present
      when: ansible_facts.os_family == "RedHat"

    - name: Install AD client packages (Debian family)
      ansible.builtin.apt:
        name:
          - realmd
          - sssd
          - sssd-tools
          - adcli
          - krb5-user
          - samba-common-bin
          - oddjob
          - oddjob-mkhomedir
          - libnss-sss
          - libpam-sss
          - packagekit
        state: present
        update_cache: true
      when: ansible_facts.os_family == "Debian"

    # ---------- 加域（幂等） ----------
    - name: Check current domain membership
      ansible.builtin.command: realm list
      register: realm_list
      changed_when: false
      failed_when: false

    - name: Join realm via adcli
      ansible.builtin.command:
        argv:
          - realm
          - join
          - "--user={{ ad_join_user }}"
          - "--computer-ou={{ ad_computer_ou }}"
          - "--membership-software=adcli"
          - "--os-name=Linux"
          - "{{ ad_domain }}"
        stdin: "{{ vault_ad_join_password }}\n"
      when: ad_domain not in realm_list.stdout
      no_log: true
      notify: restart sssd

    # ---------- 登录策略与家目录 ----------
    - name: Allow AD group to log in
      ansible.builtin.command: "realm permit --groups {{ ad_login_group }}"
      changed_when: true

    - name: Enable mkhomedir (RHEL family)
      ansible.builtin.command: authselect select sssd with-mkhomedir --force
      when: ansible_facts.os_family == "RedHat"
      changed_when: true

    - name: Enable mkhomedir (Debian family)
      ansible.builtin.command: pam-auth-update --enable mkhomedir
      when: ansible_facts.os_family == "Debian"
      changed_when: true

    - name: Deploy sssd.conf
      ansible.builtin.template:
        src: templates/sssd.conf.j2
        dest: /etc/sssd/sssd.conf
        owner: root
        group: root
        mode: "0600"
      notify: restart sssd

    - name: Deploy sudoers rule for AD admin group
      ansible.builtin.template:
        src: templates/sudoers-admins.j2
        dest: /etc/sudoers.d/10-ad-admins
        owner: root
        group: root
        mode: "0440"
        validate: /usr/sbin/visudo -cf %s

    - name: Enable and start services
      ansible.builtin.systemd:
        name: "{{ item }}"
        state: started
        enabled: true
      loop:
        - sssd
        - oddjobd

    # ---------- 验证 ----------
    - name: Verify domain membership
      ansible.builtin.command: realm list
      register: realm_verify
      changed_when: false
      failed_when: ad_domain not in realm_verify.stdout

    - name: Verify NSS resolution of the domain
      ansible.builtin.command: "getent passwd {{ ad_join_user }}@{{ ad_domain }}"
      register: id_check
      changed_when: false
      failed_when: id_check.rc != 0

  handlers:
    - name: restart sssd
      ansible.builtin.systemd:
        name: sssd
        state: restarted
```

`templates/sssd.conf.j2`：

```ini
[sssd]
domains = {{ ad_domain }}
config_file_version = 2
services = nss, pam, ssh, sudo

[domain/{{ ad_domain }}]
id_provider = ad
auth_provider = ad
access_provider = ad
chpass_provider = ad
sudo_provider = ad

ad_domain = {{ ad_domain }}
krb5_realm = {{ ad_realm }}
ldap_sasl_mech = GSSAPI
ldap_sasl_authid = host/{{ ansible_facts.fqdn }}@{{ ad_realm }}

cache_credentials = True
krb5_store_password_if_offline = True
ldap_id_mapping = True
use_fully_qualified_names = False
fallback_homedir = /home/%u
default_shell = /bin/bash

# 避免 GPO 访问控制直接拒掉用户（排障期建议 permissive）
ad_gpo_access_control = permissive
dyndns_update = false
```

`templates/sudoers-admins.j2`：

```jinja
%{{ ad_login_group }} ALL=(ALL) ALL
```

---

## 5. 执行

```bash
# 1) 语法检查
ansible-playbook join-ad.yml --syntax-check

# 2) 单机演练（强烈建议先做）
ansible-playbook join-ad.yml --limit srv01 --check --diff

# 3) 正式首发单机
ansible-playbook join-ad.yml --limit srv01 --ask-vault-pass

# 4) 全量（serial 自动按 20% 分批）
ansible-playbook join-ad.yml --ask-vault-pass
```

---

## 6. 验证

```bash
# 域状态
ansible linux_servers -m command -a "realm list" -b

# 域用户解析
ansible linux_servers -m command -a "id 'CORP\\someuser'" -b

# 实际登录测试（关键，不能只看 realm list）
ssh 'CORP\someuser'@10.0.10.11
ssh someuser@corp.example.com@10.0.10.11   # use_fully_qualified_names=False 时也可用
```

> 只有在真实 SSH 登录、`sudo -l`、家目录自动创建都验证通过后，才改 `sshd_config` 的 `AllowGroups` 或关闭本地密码登录。否则 sssd 一出问题就会彻底失去访问，只能走 console / IPMI 救援。

---

## 7. 常见坑

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| `realm discover` 失败 | 客户端 DNS 不能解析 AD SRV 记录 | `/etc/resolv.conf` 指向域控；检查 `_ldap._tcp.<domain>` |
| `KRB_AP_ERR_SKEW` | 与 DC 时间差 > 5 分钟 | 先修好 chrony / NTP |
| 加域成功但认证偶发失败 | 主机名非 FQDN 或正反向解析不一致 | 改成 FQDN，校正 `/etc/hosts` |
| `realm join` 报未知域 | 域名大小写混用 | `realm join` 用小写 DNS 域名，`krb5_realm` 用大写 |
| 密码正确但登不进去 | `access_provider = ad` 未放行 | `realm permit --groups <组>` |
| UID 与预期不符 | `ldap_id_mapping = True` 由 sssd 生成 | 需固定 UID 时启用 AD 的 RFC2307 POSIX 属性并设 `ldap_id_mapping = False` |
| 手工改配置被覆盖 | 模板由 Ansible 托管 | 所有差异写进模板，不要直接改 `/etc/sssd/sssd.conf` |

其他：

- 加域密码必须放 Vault，任务加 `no_log: true`；账号只授予 "Domain Join" 最小权限，不要用 Domain Admin。
- 不建议在 playbook 里直接关闭 SSH 密码登录，改由人工验证后再单独变更。

---

## 8. 回滚 / 重新加域

```yaml
- name: Leave domain
  ansible.builtin.command: realm leave --remove {{ ad_domain }}
  when: ad_domain in realm_list.stdout
```

手工执行：

```bash
realm leave -U administrator
```

`realm leave` 会删除 `/etc/sssd/sssd.conf` 中对应 domain 配置和 keytab，但不会删除已创建的域用户家目录。

若需处理 "加域成功但 sssd 已损坏需重加" 的场景，可加 `ad_force_rejoin` 变量：为真时先 `realm leave` 再 `realm join`，否则走幂等跳过。
