C:\Users\x7020856\Downloads\DeployVMs.csv


sudo pvcreate /dev/sdc
sudo vgextend datavg /dev/sdc
sudo lvextend -l +100%FREE /dev/datavg/datalv
sudo xfs_growfs /data/