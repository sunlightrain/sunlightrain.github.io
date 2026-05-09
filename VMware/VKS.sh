#1. Install Tanzu CLI.
tar -xvf tanzu-cli-linux-amd64.tar
cd ./v0.90.1/
install tanzu-cli-linux_amd64 /usr/local/bin/tanzu
chmod +x /usr/local/bin/tanzu
## Verify Tanzu CLI installation.
[root@bootstrap ~]# tanzu version
version: v1.5.3
buildDate: 2025-01-29
sha: f73b9ec
arch: amd64
[root@bootstrap ~]#

#2. Install the Tanzu CLI plug-ins.
##tanzu plugin group search
[root@bootstrap ~]# tanzu plugin group search
  GROUP                           DESCRIPTION                                           LATEST
  vmware-tanzu/app-developer      Plugins for Application Developer for Tanzu Platform  v1.1.0
  vmware-tanzu/platform-engineer  Plugins for Platform Engineer for Tanzu Platform      v1.1.0
  vmware-tanzucli/essentials      Essential plugins for the Tanzu CLI                   v1.0.1
  vmware-tap/default              Plugins for TAP                                       v1.12.5
  vmware-tkg/default              Plugins for TKG                                       v2.5.4
  vmware-tmc/default              Plugins for TMC                                       v1.0.0
  vmware-vsphere/default          Plugins for vSphere                                   v8.0.3

Note: To view all plugin group versions available, use 'tanzu plugin group search --show-details'.
[root@bootstrap ~]#

##tanzu plugin install --group vmware-tkg/default
[root@bootstrap ~]# tanzu plugin install --group vmware-tkg/default
[i] The following plugins will be installed from plugin group 'vmware-tkg/default:v2.5.4'
  NAME                TARGET      VERSION
  isolated-cluster    global      v0.32.5
  management-cluster  kubernetes  v0.32.5
  package             kubernetes  v0.32.1
  pinniped-auth       global      v0.32.5
  secret              kubernetes  v0.32.0
  telemetry           kubernetes  v0.32.5
[i] Installed plugin 'isolated-cluster:v0.32.5' with target 'global'
[i] Installed plugin 'management-cluster:v0.32.5' with target 'kubernetes'
[i] Installed plugin 'package:v0.32.1' with target 'kubernetes'
[i] Installed plugin 'pinniped-auth:v0.32.5' with target 'global'
[i] Installed plugin 'secret:v0.32.0' with target 'kubernetes'
[i] Installed plugin 'telemetry:v0.32.5' with target 'kubernetes'
[ok] successfully installed all plugins from group 'vmware-tkg/default:v2.5.4'
[root@bootstrap ~]#

#3. Download the Images.
tanzu isolated-cluster download-bundle --source-repo projects.registry.vmware.com/tkg --tkg-version v2.3.0

[root@bootstrap ~]# tanzu isolated-cluster download-bundle --source-repo projects.registry.vmware.com/tkg --tkg-version v2.3.0
Processing TKG Compatibility image and creating list of images/bundle that need to be downloaded .....

Processing TKG Bom and Component images and creating list of images/bundle that need to be downloaded .....

Pulling image 'projects.registry.vmware.com/tkg/tkg-bom@sha256:b6a547a44889406e4aa3576157733bd21b4d5e97c78881f2712404a59d6e3d13'
Extracting layer 'sha256:37433d3a23d6397c8f92191751000473dcb2290c9491c5da69cad8cc931a0a75' (1/1)
Processing TKR Compatibility images and creating list of images/bundle that need to be downloaded .....
...
...
Finish downloading image 178/179
done: file 'sha256-9b0a8cdd9a927c87df1b808932ec90e9740750176ae09728be88817e0ee07ee1.tar.gz' (416.833113ms)
done: file 'sha256-72474424c12d14cbbf5851384ff98947a5d8756510c166c6d747ec90e99a88d8.tar.gz' (186.819µs)
done: file 'sha256-a9e841f299a49fc97b1f19eda5b2de5b69806eb114893a2f223c354942eb414f.tar.gz' (83.225µs)
done: file 'sha256-f85b32f75e20eb759cc3d31af0a8b0374e4b25c4ee9ddff1347b85a8509cf41d.tar.gz' (37.518µs)
done: file 'sha256-1b5535db6881de2f46a96bb8af23ce97f4f2ea2a73da5264315ebedd616f6c0d.tar.gz' (196.427µs)
done: file 'sha256-0f1f3de3bfacda0a4ebff9bd6ebb0747f5e9a11b955f771c7348a4014bcff5fa.tar.gz' (9.368554104s)
Finish downloading image 179/179
[root@bootstrap ~]#

#4. Download the Tanzu CLI plug-ins.
tanzu plugin download-bundle --group vmware-tkg/default:v2.3.0 --to-tar plugin_bundle_tkg_latest.tar.gz

[root@bootstrap ~]#
[root@bootstrap ~]# tanzu plugin download-bundle --group vmware-tkg/default:v2.3.0 --to-tar plugin_bundle_tkg_latest.tar.gz
[i] Getting selected plugin information...
[i] will be downloading the 9 plugins from group: vmware-tkg/default:v2.3.0
[i] will be downloading the one plugin from group: vmware-tanzucli/essentials:v1.0.1
[i] downloading image "projects.packages.broadcom.com/tanzu_cli/plugins/plugin-inventory:latest"
[i] copy | exporting 2 images...
...
...
[i] ---------------------------
[i] downloading image "projects.packages.broadcom.com/tanzu_cli/plugins/vmware/tap_saas/windows/amd64/global/telemetry:v1.1.1"
[i] copy | exporting 1 images...
[i] copy | will export projects.packages.broadcom.com/tanzu_cli/plugins/vmware/tap_saas/windows/amd64/global/telemetry@sha256:4f23bf9a618b4883877f51f50592e65486294168cda2304626376f608986a920
[i] copy | exported 1 images
[i] copy | writing layers...
[i] copy | done: file 'manifest.json' (3.226µs)
[i] copy | done: file 'sha256-f4d7fd18fa5b91de924f005120a776498e49078064d2c358e16fe1d296aae4c4.tar.gz' (21.15386462s)
[i] saving plugin bundle at: plugin_bundle_tkg_latest.tar.gz
[root@bootstrap ~]#



---
tanzu isolated-cluster upload-bundle --source-directory /data/tkgm/ --destination-repo 10.68.37.208/tkgm-images

tanzu isolated-cluster upload-bundle --source-directory /root/Downloads/tkgm-images/ --destination-repo 10.68.37.208/tkgm-images

tanzu plugin upload-bundle --tar ./plugin_bundle_tkg_latest.tar.gz --to-repo 10.68.37.208/tkgm-images/

tanzu plugin source update default --uri 10.68.37.208/tkgm-images/plugin-inventory:latest
---

