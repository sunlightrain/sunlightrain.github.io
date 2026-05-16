#--------------------------------   
# 2026年5月6日
# dlhymmswas01
# dlhymmswas02
cat << EOF >> /etc/fstab
10.250.131.100:/dlhymmswas /data/hymms/uploadPath  nfs rw,hard,bg,vers=3,proto=tcp,nointr,timeo=600,rsize=32768,wsize=32768,suid 0 0
EOF
mount -a 
df -hT
#--------------------------------   
# dlhymmswas01
chown -R hymmsadmin:hymmsadmin /data/hymms/uploadPath
#--------------------------------   

docker compose exec caddy \
    caddy reload --config /etc/caddy/Caddyfile
