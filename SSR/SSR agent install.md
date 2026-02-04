1. Download #原文件应该是无锡的安装包已重命名，并更换为大连的SSR安装包。
wget -d -r -np -nd http://10.68.37.105/iso/app/linux/ssr/1.0/ -P /tmp/ssr/1.0/
2.  install 
# sh -x ssr_1.0.sh
3. 检查服务
# systemctl status SSRSA.service
