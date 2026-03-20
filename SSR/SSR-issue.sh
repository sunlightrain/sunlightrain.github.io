U‑49 
ps -ef |grep sendmail

1.备份/usr/sbin/sendmail文件

mv /usr/sbin/sendmail /usr/sbin/sendmail.bak

2.替换/usr/sbin/sendmail文件内容，程序调用sendmail后直接退出，不产生sendmail -t 进程，实现效果为调用成功但无实际发送

cat > /usr/sbin/sendmail << 'EOF'
#!/bin/sh
# mail disabled on this host
exit 0
EOF

3.添加权限

chmod 755 /usr/sbin/sendmail

[root@dlhysacdb02 ~]#  ps -ef |grep sendmail
shieldus 2295846 2295845  0 Jan29 ?        00:00:00 sendmail -t
shieldus 2298325 2298324  0 Jan29 ?        00:00:00 sendmail -t
shieldus 2322028 2322027  0 Jan29 ?        00:00:00 sendmail -t
root     4007570 3947308  0 08:50 pts/0    00:00:00 grep --color=auto sendmail
[root@dlhysacdb02 ~]# ps -ef |grep sendmail
shieldus 2295846 2295845  0 Jan29 ?        00:00:00 sendmail -t
shieldus 2298325 2298324  0 Jan29 ?        00:00:00 sendmail -t
shieldus 2322028 2322027  0 Jan29 ?        00:00:00 sendmail -t
root     4017617 3947308  0 08:52 pts/0    00:00:00 grep --color=auto sendmail
[root@dlhysacdb02 ~]#
[root@dlhysacdb02 ~]#
[root@dlhysacdb02 ~]# kill 2295846
[root@dlhysacdb02 ~]# kill 2298325
[root@dlhysacdb02 ~]# kill 2322028
[root@dlhysacdb02 ~]# ps -ef |grep sendmail
root     4021481 3947308  0 08:53 pts/0    00:00:00 grep --color=auto sendmail
[root@dlhysacdb02 ~]#
