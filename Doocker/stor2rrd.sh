[root@dockerhost stor2rrd]# docker load -i stor2rrd.tar
Loaded image: xorux/stor2rrd:latest
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]# docker images
                                                   i Info →   U  In Use
IMAGE                  ID             DISK USAGE   CONTENT SIZE   EXTRA
mariadb:10.6.24        c5c269a33497        641MB          315MB
netboxcommunity/net…   19abbe2e6e75       1.07GB          242MB    U
phpipam/phpipam-cro…   1783ccaf7e2f        320MB          157MB
phpipam/phpipam-www…   8ac208624a21        320MB          157MB
postgres:17-alpine     9a78577340f3        396MB          111MB    U
redis:7-alpine         ee64a64eaab6       60.1MB         17.2MB
valkey/valkey:8.1-a…   e706d1213aab       69.2MB         19.8MB    U
xorux/stor2rrd:late…   5652044f0076        428MB          121MB
[root@dockerhost stor2rrd]# vim docker-compose.yml
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]# docker compose up -d
WARN[0000] /root/stor2rrd/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] Running 3/3
 ✔ Network stor2rrd_default       Created                                                                                                   0.0s
 ✔ Volume stor2rrd_stor2rrd-data  Created                                                                                                   0.0s
 ✔ Container stor2rrd             Started                                                                                                   0.2s
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]#
[root@dockerhost stor2rrd]# cd /home/
assetadmin/ infra/
[root@dockerhost stor2rrd]# cd /home/
assetadmin/ infra/
[root@dockerhost stor2rrd]# docker volume
create   (Create a volume)                                      prune    (Remove unused local volumes)
inspect  (Display detailed information on one or more volumes)  rm       (Remove one or more volumes)
ls       (List volumes)                                         update   (Update a volume (cluster volumes only))
[root@dockerhost stor2rrd]# docker volume
create   (Create a volume)                                      prune    (Remove unused local volumes)
inspect  (Display detailed information on one or more volumes)  rm       (Remove one or more volumes)
ls       (List volumes)                                         update   (Update a volume (cluster volumes only))
[root@dockerhost stor2rrd]# docker volume ls
DRIVER    VOLUME NAME
local     netbox-docker_netbox-media-files
local     netbox-docker_netbox-postgres-data
local     netbox-docker_netbox-redis-cache-data
local     netbox-docker_netbox-redis-data
local     netbox-docker_netbox-reports-files
local     netbox-docker_netbox-scripts-files
local     phpipam_phpipam-db-data
local     phpipam_phpipam-logo
local     stor2rrd_stor2rrd-data
