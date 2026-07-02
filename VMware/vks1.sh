vcf context refresh k8s01:k8s01-yml --insecure-skip-tls-verify

kubectl config use-context [context]:[username]-yml-cluster		
02. Provisionig VKS Cluster							
## 1. Create a VKS cluster
vcf context list		
vcf context create supervisor --insecure-skip-tls-verify --type k8s --endpoint https://10.68.230.104 -u administrator@vsphere.local		
		
vcf contest use supervisor:[namespace]		
vcf context list		
kubectl get vkr
kubectl get virtualmachineclasses -n [namespace]		
 cat ~/cert/ca.crt		
cp ~/yaml/cluster-deploy.yaml ~/yaml/cluster-depoly.bak		
vi ~/yaml/cluster-deploy.yaml		
vcf context list		
kubectl apply -f ~/yaml/cluster-deply.yaml -n [namespace]		
kubectl get machine -n [namespace]		
kubectl get cluster -n [namespace]		
kubectl get kcp -n [namespace]		
kubectl get machine -n [namespace]		
 vcf context create [context] --insecure-skip-tls-verify --type k8s --endpoint https://10.68.230.104 -u administrator@vsphere.local --workload-cluster-name [cluster name] --workload-cluster-namespace [namespace]		
vcf context use [context]:[cluster-name]		
vcf context refresh [context]:[cluster-name] --insecure-skip-tls-verify		
vcf context list		
kubectl get nodes		

04. Deploying Applications on a VKS cluster
## Deploying the Bookinfo sample application on a VKS cluster with Istio					
vcf context refresh [context]:[username]-yml-cluster --insecure-skip-tls-verify		
kubectl config use-context [context]:[username]-yml-cluster		
kubectl config current-context		
kubectl create ns bookinfo		
kubectl label --overwrite ns bookinfo pod-security.kubernetes.io/enforce=baseline		
kubectl label namespace bookinfo istio-injection=enabled		
cd ~/istio		
kubectl apply -f bookinfo.yaml -n bookinfo		
kubectl -n bookinfo get pods		
kubectl get pods,svc -n bookinfo		
kubectl -n bookinfo exec "$(kubectl -n bookinfo get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep title		
kubectl apply -f bookinfo-gateway.yaml -n bookinfo		
kubectl get pods,gateway -n bookinfo		
cd ~/istio/istio-1.29.2/		
kubectl apply -f samples/addons/		
vi kiali-gateway.yaml		
cd ~/istio/istio-1.29.2/		
kubectl apply -f samples/bookinfo/platform/kube/bookinfo-versions.yaml -n bookinfo		
kubectl apply -f samples/bookinfo/gateway-api/route-reviews-v1.yaml -n bookinfo		
kubectl apply -f samples/bookinfo/gateway-api/route-reviews-50-v3.yaml -n bookinfo		
kubectl get gateway -n bookinfo		
kubectl get gateway -n istio-system		
		
kubect; apply -f samples/bookinfo/gateway-api/route-reviews-v3.yaml -n bookinfo		


vcf context create goodmit --insecure-skip-tls-verify --type k8s --endpoint https://10.68.230.104 -u administrator@vsphere.local --workload-cluster-name goodmit-lci-cluster --workload-cluster-namespace goodmit-ns
vcf context use goodmit:goodmit-lci-cluster
vcf context refresh goodmit:goodmit-lci-cluster --insecure-skip-tls-verify
kubectl get nodes

#2026年6月23日
1️⃣ 确认 repo 已添加
 vcf package available list -A
2️⃣ 查 Prometheus package
vcf package available list -A | grep -i prometheus
vcf package available list -A 

vcf package available get prometheus.kubernetes.vmware.com -n tkg-system


vcf package install prometheus \
  --package-name prometheus.tanzu.vmware.com \
  --version <版本号> \
  --namespace tanzu-system-monitoring \
  --create-namespace \
  --values-file prometheus-values.yaml