# 2026年4月23日

# 给镜像打 Tag
docker tag portainer/portainer-ce:sts 10.68.37.208/library/portainer-ce:sts
# 登录Harbor 
docker login 10.68.37.208
# Push 镜像到 10.68.37.208
docker push 10.68.37.208/library/portainer-ce:sts



#------
[root@bootstrap docker]#
[root@bootstrap docker]# docker login 10.68.37.208
Authenticating with existing credentials... [Username: admin]

i Info → To login with a different account, run 'docker logout' followed by 'docker login'


Login Succeeded
[root@bootstrap docker]# docker tag portainer/portainer-ce:sts 10.68.37.208/library/portainer-ce:sts

[root@bootstrap docker]# docker push 10.68.37.208:5000/portainer/portainer-ce:sts
The push refers to repository [10.68.37.208:5000/portainer/portainer-ce]
tag does not exist: 10.68.37.208:5000/portainer/portainer-ce:sts
[root@bootstrap docker]# docker push 10.68.37.208/library/portainer-ce:sts
The push refers to repository [10.68.37.208/library/portainer-ce]
3fcf4bfa9a78: Pushed
02b1f1e552b4: Pushed
349e9f928984: Pushed
d252785ebfef: Pushed
4f4fb700ef54: Pushed
2ff62971c2fb: Pushed
e2439986cdf8: Pushed
654565be2c08: Pushed
sts: digest: sha256:c5d941ecad02feb1153da6b1537a298317ef0da264c41239b286cb7ba5daf03e size: 1811

i Info → Not all multiplatform-content is present and only the available single-platform image was pushed
         sha256:df76590a901e47010977ffe277473908350e13042ac304bbac0798649c63b937 -> sha256:c5d941ecad02feb1153da6b1537a298317ef0da264c41239b286cb7ba5daf03e
[root@bootstrap docker]#
#-------

cat /etc/docker/daemon.json

{
  "insecure-registries": ["10.68.37.208"]
}

# 导出镜像
docker save -o portainer-ce_sts.tar 10.68.37.208/library/portainer-ce:sts
# copy
scp portainer-ce_sts.tar root@10.68.228.61:/root
# 导入镜像
docker load -i portainer-ce_sts.tar



# 命令部署
docker service create \
  --name portainer \
  --constraint 'node.role==manager' \
  --publish mode=host,target=9443,published=443 \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=volume,src=portainer_data,dst=/data \
  --restart-condition=any \
  10.68.37.208/library/portainer-ce:sts