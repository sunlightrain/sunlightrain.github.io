一、AD OU 设计的 6 条最佳实践 ✅
✅ 1. 先分“对象类型”，再分部门/用途（非常关键）
第一层 OU 按对象类型，而不是部门。
推荐顶层结构：
corp.example.com
├─ OU=Users
├─ OU=Computers
├─ OU=Servers
├─ OU=Service Accounts
├─ OU=Admins

为什么？

用户 / 电脑 / 服务器的 GPO 完全不同
权限委派方式不同
生命周期不同（服务器 ≠ 人）

❌ 反例（非常常见）：
OU=IT
  ├─ Alice（用户）
  ├─ Bob-PC（电脑）
  ├─ DC01（服务器）

👉 这样会让 GPO 一团糟

✅ 2. OU 只做到“GPO 需要的粒度”，不要过深
OU 深度建议 ≤ 4 层
✅ 好的例子：
OU=Servers
  ├─ OU=Production
  │   ├─ OU=Web
  │   └─ OU=DB
  └─ OU=Development

❌ 过度设计：
OU=Servers
  └─ OU=China
     └─ OU=DL
        └─ OU=IDC01
           └─ OU=Rack12
              └─ OU=VMs

👉 这种结构：

GPO 难维护
新人必迷路
实际没有额外收益


✅ 3. 用 Security Group + GPO Filtering，而不是疯狂建 OU

OU 决定“在哪能应用”，组决定“谁真正生效”

正确思路

GPO 链接到 OU
用 Security Filtering / WMI Filter 控制对象

✅ 好例子：

OU：OU=Servers
GPO：GPO-Hardening
安全组：

SG-Servers-LinuxLike
SG-Servers-WindowsCore



比：

OU=ServerA
OU=ServerB
OU=ServerC
👉 更可维护


✅ 4. 域控、Tier 0 必须“物理隔离”
Domain Controller 是 Tier 0 资产，不能和普通服务器混。
推荐：
OU=Domain Controllers   （默认 OU，改 GPO 不要改位置）
OU=Admins
OU=Tier0-Servers

✅ 原因：

单独 GPO（安全、审计）
单独权限委派
防止误操作

❌ 千万不要：

把 DC 放到 Servers / Production 里
给 Domain Controllers OU 乱链 GPO


✅ 5. 用户 OU ≠ 公司 HR 组织架构
AD 用户 OU 不应该 1:1 模拟 HR 的组织树。
HR 结构：
公司
└─ 中国
   └─ IT
      └─ 网络组

AD 更合理的是：
OU=Users
  ├─ OU=OfficeUsers
  ├─ OU=PrivilegedUsers
  └─ OU=ExternalUsers

部门信息：
✅ 用 attribute（department / title）
✅ 用 Group
而不是 OU。

✅ 6. 为“委派管理”预留 OU
OU 的一个被忽视但非常重要的作用是：Delegation（委派）
例如：

Helpdesk 只能重置密码
Citrix 团队只能管理特定服务器
应用团队只能加机器进指定 OU

✅ 示例：
OU=Computers
  ├─ OU=VDI
  ├─ OU=Manufacturing

然后：

把 OU=VDI 的管理权限委派给 VDI 团队
不需要 Domain Admin



--------------
OU=DMTM-INFRA
│
├─ OU=Servers
│   ├─ OU=Production
│   │   ├─ OU=Infra
│   │   │   ├─ OU=Monitoring
│   │   │   ├─ OU=Backup
│   │   │   └─ OU=Logging
│   │   │
│   │   ├─ OU=Database
│   │   │   └─ OU=MSSQL
│   │   │
│   │   ├─ OU=Application
│   │   │   ├─ OU=Web
│   │   │   ├─ OU=Middleware
│   │   │   └─ OU=WAS
│   │
│   └─ OU=Dev
│       ├─ OU=Infra
│       ├─ OU=Database
│       └─ OU=Application
│           ├─ OU=Web
│           └─ OU=WAS


OU（Organizational Unit）的核心用途只有 3 个

承载 GPO（组策略）
做对象的逻辑分组（方便管理）
委派管理权限（Delegation）

OU 设计的几个核心原则：
原则 1：OU 只为 GPO 服务
原则 2：人、机、服务器必须分离
原则 3：OU 尽量稳定，不因组织调整频繁变化
原则 4：OU 层级不要太深（≤ 3–4 层）


应用名（ffdc / smartpms）
正确做法：安全组 / 设备组

SG-App-FFDC-Prod-Web
SG-App-SmartPMS-Prod-Web
SG-App-SmartQMS-Prod-Web
SG-App-FFDC-Prod-WAS

dlnetbox	10.68.38.81
dlbitwarden01	10.68.37.210 🆗


Get-ADComputer dlkms01 | Select-Object DistinguishedName
Get-ADComputer dlkms02 | Select-Object DistinguishedName

Get-ADComputer dlveempmis03 | Select-Object DistinguishedName
Get-ADComputer dlveempmis04 | Select-Object DistinguishedName
Get-ADComputer dlveempmis05 | Select-Object DistinguishedName
Get-ADComputer dlveempmis06 | Select-Object DistinguishedName
Get-ADComputer dlveempsec03 | Select-Object DistinguishedName
Get-ADComputer dlveempsec04 | Select-Object DistinguishedName
Get-ADComputer dlveempmfg03 | Select-Object DistinguishedName

Get-ADComputer dlprintdb01 | Select-Object DistinguishedName
Get-ADComputer dlprintdb02 | Select-Object DistinguishedName
Get-ADComputer dlprintweb01 | Select-Object DistinguishedName
Get-ADComputer dlprintweb02 | Select-Object DistinguishedName