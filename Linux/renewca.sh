cat > hosts.txt <<EOF
10.160.42.52
10.160.42.56
10.160.42.57
10.160.42.61
10.160.42.62
EOF

ssh-copy-id root@10.160.42.52
ssh-copy-id root@10.160.42.56
ssh-copy-id root@10.160.42.57
ssh-copy-id root@10.160.42.61
ssh-copy-id root@10.160.42.62

ssh root@10.160.42.52
ssh root@10.160.42.56
ssh root@10.160.42.57
ssh root@10.160.42.61
ssh root@10.160.42.62


-----------------------
#!/bin/bash

RCA_FILE="SKhynix_DMTM_Root_CA_G1_certificate.cer"
LCA_FILE="SKhynix_DMTM_lssuing_CA_G1_certificate.cer"
HOSTS="hosts.txt"
DATE=$(date +%F)

for host in $(cat $HOSTS); do
  echo "===== $host ====="

  ssh root@$host "
    cp -a /etc/pki /etc/pki.bak_$DATE
  "

  scp $RCA_FILE root@$host:/etc/pki/ca-trust/source/anchors/
  scp $LCA_FILE root@$host:/etc/pki/ca-trust/source/anchors/

  ssh root@$host "
    update-ca-trust extract
  "

  echo "--- Verify CA on $host ---"
  ssh root@$host "
    trust list | grep -i 'SKhynix'
  "

done