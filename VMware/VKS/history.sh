bootstrap@bootstrap:~$ history
 1009  grep -r samples/addons/
 1010  cd samples/addons/
 1011  ls
 1012  vi prometheus.yaml
 1013  ls
 1014  cd
 1015  lk
 1016  ls
 1017  cd 3rd-party/
 1018  ls
 1019  cd istio/
 1020  ls
 1021  cd
 1022  cd scripts/
 1023  ls
 1024  cd tanzu-standard-scripts/bin/
 1025  ls
 1026  ./tanzu-standard-package-manager.sh
 1027  ls
 1028  cd
 1029  ls
 1030  cd 3rd-party/
 1031  ls
 1032  ./istio-cp.sh
 1033  ls
 1034  cd istio/
 1035  ls
 1036  cd istio-1.29.2/
 1037  ls
 1038  cd samples/
 1039  ls
 1040  cd addons/
 1041  ls
 1042  vi grafana.yaml
 1043  vi jaeger.yaml
 1044  clear
 1045  ls
 1046  vi kiali.yaml
 1047  ls
 1048  vi loki.yaml
 1049  vi grafana.yaml
 1050  ls
 1051  vi jaeger.yaml
 1052  vi prometheus.yaml
 1053  ls
 1054  vi push.sh
 1055  chmod +x push.sh
 1056  ./push.sh
 1057  ls
 1058  vi grafana.yaml
 1059  vi jaeger.yaml
 1060  vi kiali.yaml
 1061  vi loki.yaml
 1062  vi prometheus.yaml
 1063  grep -r image:
 1064  ls
 1065  mv push.sh push-kiali-01.sh
 1066  vi push-kiali-02.sh
 1067  chmod +x push-kiali-02.sh
 1068  ./push-kiali-02.sh
 1069  ls
 1070  cd extras/
 1071  ls
 1072  vi skywalking.yaml
 1073  vi zipkin.yaml
 1074  cd ../../
 1075  ls
 1076  cd ../
 1077  ls
 1078  kubectl apply -f samples/addons/
 1079  kubectl get pods
 1080  kubectl get rsakeys.secretgen.k14s.io
 1081  kubectl get rs
 1082  kubectl get pods -n istio-system
 1083  watch -n 1 'kubectl get pods -n istio-system '
 1084  ls
 1085  vi kiali-gateway.yaml
 1086  kubectl apply -f kiali-gateway.yaml
 1087  kubectl get gateway -n istio-system
 1088  watch -n 1 'kubectl get gateway -n istio-system '
 1089  kubec get pods -n is
 1090  kubectl config current-context
 1091  kubectl get pods -n istio-system
 1092  kubectl config current-context
 1093  kubectl config get-contexts
 1094  ping 10.100.38.1
 1095  ping 10.100.38.11
 1096  kubectl delete -f samples/addons/
 1097  ls
 1098  clear
 1099  ls
 1100  clear
 1101  cd ..
 1102  ls
 1103  cd ..
 1104  ls
 1105  ./istio-cp.sh
 1106  ls
 1107  vi istio-cp.sh
 1108  cd istio/
 1109  ls
 1110  cd istio-1.29.2/
 1111  ls
 1112  cd ..
 1113  cd istio-1.29.2
 1114  kubectl apply -f samples/addons/
 1115  kubectl get pods,svc -n istio-system
 1116  ls
 1117  kubectl delete -f kiali-gateway.yaml
 1118  kubectl get gateway -n istio-system
 1119  kubectl get pods,svc -n istio-system
 1120  clear
 1121  kubectl get pods,svc -n istio-system
 1122  cd ..
 1123  ls
 1124  cd istio-1.29.2/
 1125  ls
 1126  vi kiali-gateway.yaml
 1127  kubectl apply -f kiali-gateway.yaml
 1128  kubectl get gateway -n ki
 1129  kubectl get gateway -n istio-system
 1130  ls
 1131  vi kiali-gateway.yaml
 1132  clear
 1133  kubectl delete -f kiali-gateway.yaml
 1134  clear
 1135  kubectl apply -f kiali-gateway.yaml
 1136  kubectl get svc -n istio-system
 1137  clear
 1138  kubectl delete -f kiali-gateway.yaml
 1139  clear
 1140  kubectl apply -f  kiali-gateway.yaml
 1141  kubectl get gateway -n istio-system
 1142  cd ~
 1143  ls
 1144  sudo ls -al /home/k8s01/
 1145  sudo ls -al /home/k8s01/yaml
 1146  sudo vi /home/k8s01/yaml/yaml-example.yaml
 1147  clear
 1148  exit
 1149  history | grep -i cli
 1150  vi  $USER_HOME/.config/vcf/config.yam
 1151  vi  $USER_HOME/.config/vcf/config.yaml
 1152  vi ~/.config/vcf/config.yaml
 1153  vcf plugin group search | grep 'vmware-vcfcli/default'
 1154  ls
 1155  cd vks-
 1156  mv vks-cli/
 1157  mv vks-cli/ vcf-cli
 1158  cd vcf-cli/
 1159  ls
 1160  cd vcf-cli-plugin/
 1161  ls
 1162  cd namespaces/
 1163  ls
 1164  cd ..
 1165  vi plugin
 1166  vi plugin_manifest.yaml
 1167  vcf
 1168  vcf package --help
 1169  vcf package release
 1170  vcf package releases
 1171  vcf package release
 1172  vcf package release --version
 1173  vcf package release --version 3.6.2
 1174  ls
 1175  cd pa
 1176  cd package/
 1177  ls
 1178  cd v3.4.1/
 1179  ls
 1180  cd ../../
 1181  ls -al
 1182  cd ..
 1183  ls -al
 1184  ls -alh
 1185  vcf plugin list
 1186  vcf plugin source
 1187  vcf plugin source list
 1188  imgpkg
 1189  imgpkg tag
 1190  imgpkg tag list
 1191  imgpkg tag list --help
 1192  imgpkg tag list -i projects.packages.broadcom.com/vcf-cli/plugins/plugin-inventory:latest
 1193  vcf config set features.PLUGIN.FEATURE false
 1194  vcf plugin
 1195  vcf plugin list
 1196  vcf context use
 1197  df -h
 1198  ls -al
 1199  ls -alh
 1200  vcf config set features.PLUGIN.FEATURE true
 1201  vcf context use
 1202  cd ~/.local/vcf
 1203  cd ~/.local/
 1204  ls
 1205  vcf context use
 1206  vcf context refresh --insecure-skip-tls-verify
 1207  vcf context use
 1208  ls -al
 1209  cd
 1210  vcf plugin search
 1211  ls
 1212  vc yaml/
 1213  ls
 1214  cd .local/
 1215  ls
 1216  cd share/
 1217  ls
 1218  cd
 1219  ls
 1220  cd 3rd-party/
 1221  ls
 1222  vi istio-cp.sh
 1223  cp istio-cp.sh vcf-plugin.sh
 1224  vi vcf-plugin.sh
 1225  ./vcf-plugin.sh
 1226  ls -al
 1227  df -h
 1228  vi vcf-plugin.sh
 1229  ./vcf-plugin.sh
 1230  df -h
 1231  ls
 1232  cd vks-cl
 1233  ls
 1234  cd vks-cli/
 1235  ls
 1236  ls -alh
 1237  su goodmit
 1238  clear
 1239  sudo adduser goodmit3
 1240  clear
 1241  ls
 1242  cd 3rd-party/
 1243  ls
 1244  vi istio-cp.sh
 1245  sudo cat /home/k8s01/yaml/yaml-example.yaml
 1246  ls
 1247  vi yaml-example.yaml
 1248  mkdir yaml
 1249  ls
 1250  mv yaml-example.yaml yaml
 1251  ls
 1252  cd yaml/
 1253  ls
 1254  cd. .
 1255  ls
 1256  cd ..
 1257  ls
 1258  done
 1259  sudo ls -al /home/goodmit3/
 1260  sudo ls -al /home/goodmit3/istio
 1261  sudo ls -al /home/goodmit3/yaml
 1262  sudo chown -R goodmit3:goodmit3 /home/goodmit3/yaml
 1263  sudo ls -al /home/goodmit3/yaml
 1264  sudo ls -al /home/goodmit3/
 1265  clear
 1266  ls
 1267  cd ..
 1268  ls
 1269  cd cert/
 1270  ls
 1271  cd ..
 1272  ls
 1273  USER="goodmit3"
 1274  done
 1275  ls
 1276  cd yaml/
 1277  ls
 1278  cd ..
 1279  ls
 1280  su goodmit
 1281  ls
 1282  cd ~
 1283  ls
 1284  cs scripts/
 1285  ls
 1286  cd scripts/
 1287  ls
 1288  cd ..
 1289  ls
 1290  cd yaml/
 1291  ls
 1292  cd ..
 1293  ls
 1294  cd 3rd-party/
 1295  ls
 1296  cd yaml/
 1297  ls
 1298  cd ..
 1299  ls
 1300  cd ..
 1301  ls
 1302  cd vks-cluster/
 1303  ls
 1304  cd ..
 1305  ls
 1306  cd vcf-cli/
 1307  ls
 1308  cd ..
 1309  ls
 1310  clear
 1311  ls
 1312  cd yaml/
 1313  ls
 1314  cd ..
 1315  ls
 1316  exit
 1317  sudo passwd bootstrap
 1318  clear
 1319  ls
 1320  cd cert/
 1321  ls
 1322  rm ca.crt
 1323  ls
 1324  scp harbor@10.68.228.111:/home/harbor/cert/ca.crt ./
 1325  ls
 1326  history | grep -i ca
 1327  ls
 1328  cp ca.crt /usr/local/share/ca-certificates/
 1329  sudo cp ca.crt /usr/local/share/ca-certificates/
 1330  ls
 1331  sudo update-ca-certificates
 1332  sudo systemctl restart docker
 1333  sudo cp ca.crt /usr/local/share/ca-certificates/~
 1334  ls -al /usr/local/share/ca-certificates/
 1335  cd /usr/local/share/ca-certificates/
 1336  ls
 1337  ls -al
 1338  ls
 1339  rm ./*
 1340  sudo rm ./*
 1341  ls
 1342  cd ~
 1343  ls
 1344  cd cert/
 1345  ls
 1346  history
 1347  sudo cp ca.crt /usr/local/share/ca-certificates/
 1348  ls
 1349  cd /usr/local/share/ca-certificates/
 1350  ls
 1351  cd ~
 1352  ls
 1353  sudo update-ca-certificates
 1354  docker login -u admin harbor-01a.corp.hynix-dl.dev
 1355  exit
 1356  clear
 1357  history | grep -i img
 1358  imgpkg tag list -i harbor.hy.poc/vks/packages/standard/repo
 1359  imgpkg tag list -i harbor-01a.corp.hynix-dl.dev/vks
 1360  imgpkg tag list -i harbor-01a.corp.hynix-dl.dev/vks/
 1361  imgpkg tag list -i harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo
 1362  ls
 1363  cd yaml/
 1364  ls
 1365  cd ..
 1366  cd vks-cluster/
 1367  ls
 1368  cd 1-34/
 1369  ls
 1370  vi sk-v1beta2.yaml
 1371  cd
 1372  ls
 1373  cd cert/
 1374  ls
 1375  ls -al
 1376  cat ca
 1377  cat ca.crt
 1378  cd
 1379  ls
 1380  cd 3rd-party/
 1381  ls
 1382  cd
 1383  cd vks-cluster/
 1384  ls
 1385  cd 1-34/
 1386  ls
 1387  vi goodmit-lci.yaml
 1388  kubectl config get-contexts
 1389  kubectl config use-context supervisor
 1390  kubectl get nodes
 1391  kubectl get kcp -n goodmit-ns
 1392  kubectl get kcp -n goodmit-ns  -o wide
 1393  kubectl get cluster -n goodmit-ns  -o wide
 1394  kubectl get vm -n goodmit-ns
 1395  kubectl get vm -n goodmit-ns  -o wide
 1396  kubectl config get-contexts
 1397  cd ~
 1398  ls
 1399  cd scripts/
 1400  ls
 1401  ./ssh-access.sh
 1402  ls
 1403  history | grep -i vcf
 1404  ls
 1405  cd ..
 1406  ls
 1407  cp -r ./scripts/ /home/goodmit/
 1408  sudo cp -r ./scripts/ /home/goodmit/
 1409  ls /home/goodmit/
 1410  sudo ls /home/goodmit/
 1411  sudo ls -al /home/goodmit/
 1412  sudo chown -R goodmit:goodmit /home/goodmit/scripts
 1413  sudo ls -al /home/goodmit/
 1414  exit
 1415  ls
 1416  cd vks-cluster/
 1417  ls
 1418  cd 1-34/
 1419  ls
 1420  vi goodmit-cl.yaml
 1421  cd
 1422  cd 3rd-party/
 1423  ls
 1424  cd fluentbit/
 1425  ls
 1426  vi fluentbit.yaml
 1427  ls
 1428  cp fluentbit.yaml ~
 1429  cd
 1430  ls
 1431  cd vks-cluster/
 1432  ls
 1433  cd 1-34/
 1434  ls
 1435  vi sk-v1beta2.yaml
 1436  vi goodmit-cl.yaml
 1437  vcf context create goodmit-lci --endpoint 10.68.230.104 --username administrator@vsphere.local --workload-cluster-name goodmit-lci-cluster --workload-cluster-namespace goodmit-ns --insecure-skip-tls-verify
 1438  vcf context use
 1439  kubectl get nodes
 1440  ls
 1441  cd
 1442  cd scripts/
 1443  ls
 1444  cd tanzu-standard-scripts/
 1445  ls
 1446  cd bin/
 1447  ls
 1448  vcf package repository list
 1449  vcf package repository list -A
 1450  kubectl get apps -A
 1451  history | grep -i imgpkg
 1452  imgpkg tag list -i harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo
 1453  vcf package repository add my-repo --url harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo:3.6.0-20260416 -n tkg-system
 1454  lcd
 1455  cat ~/cert/ca.crt
 1456  kubectl config current-context
 1457  vcf context create supervisor --endpoint 10.68.230.104 --insecure-skip-tls-verify --username administrator@vsphere.local
 1458  vcf context create supervisor --endpoint 10.68.230.104 --insecure-skip-tls-verify --username administrator@vsphere.local --type k8s
 1459  kubectl config use-context supervisor
 1460  kubectl get nodes
 1461  kubectl -n goodmit-ns edit kappcontrollerconfigs.run.tanzu.vmware.com goodmit-lci-cluster-kapp-controller-package
 1462  cat ~/cert/ca.crt
 1463  kubectl -n goodmit-ns edit kappcontrollerconfigs.run.tanzu.vmware.com goodmit-lci-cluster-kapp-controller-package
 1464  kubectl config use-context goodmit-lci:goodmit-lci-cluster
 1465  kubectl get nodes
 1466  history | grep -i package
 1467  vcf package repository add my-repo --url harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo:3.6.0-20260416 -n tkg-system
 1468  kubectl -n tkg-system get cm kapp-controller-config -o yaml
 1469  kubectl -n tkg-system get pods
 1470  kubectl -n tkg-system rollout restart deployment kapp-controller
 1471  kubectl -n tkg-system get pods~
 1472  kubectl -n tkg-system get pods
 1473  vcf package repository add my-repo --url harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo:3.6.0-20260416 -n tkg-system
 1474  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1475  kubectl config current-context
 1476  kubectl config set-context --help
 1477  kubectl config set --helmp
 1478  kubectl config set --help
 1479  vi ~/.kube/config
 1480  kubectl config set-context --help
 1481  kubectl config set-context --namespace defalut
 1482  kubectl get ns
 1483  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1484  ~
 1485  kubectl config set-context --namespace defalut --current
 1486  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1487  kubectl config set-context --namespace default --current
 1488  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1489  kubectl label namespaces default pod-security.kubernetes.io/enforce=privileged
 1490  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1491  kubectl get pods
 1492  kubectl describe po nginx
 1493  cd
 1494  cd cert/
 1495  ls
 1496  ls -al
 1497  docker login harbor-01a.corp.hynix-dl.dev
 1498  openssl s_client -connect harbor-01a.corp.hynix-dl.dev:443 -servername harbor-01a.corp.hynix-dl.dev -CAfile ca.crt -verify_hostname harbor-01a.corp.hynix-dl.dev -verify_return_error
 1499  openssl s_client -connect harbor-01a.corp.hynix-dl.dev:443 -servername harbor-01a.corp.hynix-dl.dev -CAfile ca.crt -verify_hostname harbor-01a.corp.hynix-dl.dev -verify_return_error -brief < /dev/null
 1500  ls
 1501  cat ca.crt
 1502  ls
 1503  kubectl config use-context supervisor
 1504  kubectl get cluster -n goodmit-ns
 1505  kubectl get cluster -n goodmit-ns goodmit-lci-cluster
 1506  kubectl get cluster -n goodmit-ns goodmit-lci-cluster -o yaml
 1507  kubectl
 1508  kubectl -n goodmit-ns edit cluster goodmit-yml-cluster
 1509  kubectl edit cluster -n goodmit-ns goodmit-lci-cluster
 1510  kubectl -n goodmit-ns edit cluster goodmit-yml-cluster
 1511  kubectl edit cluster -n goodmit-ns goodmit-lci-cluster
 1512  kubectl get machine -n goodmit-ns
 1513  watch -n 1 'kubectl get machine -n goodmit-ns '
 1514  kubectl edit cluster -n goodmit-ns goodmit-lci-cluster
 1515  watch -n 1 'kubectl get machine -n goodmit-ns '
 1516  kubectl config use-context goodmit-lci:goodmit-lci-cluster
 1517  kubectl get pods
 1518  history | grep -i run
 1519  kubectl delete po nginx
 1520  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1521  kubectl delete po nginx
 1522  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1523  kubectl get pods
 1524  history | grep -i repo
 1525  kubectl run nginx --image harbor-01a.corp.hynix-dl.dev/library/nginx --port 80
 1526  vcf package repository add my-repo --url harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo:3.6.0-20260416 -n tkg-system
 1527  ls
 1528  cd
 1529  cd scripts/
 1530  ls
 1531  cd tanzu-standard-scripts/
 1532  ls
 1533  cd bin/
 1534  ls
 1535  ./tanzu-standard-package-manager.sh
 1536  vcf package installed list -A
 1537  ls
 1538  ./tanzu-standard-package-manager.sh
 1539  cd
 1540  ls
 1541  cd is
 1542  cd 3rd-party/
 1543  ls
 1544  cd istio/
 1545  ls
 1546  vi bookinfo.yaml
 1547  vi bookinfo-gateway.yaml
 1548  ls
 1549  cd is
 1550  cd istio-1.29.2/
 1551  ls
 1552  vi kiali-gateway.yaml
 1553  cd manifests/
 1554  ls
 1555  grap -r harbor.hy.poc
 1556  grep -r harbor.hy.poc
 1557  grep -r harb
 1558  cd ..
 1559  ls
 1560  grep -r harbor.hy.poc
 1561  OLD='harbor.hy.poc'
 1562  NEW='harbor-01a.corp.hynix-dl.dev'
 1563  grep -RIlF "$OLD" . | xargs -r sed -i.bak 's|harbor\.hy\.poc|harbor-01a.corp.hynix-dl.dev|g'
 1564  grep -r harbor.hy.poc
 1565  grep -RIlF 'harbor.hy.poc' . | xargs -r sed -i.bak 's|harbor\.hy\.poc|harbor-01a.corp.hynix-dl.dev|g'
 1566  grep -r harbor.hy.poc
 1567  grep -RIlF 'harbor.hy.poc' ./* | xargs -r sed -i.bak 's|harbor\.hy\.poc|harbor-01a.corp.hynix-dl.dev|g'
 1568  grep -r harbor.hy.poc
 1569  cd samples/
 1570  ls
 1571  cd addons/
 1572  ls
 1573  rm -rf *.bak
 1574  rm -rf *.bak.bak
 1575  ls -al
 1576  cd ../../
 1577  ls
 1578  grep -r harbor-01a
 1579  cd
 1580  kubectl concu
 1581  kubectl config current-context
 1582  kubectl config use-context goodmit-lci:goodmit-lci-cluster
 1583  ls
 1584  cd 3rd-party/
 1585  ls
 1586  cd istio/
 1587  ls
 1588  cd istio-1.29.2/
 1589  ls
 1590  cd
 1591  cd scripts/
 1592  ls
 1593  cd tanzu-standard-scripts/
 1594  cd bin/
 1595  ls
 1596  ./tanzu-standard-package-manager.sh
 1597  kubectl config current-context
 1598  kubectl get pods -n istio-system
 1599  kubectl logs -n istio-system istiod-7df4545b7-jf6p7
 1600  kubectl describe po -n istio-system istiod-7df4545b7-jf6p7
 1601  kubectl get nodes
 1602  kubectl config current-context
 1603  kubectl config use-context supervisor
 1604  ls
 1605  kubectl edit cluster -n goodmit-ns goodmit-lci-cluster
 1606  kubectl config current-context
 1607  kubectl config use-context goodmit-lci:goodmit-lci-cluster
 1608  kubectl get nodes
 1609  kubectl get pods -A
 1610  kubectl get apps -A
 1611  clear
 1612  ls
 1613  cd
 1614  ls
 1615  kubectl config current-context
 1616  cd 3rd-party/
 1617  ls
 1618  kubectl create ns bookinfo
 1619  kubectl label --overwrite ns bookinfo pod-security.kubernetes.io/enforce=baseline
 1620  kubectl label ns bookinfo istio-injection=enabled
 1621  cd istio/
 1622  ls
 1623  kubectl apply -f bookinfo.yaml -n bookinfo
 1624  kubectl -n bookinfo get pods
 1625  watch -n 1 'kubectl -n bookinfo get pods'
 1626  kubectl apply -f bookinfo-gateway.yaml -n bookinfo
 1627  kubectl -n bookinfo get pods
 1628  kubectl -n bookinfo get all
 1629  watch -n 1 'kubectl -n bookinfo get all'
 1630  cd istio-1.29.2/
 1631  ls
 1632  kubectl apply -f samples/addons/
 1633  vi kiali-gateway.yaml
 1634  ls
 1635  kubectl apply -f kiali-gateway.yaml
 1636  kubectl get gateway -n istio-system
 1637  watch -n 1 'kubectl get gateway -n istio-system'
 1638  kubectl -n istio-system get pods
 1639  watch -n 1 'kubectl get gateway -n istio-system'
 1640  kubectl -n istio-system get all
 1641  watch -n 1 'kubectl -n istio-system get all'
 1642  kubectl -n istio-system describe po 10.68.230.112
 1643  kubectl -n istio-system describe svc kiali-gateway-istio
 1644  watch -n 1 'kubectl -n istio-system get all'
 1645  kubectl apply -f samples/bookinfo/platform/kube/bookinfo-versions.yaml
 1646  kubectl delete -f samples/bookinfo/platform/kube/bookinfo-versions.yaml
 1647  kubectl apply -f samples/bookinfo/platform/kube/bookinfo-versions.yaml -n bookinfo
 1648  kubectl apply -f samples/bookinfo/gateway-api/route-reviews-v1.yaml -n bookinfo
 1649  kubectl apply -f samples/bookinfo/gateway-api/route-reviews-50-v3.yaml -n bookinfo
 1650  kubectl get gateway -n istio-system
 1651  kubectl apply -f samples/bookinfo/gateway-api/route-reviews-v3.yaml -n bookinfo
 1652  ls
 1653  cd ../
 1654  ls
 1655  cd ..
 1656  ls
 1657  vi istio-cp.sh
 1658  ./istio-cp.sh
 1659  adduser k8s05
 1660  sudo adduser k8s05
 1661  ./istio-cp.sh
 1662  ls
 1663  cd
 1664  ls
 1665  cd yaml/
 1666  ls
 1667  cd ..
 1668  ls
 1669  su goodmit
 1670  ls
 1671  cd 3rd-party/
 1672  ls
 1673  vi istio-cp.sh
 1674  su goodmit
 1675  ls
 1676  cd
 1677  ls
 1678  cd 3rd-party/
 1679  ls
 1680  vi istio-cp.sh
 1681  ls
 1682  su k8s01
 1683  ls
 1684  ./istio-cp.sh
 1685  ls
 1686  su k8s05
 1687  deluser k8s05
 1688  sudo deluser k8s05
 1689  sudo adduser k8s05
 1690  rm -rf /home/k8s05/
 1691  sudo rm -rf /home/k8s05/
 1692  adduser k8s05
 1693  sudo adduser k8s05
 1694  sudo deluser k8s05
 1695  sudo adduser k8s05
 1696  ls
 1697  cd
 1698  ls
 1699  su k8s05
 1700  ls
 1701  cd 3rd-party/
 1702  ls
 1703  ./istio-cp.sh
 1704  su k8s05
 1705  su goodmit
 1706  ls
 1707  cd vks-packages/
 1708  ls
 1709  cd
 1710  cd scripts/
 1711  ls
 1712  cd tanzu-standard-scripts/
 1713  ls
 1714  cd bin/
 1715  ls
 1716  pwd
 1717  ld
 1718  ls
 1719  cd cert/
 1720  ls
 1721  cat ca.crt
 1722  vcf context list
 1723  vcf context delete moon
 1724  vcf context delete supervisor -y
 1725  vcf context list
 1726  kubectl config get-contexts
 1727  kubectl config delete-context supervisor:goodmit3
 1728  kubectl config get-contexts
 1729  clear
 1730  ls
 1731  cd ..
 1732  ls
 1733  cd yaml/
 1734  ls
 1735  cd ..
 1736  ls
 1737  su goodmit
 1738  ls
 1739  su k8s01
 1740  ls
 1741  cd 3rd-party/
 1742  ls
 1743  vi istio
 1744  vi istio-cp.sh
 1745  cp istio-cp.sh cert-cp.sh
 1746  vi cert-cp.sh
 1747  ./cert-cp.sh
 1748  clear
 1749  ls
 1750  cd
 1751  ls
 1752  kubectl config current-context
 1753  kubectl get nodes
 1754  cd 3rd-party/
 1755  ls
 1756  cd istio/
 1757  ls
 1758  cd istio-1.29.2/
 1759  ls
 1760  kubectl delete -f kiali-gateway.yaml
 1761  kubectl delete -f samples/addons/
 1762  cd ..
 1763  ls
 1764  kubectl delete -f .
 1765  kubectl delete -f bookinfo-gateway.yaml
 1766  kubectl -n bookinfo get all
 1767  kubectl delete -f bookinfo-gateway.yaml -n bookinfo
 1768  kubectl delete -f bookinfo.yaml -n bookinfo
 1769  kubectl delete -f istio-1.29.2/samples/bookinfo/platform/kube/.
 1770  kubectl delete -f istio-1.29.2/samples/bookinfo/platform/kube/bookinfo-versions.yaml
 1771  kubectl -n bookinfo get all
 1772  kubectl delete -f istio-1.29.2/samples/bookinfo/platform/kube/bookinfo-versions.yaml -n bookinfo
 1773  kubectl get httproutes.gateway.networking.k8s.io
 1774  kubectl get crd | grep -i http
 1775  cd cert/
 1776  ls
 1777  pwd
 1778  ls
 1779  mv ca.crt sk-dl-self-ca.crt
 1780  mv sk-dl-self-ca.crt sk-dl-self-signed-ca.crt
 1781  clear
 1782  ls
 1783  vcf context use
 1784  vcf context refresh --insecure-skip-tls-verify
 1785  clear
 1786  kubectl get nodes
 1787  ls
 1788  cd
 1789  cd 3rd-party/
 1790  ls
 1791  cd istio/
 1792  ls
 1793  kubectl get ns
 1794  kubectl apply -f bookinfo.yaml -n bookinfo
 1795  kubectl -n bookinfo get pods
 1796  kubectl apply -f bookinfo-gateway.yaml -n bookinfo
 1797  kubectl -n bookinfo get pods
 1798  kubectl -n bookinfo get svc
 1799  watch -n 1 kubectl -n bookinfo get svc
 1800  ls
 1801  cd
 1802  cd scripts/tanzu-standard-scripts/
 1803  ls
 1804  cd bin/
 1805  ls
 1806  ./tanzu-standard-package-manager.sh
 1807  kubectl config current-context
 1808  history | grep -i create
 1809  vcf context create goodmit-lci --endpoint 10.68.230.104 --username administrator@vsphere.local --workload-cluster-name goodmit-yml-cluster --workload-cluster-namespace goodmit-ns --insecure-skip-tls-verify
 1810  vcf context create goodmit-yml --endpoint 10.68.230.104 --username administrator@vsphere.local --workload-cluster-name goodmit-yml-cluster --workload-cluster-namespace goodmit-ns --insecure-skip-tls-verify
 1811  ls
 1812  kubectl config current-context
 1813  kubectl config use-context goodmit-yml:goodmit-yml-cluster
 1814  kubectl get nodes
 1815  ls
 1816  ./tanzu-standard-package-manager.sh
 1817  clear
 1818  cd
 1819  ls
 1820  kubectl config use-context goodmit-lci:goodmit-lci-cluster
 1821  kubectl get nodes
 1822  vcf context
 1823  clear
 1824  kubectl config current-context
 1825  kubectl get pods,svc
 1826  kubectl config current-context
 1827  kubectl get pods
 1828  kubectl get ns
 1829  history | grep -i create
 1830  ls
 1831  vi ~/.kube/config
 1832  kubectl get pods
 1833  vi ~/.kube/config
 1834  clear
 1835  kubectl get nodes
 1836  kubectl -n bookinfo get pods
 1837  clear
 1838  kubectl -n bookinfo get pods
 1839  clear
 1840  kubectl apply -f 3rd-party/istio/istio-1.29.2/samples/addons/
 1841  kubectl apply -f 3rd-party/istio/istio-1.29.2/kiali-gateway.yaml
 1842  kubectl get all -n bookinfo
 1843  kubectl get all,gateway -n bookinfo
 1844  kubectl -n istio-system get all,gateway
 1845  ls
 1846  kubectl apply -f 3rd-party/istio/istio-1.29.2/samples/bookinfo/platform/kube/bookinfo-versions.yaml
 1847  kubectl apply -f 3rd-party/istio/istio-1.29.2/samples/bookinfo/platform/kube/bookinfo-versions.yaml -n bookinfo
 1848  kubectl delete -f 3rd-party/istio/istio-1.29.2/samples/bookinfo/platform/kube/bookinfo-versions.yaml
 1849  kubectl -n bookinfo get svc
 1850  kubectl -n bookinfo get httproutes.gateway.networking.k8s.io
 1851  kubectl -n bookinfo delete httproutes.gateway.networking.k8s.io reviews
 1852  kubectl -n bookinfo get httproutes.gateway.networking.k8s.io
 1853  kubectl get all -n tanzu-system-monitoring
 1854  kubectl config use-context supervisor
 1855  kubectl get nodes
 1856  clear
 1857  vcf context refresh --insecure-skip-tls-verify
 1858  vcf context refresh --insecure-skip-tls-verify supervisor
 1859  kubectl get nodes
 1860  kubectl config use-context supervisor
 1861  kubectl get nodes
 1862  kubectl get pods -n svc-cci-ns-domain-c10
 1863  kubectl get all -n svc-cci-ns-domain-c10
 1864  kubectl config use-context goodmit-lci:goodmit-lci-cluster
 1865  kubectl get nodes
 1866  kubectl get all -n tanzu-system-monitoring
 1867  exit
 1868  vcf context create --endpoint=vc-mgmt-a.corp.hynix-dl.dev
 1869  cat /etc/passwd
 1870  cd
 1871  cd .cache/
 1872  ;s
 1873  ls
 1874  sudo cp -r vcf/ /home/k8s04/.cache/
 1875  sudo chown -R k8s04:k8s04 /home/k8s04/.cache/vcf
 1876  exit
 1877  clear
 1878  vcf context list
 1879  vcf context refresh goodmit-lci:goodmit-lci-cluster --insecure-skip-tls-verify
 1880  vcf context refresh goodmit-lci:goodmit-lci-cluster --insecure-skip-tls-verify
 1881  kubectl get nodes
 1882  kubectl get apps -A
 1883  clear
 1884  ls
 1885  cd 3rd-party/
 1886  ls
 1887  cd
 1888  ls
 1889  history
 1890  history | grep -i add
 1891  ls
 1892  vcf context list
 1893  vcf context use goodmit-yml:goodmit-yml-cluster
 1894  vcf context refresh --insecure-skip-tls-verify goodmit-yml:goodmit-yml-cluster
 1895  clear
 1896  vcf context use
 1897  kubectl config current-context
 1898  kubectl get nodes
 1899  kubectl get apps -A
 1900  clear
 1901  su k8s01
 1902  su k8s02
 1903  ls
 1904  cat yaml/
 1905  cd vks-
 1906  cd vks-cluster/
 1907  ls
 1908  cd 1-34/
 1909  ls
 1910  cat goodmit-cl.yaml
 1911  cd ..
 1912  ls
 1913  cd ..
 1914  ls
 1915  cat cert/sk-dl-self-signed-ca.crt
 1916  cat yaml/istio-values.yaml
 1917  vcf context list
 1918  clear
 1919  kubectl config current-context
 1920  su k8s01
 1921  cd ~
 1922  ls
 1923  cd yaml/
 1924  ls
 1925  cd ..
 1926  ls
 1927  su goodmit
 1928  clear
 1929  exit
 1930  clear
 1931  kubectl get nodes
 1932  alias
 1933  vcf context refresh --insecure-skip-tls-verify
 1934  kubectl get nodes
 1935  vcf context use
 1936  clear
 1937  kubectl config current-context
 1938  kubectl get nodes
 1939  kubectl get pods,gateway -n bookinfo
 1940  kubectl get apps -A
 1941  clear
 1942  su k8s01
 1943  ls
 1944  cd 3rd-party/
 1945  ls
 1946  vi vcf-plugin.sh
 1947  vi istio-cp.sh
 1948  ./istio-cp.sh
 1949  su k8s01
 1950  clear
 1951  cd
 1952  ls
 1953  su k8s03
 1954  clear
 1955  cd ~
 1956  vcf context list
 1957  kubectl get nodes
 1958  vcf  context refresh --insecure-skip-tls-verify
 1959  kubectl get nodes
 1960  kubectl get all -n bookinfo
 1961  kubectl get all -n istio-system
 1962  kubectl get svc -n tanzu-system-monitoring
 1963  kubectl config current-context
 1964  kubectl config use-context supervisor
 1965  kubectl get nodes
 1966  clear
 1967  vcf context refresh --insecure-skip-tls-verify
 1968  kubectl config use-context supervisor
 1969  kubectl -n vmware-system-logging get cm fluentbit-config -o yaml
 1970  ls
 1971  cd 3rd-party/
 1972  ls
 1973  cd fluentbit/
 1974  ls
 1975  vi fluentbit.yaml
 1976  ~
 1977  kubectl get nodes
 1978  d
 1979  clear
 1980  ls
 1981  cd vks-packages/
 1982  ls
 1983  cd ..
 1984  ls
 1985  cd vks-cluster/
 1986  ls
 1987  cd 1-34/
 1988  ls
 1989  cd ..
 1990  ls
 1991  cd ..
 1992  ls
 1993  cd ls
 1994  cd /home/
 1995  ls
 1996  cd goodmit
 1997  sudo cd goodmit
 1998  cat /etc/passwd
 1999  su goodmit -
 2000  ls
 2001  vcf context list
 2002  kubectl get all -n tanzu-system-monitoring
 2003  vcf context list
 2004  vcf context use
 2005  kubectl get all -n tanzu-system-monitoring
 2006  kubectl get all
 2007  kubectl get nodes
 2008  history
整理上述历史信息，我想再VKS 集群内部部署 prometheus，如何实现？