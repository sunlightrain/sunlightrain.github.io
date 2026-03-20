# 
labex:project/ $ 
labex:project/ $ mkdir quantum-leap 
labex:project/ $ cd quantum-leap 
labex:quantum-leap/ $ git init
Initialized empty Git repository in /home/labex/project/quantum-leap/.git/
labex:quantum-leap/ (master) $ echo "The flux capacitor requires 1.21 gigawatts of power." > classified.txt
labex:quantum-leap/ (master*) $ git add classified.txt 
labex:quantum-leap/ (master*) $ git commit -m "Add top-secret flux capacitor information"
[master (root-commit) 5e74c02] Add top-secret flux capacitor information
 1 file changed, 1 insertion(+)
 create mode 100644 classified.txt
labex:quantum-leap/ (master) $ git log
labex:quantum-leap/ (master) $ q
---
cd ~/project
mkdir git-config-lab
cd git-config-lab
git init

git config --list

user.name=John Doe
user.email=johndoe@example.com
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true

git config user.name

git config --global user.name "Your Name"
git config --global user.name "Jane Doe"
git config --global user.email "your.email@example.com"
git config --global user.email "jane.doe@example.com"

git config --global user.name
git config --global user.email

git config --global color.ui auto
git config --global color.ui

git config --global core.editor nano
git config --global core.editor

git config --global core.autocrlf input
git config --global core.autocrlf

git config --global alias.st status
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

git config --global alias.st
git config --global alias.lg
git config user.name "Lab User"
git config user.name

如何使用 git add 将文件添加到暂存区。
如何使用 .gitignore 忽略不想追踪的文件。
如何在提交前使用 git diff 查看文件中的更改。
如何使用 git restore --staged 撤销暂存的更改。
这些技能让你对 Git 工作流拥有了更多的掌控力。特别是暂存区，它是一个强大的功能，允许你通过精心挑选要包含的更改来构建更有意义的提交。