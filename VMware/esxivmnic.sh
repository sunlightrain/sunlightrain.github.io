# Dev
[root@esx-01a:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:a0:40  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:a0:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    8c:96:a5:25:97:cd  1500  Intel Corporation I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    8c:96:a5:25:97:ce  1500  Intel Corporation I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    8c:96:a5:25:97:cf  1500  Intel Corporation I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    8c:96:a5:25:97:d0  1500  Intel Corporation I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b3:30  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b3:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b2:b0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b2:b1  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:97:60  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:97:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e0:30  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:e0:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@esx-01a:~]

[root@esx-02a:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:dc:10  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:dc:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    8c:96:a5:25:6f:0d  1500  Intel Corporation I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    8c:96:a5:25:6f:0e  1500  Intel Corporation I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    8c:96:a5:25:6f:0f  1500  Intel Corporation I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    8c:96:a5:25:6f:10  1500  Intel Corporation I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:bb:30  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:bb:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e0:00  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e0:01  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e6:e0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e6:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:9c:10  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:9c:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@esx-02a:~]

[root@esx-03a:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    14:23:f3:a4:7c:50  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    14:23:f3:a4:7c:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    8c:96:a5:25:81:e9  1500  Intel Corporation I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    8c:96:a5:25:81:ea  1500  Intel Corporation I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    8c:96:a5:25:81:eb  1500  Intel Corporation I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    8c:96:a5:25:81:ec  1500  Intel Corporation I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:9f:80  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:9f:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:87:f0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:87:f1  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b9:40  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b9:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:a0:20  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:a0:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@esx-03a:~]


#dlisnesxi01
[root@dlisnesxi01:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:57:10  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:57:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:57:d0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:57:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:f9:20  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:f9:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:7b:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:7b:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:56:df:80  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:df:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi01:~]
#dlisnesxi02
[root@dlisnesxi02:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:1f:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:1f:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:4f:70  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:4f:71  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:00:70  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:00:71  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:ff:d0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:ff:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:58:6f:f0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6f:f1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi02:~]
#dlisnesxi03  
[root@dlisnesxi03:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:60:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:60:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:02:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:02:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:dd:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:dd:c1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:8f:10  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:8f:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:56:78:00  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:78:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi03:~]

#dlisnesxi04
[root@dlisnesxi04:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:70:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:70:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:59:66:90  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:59:66:91  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:88:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:88:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:01:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:58:01:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:58:2b:60  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:2b:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi04:~]



#dlisnesxi05   
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:eb:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:eb:c1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:84:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:84:c1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:71:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:71:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:a1:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:a1:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:59:47:60  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:59:47:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller

#dlisnesxi06.corp.hynix-dl.com
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6a:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6a:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:76:70  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:76:71  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6e:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6e:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:7b:20  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:7b:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:59:a3:00  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:59:a3:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi06:~]

[root@dlisnesxi07:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:78:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:78:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:16:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:16:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:89:10  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:89:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:b8:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:b8:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:56:e9:40  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:e9:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi07:~]

[root@dlisnesxi08:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8b:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8b:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:ca:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:ca:c1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:94:b0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:94:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:c7:70  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:c7:71  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:c6:d0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:c6:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi08:~]

[root@dlisnesxi09:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:a5:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:a5:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:9c:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:9c:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8d:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8d:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:3a:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:58:3a:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:57:44:e0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:44:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi09:~]

[root@dlisnesxi10:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:c9:20  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:c9:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:a3:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:a3:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:9b:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:9b:c1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:b3:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:b3:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:57:73:b0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:73:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi10:~]

[root@dlisnesxi11:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6f:d0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6f:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:52:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:52:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8c:d0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8c:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:52:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:52:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:57:58:00  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:58:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi11:~]

[root@dlisnesxi12:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    8c:84:74:57:93:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    8c:84:74:57:93:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:92:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:92:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:a1:b0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:a1:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:ad:20  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:ad:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:bd:b0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:bd:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi12:~]

[root@dlisnesxi13:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8d:70  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:8d:71  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    8c:84:74:d1:65:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    8c:84:74:d1:65:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:90:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:90:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:c9:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:c9:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    d4:04:e6:e2:95:20  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    d4:04:e6:e2:95:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi13:~]

[root@dlisnesxi14:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:96:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:96:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:9b:40  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:9b:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6a:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:6a:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:97:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:57:97:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:56:6f:f0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:6f:f1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi14:~]
#### MFG 
[root@dlisnesxi15:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:77:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:77:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:1c:a0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:1c:a1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:9d:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:9d:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:89:a0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:56:89:a1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:58:55:00  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:55:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi15:~]

[root@dlisnesxi16:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:33:70  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:33:71  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:90:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:90:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:8c:20  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:8c:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:95:b0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:57:95:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:58:39:40  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:39:41  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi16:~]

[root@dlisnesxi17:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:71:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:71:c1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:79:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:79:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:90:30  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:90:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:76:a0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:58:76:a1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:57:c2:60  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:c2:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi17:~]

[root@dlisnesxi18:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:75:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:75:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:c0:30  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:c0:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:78:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:78:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:9f:b0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:57:9f:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:56:9d:60  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:9d:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi18:~]

[root@dlisnesxi19:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:b4:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:b4:61  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:ba:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:ba:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:59:80  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:59:81  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:57:05:30  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:57:05:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:56:9b:f0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:56:9b:f1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi19:~]

[root@dlisnesxi20:~] esxcli network nic list
Name    PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0  0000:26:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:77:90  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1  0000:26:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:77:91  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic2  0000:a0:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:52:d0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3  0000:a0:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:52:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4  0000:8a:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:5c:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5  0000:8a:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:5c:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6  0000:b4:00.0  bnxtnet  Up            Up           25000  Full    6c:92:cf:59:41:90  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7  0000:b4:00.1  bnxtnet  Up            Down             0  Half    6c:92:cf:59:41:91  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8  0000:c9:00.0  bnxtnet  Up            Down             0  Half    6c:92:cf:58:33:a0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9  0000:c9:00.1  bnxtnet  Up            Up           25000  Full    6c:92:cf:58:33:a1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi20:~]

####

[root@dlisnesxi21:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:d4:b0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:d4:b1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    90:74:2e:33:a3:fb  1500  Intel(R) I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    90:74:2e:33:a3:fc  1500  Intel(R) I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    90:74:2e:33:a3:fd  1500  Intel(R) I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    90:74:2e:33:a3:fe  1500  Intel(R) I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e6:d0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e6:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e3:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e3:51  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e7:30  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e7:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e3:10  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:e3:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi21:~]

[root@dlisnesxi22:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e7:50  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:e7:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    90:74:2e:33:a2:07  1500  Intel(R) I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    90:74:2e:33:a2:08  1500  Intel(R) I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    90:74:2e:33:a2:09  1500  Intel(R) I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    90:74:2e:33:a2:0a  1500  Intel(R) I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:da:90  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:da:91  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e5:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e5:e1  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e9:d0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e9:d1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:d5:a0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:d5:a1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi22:~]

[root@dlisnesxi23:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:d4:20  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:d4:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    8c:96:a5:25:70:e9  1500  Intel(R) I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    8c:96:a5:25:70:ea  1500  Intel(R) I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    8c:96:a5:25:70:eb  1500  Intel(R) I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    8c:96:a5:25:70:ec  1500  Intel(R) I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    14:23:f3:a4:80:10  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    14:23:f3:a4:80:11  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:9b:30  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:9b:31  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b9:00  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:b9:01  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:8d:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:8d:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi23:~]

[root@dlisnesxi24:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:82:20  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:82:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    8c:96:a5:25:6d:45  1500  Intel(R) I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    8c:96:a5:25:6d:46  1500  Intel(R) I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    8c:96:a5:25:6d:47  1500  Intel(R) I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    8c:96:a5:25:6d:48  1500  Intel(R) I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:a6:20  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:a6:21  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:be:c0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:be:c1  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:7e:e0  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:7e:e1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:80:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:80:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi24:~]

[root@dlisnesxi25:~]  esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:98:50  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:98:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  igbn     Up            Down             0  Half    8c:96:a5:25:6e:fd  1500  Intel(R) I350 Gigabit Network Connection
vmnic11  0000:16:00.1  igbn     Up            Down             0  Half    8c:96:a5:25:6e:fe  1500  Intel(R) I350 Gigabit Network Connection
vmnic12  0000:16:00.2  igbn     Up            Down             0  Half    8c:96:a5:25:6e:ff  1500  Intel(R) I350 Gigabit Network Connection
vmnic13  0000:16:00.3  igbn     Up            Down             0  Half    8c:96:a5:25:6f:00  1500  Intel(R) I350 Gigabit Network Connection
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:7e:f0  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:7e:f1  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e8:60  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:e8:61  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:dd:30  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:dd:31  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    40:5b:7f:6a:d7:50  9000  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    40:5b:7f:6a:d7:51  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi25:~]

[root@dlisnesxi26:~] esxcli network nic list
Name     PCI Device    Driver   Admin Status  Link Status  Speed  Duplex  MAC Address         MTU  Description
-------  ------------  -------  ------------  -----------  -----  ------  -----------------  ----  -----------
vmnic0   0000:28:00.0  bnxtnet  Up            Up           25000  Full    d4:25:de:73:05:0b  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic1   0000:28:00.1  bnxtnet  Up            Down             0  Half    d4:25:de:73:05:0c  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic10  0000:16:00.0  ntg3     Up            Down             0  Half    8c:96:a5:31:cf:dd  1500  Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet
vmnic11  0000:16:00.1  ntg3     Up            Down             0  Half    8c:96:a5:31:cf:de  1500  Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet
vmnic12  0000:16:00.2  ntg3     Up            Down             0  Half    8c:96:a5:31:cf:df  1500  Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet
vmnic13  0000:16:00.3  ntg3     Up            Down             0  Half    8c:96:a5:31:cf:e0  1500  Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet
vmnic2   0000:99:00.0  bnxtnet  Up            Up           25000  Full    d4:25:de:72:df:f7  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic3   0000:99:00.1  bnxtnet  Up            Up           25000  Full    d4:25:de:72:df:f8  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic4   0000:98:00.0  bnxtnet  Up            Up           25000  Full    d4:25:de:73:66:fb  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic5   0000:98:00.1  bnxtnet  Up            Up           25000  Full    d4:25:de:73:66:fc  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic6   0000:a9:00.0  bnxtnet  Up            Up           25000  Full    d4:25:de:73:2d:9b  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic7   0000:a9:00.1  bnxtnet  Up            Up           25000  Full    d4:25:de:73:2d:9c  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic8   0000:a8:00.0  bnxtnet  Up            Up           25000  Full    d4:25:de:73:5b:8b  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
vmnic9   0000:a8:00.1  bnxtnet  Up            Down             0  Half    d4:25:de:73:5b:8c  1500  Broadcom BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
[root@dlisnesxi26:~]
