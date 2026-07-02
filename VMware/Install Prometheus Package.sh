
# Create Prometheus Data Values

#1 Get the latest Prometheus package version for your repository.
vcf package available get prometheus.tanzu.vmware.com -n tkg-system #已不再使用
#For Prometheus 2.53.4 and later versions, list package with prometheus.kubernetes.vmware.com
vcf package available get prometheus.kubernetes.vmware.com -n tkg-system
#Or, using kubectl.
kubectl -n tkg-system get packages | grep prometheus
##============================================##
k8s01@bootstrap:~$ vcf package available get prometheus.kubernetes.vmware.com -n tkg-system
[i] Refreshing plugin inventory cache for "projects.packages.broadcom.com/vcf-cli/plugins/plugin-inventory:latest", this will take a few seconds.

  NAME:                   prometheus.kubernetes.vmware.com
  DISPLAY-NAME:           prometheus
  CATEGORIES:             - monitoring
- observability
  SHORT-DESCRIPTION:      A time series database for your metrics
  LONG-DESCRIPTION:       A time series database for your metrics
  PROVIDER:               VMware
  MAINTAINERS:            - name: David Quan
  SUPPORT-DESCRIPTION:    The detailed documentation is on https://prometheus.io/. Support is available
from VMware. Refer to the VMware Product Guide for specific support terms.

  VERSION               RELEASED-AT
  3.5.0+vmware.1-vks.2  2025-10-23 02:00:00 +0800 CST
  3.5.0+vmware.2-vks.1  2025-12-19 02:00:00 +0800 CST
  3.5.0+vmware.3-vks.1  2026-02-12 02:00:00 +0800 CST
  3.5.1+vmware.1-vks.1  2026-04-17 02:00:00 +0800 CST
k8s01@bootstrap:~$ kubectl -n tkg-system get packages | grep prometheus
prometheus.kubernetes.vmware.com.3.5.0+vmware.1-vks.2                     prometheus.kubernetes.vmware.com                    3.5.0+vmware.1-vks.2            451h30m46s
prometheus.kubernetes.vmware.com.3.5.0+vmware.2-vks.1                     prometheus.kubernetes.vmware.com                    3.5.0+vmware.2-vks.1            451h30m46s
prometheus.kubernetes.vmware.com.3.5.0+vmware.3-vks.1                     prometheus.kubernetes.vmware.com                    3.5.0+vmware.3-vks.1            451h30m46s
prometheus.kubernetes.vmware.com.3.5.1+vmware.1-vks.1                     prometheus.kubernetes.vmware.com                    3.5.1+vmware.1-vks.1            451h30m46s
k8s01@bootstrap:~$
##============================================##
#2 Generate the prometheus-data-values.yaml file.
vcf package available get prometheus.kubernetes.vmware.com/3.5.0+vmware.3-vks.1 --default-values-file-output prometheus-data-values.yaml
#3 Edit the prometheus-data-values.yaml file and configure the following values which are required to access the Prometheus dashboard. See Prometheus Package Reference for an example data values file and a full list of configuration parameters.
Parameter	            Description
namespace               The namespace is where Prometheus is deployed. (default is tanzu-system-monitoring)
deploycomponents        Select the components which you want to deploy. If this object is omitted, all components are deployed by default (default = true). Note: prometheus-operator defaults to false and must be explicitly enabled.
ingress.tlsCertificate.tls.crt	A self-signed TLS cert is generated for ingress. Optionally you can override and provide your own.
ingress.tlsCertificate.tls.key	A self-signed TLS private key is generated for ingress. Optionally you can override and provide your own.
ingress.enabled	        Set the value to true (default is false).
ingress.virtual_host_fqdn	    Set the value to prometheus.<your.domain> (default is prometheus.system.tanzu).
alertmanager.pvc.storageClassName	Enter the name of the vSphere storage policy.
prometheus.pvc.storageClassName     Enter the name of the vSphere storage policy.

# Install Prometheus

#1 Create the namespace in which you want to install the Prometheus package.
kubectl create ns my-packages
#2 Install Prometheus.
vcf package install prometheus -p prometheus.kubernetes.vmware.com -v 3.5.0+vmware.3-vks.1 --values-file prometheus-data-values.yaml -n my-packages
#3 Verify Prometheus installation.
vcf package installed list -n my-packages
vcf package installed get prometheus -n my-packages
#4 Verify Prometheus and Altermanager objects.
kubectl -n tanzu-system-monitoring get all

kubectl -n tanzu-system-monitoring get pvc

NAME                STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
alertmanager        Bound    pvc-a53f7091-9823-4b70-a9b4-c3d7a1e27a4b   2Gi        RWO            k8s-policy     2m30s
prometheus-server   Bound    pvc-41745d1d-9401-41d7-b44d-ba430ecc5cda   20Gi       RWO            k8s-policy     2m30s
##============================================##
kubectl create ns tanzu-system-monitoring
vcf package install prometheus -p prometheus.kubernetes.vmware.com -v 3.5.0+vmware.3-vks.1 --values-file prometheus-3.5.0+vmware.3-vks.1-values.yaml -n tanzu-system-monitoring
vcf package installed list -n tanzu-system-monitoring
vcf package installed get prometheus -n tanzu-system-monitoring
##============================================##

#############

# Create a vcf context for the workload cluster
vcf context create k8s01-lci-cluster1 --endpoint 10.68.230.104 --username administrator@vsphere.local --workload-cluster-name k8s01-lci-cluster1 --workload-cluster-namespace k8s01-ns --insecure-skip-tls-verify
# 使用 context
vcf context use k8s01-lci-cluster1:k8s01-lci-cluster1
# 查看repo列表
vcf package repository list
vcf package repository list -A
# 查看已安装的package列表
kubectl get apps -A
# 查看 repo版本号
imgpkg tag list -i harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo
# 添加repo  
vcf package repository add my-repo --url harbor-01a.corp.hynix-dl.dev/vks/packages/standard/repo:3.6.0-20260416 -n tkg-system

# 完成后，我们可以查看可用的软件包。其中应包含 telegraf 和 prometheus 的条目。
vcf package available list -n tkg-system
# 验证可用的 Prometheus 版本
vcf package available get prometheus.kubernetes.vmware.com -n tkg-system
# 验证可用的 Telegraf 版本
vcf package available get telegraf.kubernetes.vmware.com -n tkg-system
# Create a namespace for package installations
kubectl create ns package-installs
# Install Telegraf agent 安装报错，需排查。
# For the telegraf installation a data values file is required
vcf package available get telegraf.kubernetes.vmware.com/1.35.4+vmware.1-vks.1 --default-values-file-output telegraf-data-values.yaml -n tkg-system
# 生成文件：
telegraf-data-values.yaml
# 编辑文件，取消注释两行，并将第二行设置为“true”：
domainName: cluster.local
isMetricProxyConfigured: true
#安装 
vcf package install telegraf -p telegraf.kubernetes.vmware.com --version 1.35.4+vmware.1-vks.1 --values-file telegraf-data-values.yaml  -n package-installs


# 安装 Prometheus 之前，需要先安装 cert-manager 和 contour
vcf package install cert-manager -p cert-manager.kubernetes.vmware.com -n package-installs
# 安装 Contour  
vcf package install contour -p contour.kubernetes.vmware.com -n package-installs
# 验证安装
kubectl get all -n cert-manager
# 验证安装
kubectl get all -n tanzu-system-ingress

# 创建命名空间
kubectl create ns tanzu-system-monitoring
# 新安装 Prometheus 包
vcf package install prometheus -p prometheus.kubernetes.vmware.com -v 3.5.0+vmware.3-vks.1 --values-file prometheus-3.5.0+vmware.3-vks.1-values.yaml -n tanzu-system-monitoring
# 查看 Prometheus 包安装状态
vcf package installed list -n tanzu-system-monitoring
# 查看 Prometheus 包详细信息
vcf package installed get prometheus -n tanzu-system-monitoring

# 设置VCF Operations Manager集成Prometheus监控
#name:
k8s01-lci-cluster1
#Description
k8s01-lci-cluster1 VCF VKS Cluster Monitoring
#Control Plane Endpoint
https://10.68.230.110:6443
#collector Service Endpoint
cAdvisor - Kubelet

# 创建 SA + 权限
# 在 K8s 执行
kubectl create serviceaccount aria-ops-sa -n kube-system
# 绑定 cluster-admin
kubectl create clusterrolebinding aria-ops-sa-binding \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:aria-ops-sa
``
#  获取 Token
kubectl -n kube-system create token aria-ops-sa
k8s01@bootstrap:~/scripts/tanzu-standard-scripts/bin$ kubectl -n kube-system create token aria-ops-sa
eyJhbGciOiJSUzI1NiIsImtpZCI6InZURERITURIUG9vbERHc2JtdlBGY0R4aUlWV01uZ3hSanExcHdWeHZFc1kifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzgyMjc4Nzg2LCJpYXQiOjE3ODIyNzUxODYsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiYTJmZGM5NTItNjUwMi00NTljLWFjZTItMDIyZTEwYjA3ZDA0Iiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJhcmlhLW9wcy1zYSIsInVpZCI6IjA1YjE4YmVkLThlNWYtNGY5NS05MmJjLWNhNGE3ZGE0NjVmNCJ9fSwibmJmIjoxNzgyMjc1MTg2LCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06YXJpYS1vcHMtc2EifQ.im5ozxyyD7FOePTxyoW_fxXYInbrER2q_clptRtF5uRmru4gG-4vhjH_eeenMqYPnw1dMxXJe6-QFH2Hvxs0GMXHxSjHMG4-TYv2e2dmexiEI7Ub8N7Yiaws8pKT_yFh4DEWvtBy5NMctVqju1ip7ztxlPy3fIcHNr7rIiFKy8XIrNUKFDA15ssTHKjucLVY2zY0diTMnjoTZMVU7wl_-xnDZJGV5ynRrAtS9ikvUnrsdUcx_xEHrSCeLDd2dskH1Q1mq3AS4lxNHpXBRy5py1ECjyOjrorYYaqqZKLslXHGRDkHesx1AGD2J5m8CMrpAkqzLjZwCkdp0ld1N4QRrA

#和VCF Operations Manager集成完成。