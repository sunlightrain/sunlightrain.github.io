nmcli connection show
nmcli connection add type ethernet con-name ens224 ifname ens224
nmcli connection modify ens224 ipv4.addresses 10.250.131.251/24
nmcli connection modify ens224 ipv4.method manual
nmcli connection up ens224

nmcli connection modify "ens224" 802-3-ethernet.mtu 9000

nmcli connection down "ens224"

nmcli connection up "ens224"

nmcli device show | grep MTU

#---------------    
