#安装报错 证书请求不到处理
[root@dlhymmsweb02 ~]# export PATH=$PATH:/opt/OV/bin
[root@dlhymmsweb02 ~]# ovconfget eaagt
OPC_INSTALLATION_TIME=Tue Dec 23 14:49:12 CST 2025
OPC_INSTALLED_VERSION=12.28.006
OPC_MONA_CONF_RPC_ONLY=TRUE
OPC_NODENAME=dlhymmsweb02.corp.hynix-dl.com
OPC_RPC_ONLY=TRUE
OPC_SEND_ASSD_ON_DEPLOYMENT=ON_DEVIATION
RESTWS_USE_BASIC_AUTH=TRUE
[root@dlhymmsweb02 ~]# ovcert -list
+---------------------------------------------------------+
| Keystore Content                                        |
+---------------------------------------------------------+
| Certificates:                                           |
+---------------------------------------------------------+
| Trusted Certificates:                                   |
+---------------------------------------------------------+

[root@dlhymmsweb02 ~]# ovconfchg -ns eaagt -set dlhymmsweb02
(xpl-282) Missing attribute or value after -set.
Usage: ovconfchg [-ovrg <OVRG>]
                 [-edit
                  | [-job]
                    { {-ns|-namespace} <namespace>
                      {-set <attr> <value> | -clear {<attr>|-all} }...
                    }...
                 ]
       ovconfchg { -h | -help | -version }
[root@dlhymmsweb02 ~]# ovconfchg -ns eaagt -set OPC_NODE_NAME dlhymmsweb02
[root@dlhymmsweb02 ~]# ovconfchg -ns xpl.net -set LOCAL_NODE_NAME dlhymmsweb02
[root@dlhymmsweb02 ~]# ovcert -certreq
INFO:    Certificate request has been successfully triggered.
[root@dlhymmsweb02 ~]# ovcert -list
+---------------------------------------------------------+
| Keystore Content                                        |
+---------------------------------------------------------+
| Certificates:                                           |
|     db2f036a-d3bd-75f4-022c-df51807cbcaf (*)            |
+---------------------------------------------------------+
| Trusted Certificates:                                   |
|     CA_3252ea7a-cbb0-75ed-026a-ff061105569a_2048        |
+---------------------------------------------------------+
[root@dlhymmsweb02 ~]#
#Linux_x64安装步骤
#更改短主机名
#1. Download
wget -d -r -np -nd http://10.68.37.105/iso/app/linux/obm/package/ -P /tmp/obm/1.0/
#2. unzip当前软件压缩包
#3. 运行安装脚本，确认hosts文件已添加解析，client和OBM都需要
sh /tmp/Linux_x64*/oainstall.sh -i -a -s dlobm.hynix-dl.com
#4. 验证运行状态  /opt/OV/bin
ovc -status
opcagt -status
#5. 更改短主机名
ovconfchg -ns xpl.net -set LOCAL_NODE_NAME <hostname>​
ovconfchg -ns eaagt -set OPC_NODE_NAME <hostname>
#6. 重启服务
opcagt -cleanstart

-----
#windows安装步骤
1、已安装GUN wget;下载安装包
.\wget -d -r -np -nd http://10.68.37.105/iso/app/windows/obm/package/ -P c:\temp\obm\1.0\
2、添加hosts互相解析
3、手动解压zip,进入安装目录
4、运行安装脚本
cscript.exe .\oainstall.vbs -i -a -s dlobm.hynix-dl.com
5、验证运行状态  C:\Program Files\HP\HP BTO Software\bin\
ovc -status
opcagt -status
6、更改短主机名
# ovconfchg -ns xpl.net -set LOCAL_NODE_NAME <hostname>​
# ovconfchg -ns eaagt -set OPC_NODE_NAME <hostname>
7、重启服务
opcagt -cleanstart
-----
export PATH=$PATH:/opt/OV/bin
ovconfchg -ns eaagt -set OPC_NODE_NAME dlhymmswas01
opcagt -cleanstart

export PATH=$PATH:/opt/OV/bin
ovconfchg -ns eaagt -set OPC_NODE_NAME dlhymmswas02
opcagt -cleanstart

export PATH=$PATH:/opt/OV/bin
ovconfchg -ns eaagt -set OPC_NODE_NAME dlhymmsdb01
opcagt -cleanstart

export PATH=$PATH:/opt/OV/bin
ovconfchg -ns eaagt -set OPC_NODE_NAME dlhymmsdb02
opcagt -cleanstart
-----
