#!/bin/bash
#L4 DSR Setting
mkdir /opt/scripts
cat >"/opt/scripts/start_realsrv.sh" <<EOF
#!/bin/bash

VIP=10.68.229.13

. /etc/rc.d/init.d/functions

case "$1" in
    start)
        echo "Starting for Real Server"
        echo "1" > /proc/sys/net/ipv4/conf/lo/arp_ignore
        echo "2" > /proc/sys/net/ipv4/conf/lo/arp_announce
        echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore
        echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce
        ifconfig lo:0 $VIP netmask 255.255.255.255 up
        ;;
     stop)
        echo "Stopping for Real Server"
        ifconfig lo:0 down
        echo "0" > /proc/sys/net/ipv4/conf/lo/arp_ignore
        echo "0" > /proc/sys/net/ipv4/conf/lo/arp_announce
        echo "0" > /proc/sys/net/ipv4/conf/all/arp_ignore
        echo "0" > /proc/sys/net/ipv4/conf/all/arp_announce
        ;;
     *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac
EOF

chmod +x /opt/scripts/start_realsrv.sh

cat /opt/scripts/start_realsrv.sh |grep ^VIP

/opt/scripts/start_realsrv.sh start

ifconfig -a	

#Auto Start Setting	
chmod +x /etc/rc.d/rc.local	
cat >"/etc/rc.d/rc.local" <<EOF
# AutoStart DSR L4 Service
/opt/scripts/start_realsrv.sh start
EOF
#Systemd Service Setting
cat >"/usr/lib/systemd/system/l4dsr.service" <<EOF
#### Setting Auto boot Service ####
[Unit]
Description=Runs /etc/rc.d/rc.local
Wants=network.target network-online.target
After=network.target network-online.target

[Service]
ExecStart=/etc/rc.d/rc.local

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload && systemctl enable l4dsr.service	