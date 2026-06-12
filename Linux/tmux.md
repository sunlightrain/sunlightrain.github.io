1️⃣ 会话管理

# 操作命令
查看会话    tmux ls
进入会话    tmux attach -t 名字
删除会话    tmux kill-session -t 名字

2️⃣ 窗口（window）

# 操作快捷键
新建窗口    Ctrl+b c
切换窗口    Ctrl+b 0~9
下一个窗口  Ctrl+b n
上一个窗口  Ctrl+b p
重命名窗口  Ctrl+b ,
关闭窗口    exit

🧠 三、核心概念
概念        类比            说明
session     一个工作空间     可断开与恢复
window      标签页          每个 session 多个 window
pane        分屏            一个 window 内可拆分

🚀 四、入门操作
2️⃣ 创建命名会话
tmux new -s mysession
✅ 示例：
tmux new -s dev
3️⃣ 查看会话
tmux ls
✅ 示例输出：
dev: 1 windows (created Fri Jun 12)
4️⃣ 进入会话 恢复会话
tmux attach -t dev
5️⃣ 断开会话（不中断任务）
Ctrl + b 然后按 d
6️⃣ 删除会话
tmux kill-session -t dev
👉 所有 tmux 快捷键必须先按：
Ctrl + b

# 功能快捷键
新建窗口    c
切换窗口    n（下一个）
上一个窗口  p
指定窗口    0~9
重命名窗口  ,
# 面板（分屏）
水平分割    %
垂直分割    "
# 切换面板
Ctrl + b + 方向键