# Terraform 离线使用 vSphere Provider 指南

## 环境说明

已下载 Linux 版本 Provider：

```text
terraform-provider-vsphere_2.12.0_linux_amd64.zip
```
适用于：

- Terraform
- Linux x86_64 (amd64)
- VMware vSphere
## 解压 Provider
```bash
unzip terraform-provider-vsphere_2.12.0_linux_amd64.zip
```
解压后通常得到：
```text
terraform-provider-vsphere_v2.12.0_x5
```
## 本地安装 Provider
创建 Terraform 本地插件目录：
```bash
mkdir -p ~/.terraform.d/plugin*/registry.terraform.io/hashicorp/vSphere/2.12.0/linux_amd64
```
复制 Provider：
```bash
 cp terraform-provider-vsphere_v2.12.0* \
> ~/.terraform.d/plugins/registry.terraform.io/hashicorp/vsphere/2.12.0/linux_amd64/
```
目录结构
```text
~/.terraform.d/plugin*/
└── registry.terraform.io
    └*─*hashicorp
        └── vsphere
    *       └── 2.12.0
                *── linux_amd64
                   *└── terraform-provider-vsphere_v2.*2.0_x5
```
## Terraform 配置
main.tf：
```tf
terraform {
  re*uired_providers {
    vsphere = {
*     source  = "hashicorp/vsphere"*      version = "2.12.0"
    }
* }
}
```
## 初始化Terraform
```bash
terraform init
```
输出类似
```bash
[root@dldevansible01 Terraform]# terraform init
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/vsphere versions matching "2.12.0"...
- Installing hashicorp/vsphere v2.12.0...
- Installed hashicorp/vsphere v2.12.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

╷
│ Warning: Incomplete lock file information for providers
│
│ Due to your customized provider installation methods, Terraform was forced to calculate lock file checksums locally for the following providers:
│   - hashicorp/vsphere
│
│ The current .terraform.lock.hcl file only includes checksums for linux_amd64, so Terraform running on another platform will fail to install these providers.
│
│ To calculate additional checksums for another platform, run:
│   terraform providers lock -platform=linux_amd64
│ (where linux_amd64 is the platform to generate)
╵
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
