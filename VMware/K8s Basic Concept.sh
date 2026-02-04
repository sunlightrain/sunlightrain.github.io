K8s Basic Concept

CSI
CNI
    Antrea 
    calico 强大，基于IP 端口和协议，控制pod出口流量
OCI


各种版本的区别？


vSphere with Tanzu + NSX 
vSphere with Tanzu + Antrea
vSphere with Tanzu + Calico

##vSphere with Tanzu Deploy mode
1. vSphere Distributed Switch (VDS) 模式
    HAProxy 模式
    Avi 模式
2. NSX-T 模式
    NSX-T +Avi 模式
Deployment 




##Tanzu 版本 Edition
1. vSphere with Tanzu
2. TKGs
3. TKGm
4. TKGi

VKS相当于哪个版本？


1. Supervisor Cluster + Namespace + Workload Cluster
2. Supervisor Cluster + Workload Cluster
3. Workload Cluster Only


## Installing the Tanzu CLI in Internet-Connected Environments
YUM or DNF (RHEL):
cat << EOF | sudo tee /etc/yum.repos.d/tanzu-cli.repo
[tanzu-cli]
name=Tanzu CLI
baseurl=https://storage.googleapis.com/tanzu-cli-installer-packages/rpm/tanzu-cli
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://storage.googleapis.com/tanzu-cli-installer-packages/keys/TANZU-PACKAGING-GPG-RSA-KEY.gpg
EOF

sudo yum install -y tanzu-cli # If you are using DNF, run sudo dnf install -y

To uninstall the CLI:
sudo yum remove tanzu-cli

Check that the correct version of the CLI is properly installed.
tanzu version
version: v1.5.1
...
## Install from a binary release
Download the Tanzu CLI binary from Broadcom Support or GitHub:

From Broadcom Support:
Go to the Tanzu CLI download page on Broadcom Support.
Expand Product Downloads, locate the CLI version that you want to install, and download the Tanzu CLI binary for your operating system (OS).

From GitHub:
Go to the Tanzu CLI releases page on GitHub.
Locate your desired release version.
From the Assets section of your chosen release, click to download the .tar.gz or .zip file of the Tanzu CLI binary for your OS, for example, tanzu-cli-windows-amd64.zip.

Unpack the Tanzu CLI file for your OS:
tar -xvf tanzu-cli-linux-amd64.tar.gz

Navigate to the directory containing the extracted CLI binary and then follow the steps below to install the CLI:
Linux:

Install the binary to /usr/local/bin:

sudo install tanzu-cli-linux_amd64 /usr/local/bin/tanzu

Check that the correct version of the CLI is properly installed.
tanzu version
version: v1.5.1
...



