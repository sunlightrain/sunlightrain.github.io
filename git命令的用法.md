# 一、Git 是什么？
Git 是一个版本控制工具，用于管理代码变更。

简单理解：
```text
工作目录
    ↓
git add
    ↓
暂存区（Stage）
    ↓
git commit
    ↓
本地仓库（Repository）
    ↓
git push
    ↓
远程仓库（GitHub/GitLab/Azure DevOps）

```
# 二、Git 常用命令
## 1. 查看 Git 版本
`git --version`
如
`git version 2.45.1`
## 2. 配置用户名和邮箱
第一次安装 Git 必须配置：
```bash
git config --global user.name "Chen"
git config --global user.email "chen@example.com"

git config --global user.name "Chen Xuewen"​‌
git config --global user.email "X7020856@dl.skhynix.com"

# 查看配置：
git config --list
```
# 三、创建仓库
## 方法1：初始化本地仓库
```bash
git init
# 例如
mkdir MyProject
cd MyProject

git init
# 结果：
Initialized empty Git repository
```
## 方法2：克隆远程仓库
```bash
git clone 仓库地址
# 如
git clone https://github.com/user/demo.git
git clone git@github.com:user/demo.git
```
# 四、查看文件状态
```bash
git status

红色 = 未加入暂存区
绿色 = 已加入暂存区
```
## 第一步：加入暂存区
```bash
# 单个文件
git add test.py
# 多个文件
git add file1 file2
# 全部文件
git add .
```
## 第二步：提交

```bash
git commit -m "新增登录功能"
git commit -m "fix bug #101"
```
```
git commit -am "修改配置"
git add .
git commit -m "修改配置"

git log
git log --oneline
git log --graph --oneline --all
git diff
git diff --cached
```
# 添加远程仓库
查看远程仓库：
```bash
git remote -v
# 添加远程仓库：
git remote add origin URL
git remote add origin git@git.hynix-dl.com:X7020856/terraform-vmware.git

git fetch origin

git clone git@git.hynix-dl.com:X7020856/terraform-vmware.git
```
✅ 本地仓库有提交
✅ GitLab 仓库也有提交
✅ 两边是独立创建的，没有共同历史（no common commits）
## 先查看差异
```bash
git log --oneline --decorate --graph --all

[root@dldevansible01 Terraform-RKE2-cluster]# git log --oneline --decorate --graph --all
* 42c4874 (HEAD -> master) New RKE2 VM Create
* 6541246 (origin/master) 添加minio-vsphere vm
* 384cbe6 Initialized from 'GitLab CI/CD components' project template
[root@dldevansible01 Terraform-RKE2-cluster]# git pull origin master --allow-unrelated-histories
From git.hynix-dl.com:X7020856/terraform-vmware
 * branch            master     -> FETCH_HEAD
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint:
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.
[root@dldevansible01 Terraform-RKE2-cluster]# git status
On branch master
nothing to commit, working tree clean
[root@dldevansible01 Terraform-RKE2-cluster]#
```
## Merge
```bash

git pull --no-rebase origin master --allow-unrelated-histories
# 修改冲突文件后
git add .
git commit -m "Merge remote master into local master"

# 然后推送
git push origin master
```
