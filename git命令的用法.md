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
