PASSWORD='C2mitAdm!@'

for host in $(cat hosts.txt); do
  sshpass -p "$PASSWORD" ssh-copy-id -o StrictHostKeyChecking=no root@$host
done
