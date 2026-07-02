k8s01@bootstrap:~/scripts/tanzu-standard-scripts$ cat VALIDATION-REPORT.md
# Tanzu Standard Package Scripts 검증 보고서

검증 범위:
- `imgpkg tag list`, `imgpkg copy --to-tar`, `imgpkg copy --tar --to-repo`
- `tanzu package repository add/update/list`
- `tanzu package available list/get`
- `tanzu package install`
- `tanzu package installed update/delete/list`
- `tanzu package available get --default-values-file-output`

## 결론

명령 축 자체는 요구사항과 대체로 일치했습니다.
다만 아래 1건은 실제 동작상 수정이 필요했습니다.

### 수정이 필요했던 항목
- `imgpkg copy -b ... --to-tar ...` 단계에 `--cosign-signatures` 가 없으면,
  import 시 `--cosign-signatures` 를 주더라도 tar 내부에 signature 가 없어서 signature relocation 이 보장되지 않습니다.
  따라서 export / import 양쪽 모두에 `--cosign-signatures` 를 넣도록 수정했습니다.

### 유지한 항목
- repo tag 조회 후 선택
- 선택 tag 기준 tar export
- tar 경로 + Harbor 경로 입력 후 업로드
- namespace 선택 후 Tanzu Standard package repository add / update
- package install / update / delete / list
- default values file 추출
- install/update 시 values 파일 사용 여부 질문

### 보강한 항목
- CLI 표 출력 파싱 실패 시 수동 입력 fallback 추가
- `kubectl version --client=true` 사용으로 구버전/신버전 호환성 완화

## 대표적인 공식 검증 포인트
- Carvel imgpkg air-gapped workflow 는 `imgpkg copy -b ... --to-tar ...` 후 `imgpkg copy --tar ... --to-repo ...` 흐름을 공식적으로 설명합니다.
- Carvel imgpkg 는 cosign signature copy 를 `--cosign-signatures` 플래그로 처리하며, tarball copy 에도 적용된다고 설명합니다.
- Broadcom KB 는 `tanzu package repository update ... --url ... --namespace ...` 와 `tanzu package installed update ... --version ... -n ...` 예시를 제공합니다.
- Broadcom / VMware 문서 예시들은 `tanzu package install ... --package-name ... --version ... --namespace ... --values-file ...` 형태와 `tanzu package available get <name>/<version> --default-values-file-output ...` 형태를 반복적으로 사용합니다.

## 스크리닝한 공개 블로그/아티클/가이드 (50+)

1. Install Tanzu Packages on Tanzu Kubernetes Clusters on VMware Cloud Director
   https://blogs.vmware.com/cloudprovider/2022/03/tanzu-packages-on-tanzu-kubernetes-clusters.html
2. Some useful tips when deploying TKG in an air-gap environment
   https://cormachogan.com/2021/11/15/some-useful-tips-when-deploying-tkg-in-an-air-gap-environment/
3. Deploy VMware Tanzu Packages from a private Container Registry
   https://rguske.github.io/post/deploy-tanzu-packages-from-a-private-registry/
4. Installing Packages to a TKG cluster in vSphere 8 with Tanzu
   https://little-stuff.com/2023/05/18/installing-packages-to-a-tkgs-cluster-in-vsphere-8-with-tanzu/
5. Upgrading from TKG 1.3 to 1.4 (including extensions) on vSphere
   https://little-stuff.com/2021/09/13/upgrading-from-tkg-1-3-to-1-4-including-extensions-on-vsphere/
6. Tanzu Contour, Prometheus and Grafana Install Guide
   https://vmtechie.blog/2023/02/15/cloud-director-container-service-extension-tanzu-contour-prometheus-and-grafana-install-guide/
7. Deploy Harbor Registry on TKG Clusters
   https://vmtechie.blog/2021/08/16/deploy-harbor-registry-on-tkg-clusters/
8. Getting Started VMware Tanzu Community Edition (Part 2)
   https://achchusnulchikam.medium.com/getting-started-vmware-tanzu-community-edition-part-2-9ef2cf65d121
9. Getting Started with VMware Tanzu Community Edition
   https://blogs.vmware.com/tanzu/getting-started-vmware-tanzu-community-edition-guide/
10. Tanzu Packages Explained
    https://beyondelastic.com/2022/01/04/tanzu-packages-explained/
11. Quick guide to install cert-manager, contour, prometheus and grafana into TKG using Tanzu Packages kapp
    https://vmwire.com/2022/03/04/quick-guide-to-install-cert-manager-contour-prometheus-and-grafana-into-tkg-using-tanzu-packages-kapp/
12. Deploy Prometheus and Grafana on a Tanzu Community Edition cluster
    https://rudimartinsen.com/2022/01/03/deploy-grafana-prometeheus-tce/
13. Installing Contour on a Tanzu Community Edition cluster
    https://rudimartinsen.com/2022/01/02/installing-contour-on-tce/
14. Configuring Fluent Bit to push logs from Tanzu Community Edition clusters to vRealize Log Insight
    https://rudimartinsen.com/2022/01/09/tce-fluent-bit/
15. Deploy ExternalDNS on TCE and integrate with a Microsoft DNS
    https://rudimartinsen.com/2022/01/26/tce-external-dns/
16. Deploy Velero for backup and restore in a Tanzu Community Edition cluster
    https://rudimartinsen.com/2022/01/27/tce-velero/
17. Deploying Harbor registry with Tanzu Packages
    https://rudimartinsen.com/2022/01/11/tce-harbor/
18. Tanzu Community Edition packages
    https://geoffrey-rekier.medium.com/tanzu-community-edition-packages-5c7e20db4fb0
19. WSL 에서 TCE Extension 설치 하기
    https://huntedhappy.tistory.com/entry/wsl-%EC%97%90%EC%84%9C-TCE-Extension-%EC%84%A4%EC%B9%98-%ED%95%98%EA%B8%B0-1
20. TKG 1.6 Airgap 환경 구성 시 image upload 문제
    https://techfactory.tistory.com/21
21. Tanzu Platform Self-Managed 설치
    https://techfactory.tistory.com/33
22. Deploying Supervisor Services in Air Gapped Environments
    https://spirit21.com/en/newsroom/blog/supervisor-services-in-air-gapped-umgebungen-deployen
23. Mastering the Void: Installing vSphere with Tanzu in an Air-Gapped Environment
    https://navneet-verma.medium.com/mastering-the-void-installing-vsphere-with-tanzu-in-an-air-gapped-environment-d29e38f4723d
24. Creating and Deploying Carvel Packages on VMware Kubernetes Service (VKS)
    https://navneet-verma.medium.com/creating-and-deploying-carvel-packages-on-vmware-kubernetes-service-vks-a-complete-guide-3c3247a5e0f6
25. VMware VKS Cluster Logging using Fluent Bit
    https://medium.com/@bob-bauer/vmware-vks-cluster-logging-using-fluent-bit-e6a59dd4b97c
26. Understanding Supervisor and vSphere Kubernetes Service upgrades
    https://medium.com/@bob-bauer/understanding-supervisor-and-vsphere-kubernetes-service-vks-upgrades-53dbccf53756
27. VCF CLI Offline Plugin Installation for vSphere Kubernetes Service
    https://medium.com/@bob-bauer/vcf-cli-offline-plugin-installation-for-vks-659b273fb007
28. Install VCD Data Solutions Extension in an Airgap Environment
    https://vstellar.com/2024/04/install-vcd-data-solutions-extension-in-an-airgap-environment/
29. Elevate your Cloud-Native Journey: Knative the VMware Tanzu way Part 1
    https://rguske.github.io/post/elevate-your-cloud-native-journey-knative-the-vmware-tanzu-way-part-1-streamlined-installation-of-knative/
30. Getting started with Tanzu Build Service (Part 1)
    https://www.viktorious.nl/2025/04/14/getting-started-with-tanzu-build-service-part-1/
31. Install Tanzu Application Platform 1.3 on AKS with Multi Cluster support
    https://ik.am/entries/723/en
32. Deploying Tanzu packages using the Tanzu CLI
    https://docs.aucyber.com.au/latest/Platform_Services/Kubernetes/tanzu_packages/tanzu_cli_install/
33. Customizing tanzu packages
    https://docs.aucyber.com.au/latest/Platform_Services/Kubernetes/tanzu_packages/customizing_tanzu_packages/
34. Announcing the General Availability of VMware Tanzu Kubernetes Grid 1.4
    https://blogs.vmware.com/tanzu/general-availability-vmware-tanzu-kubernetes-grid-1-4/
35. Deploy to Any Kubernetes Cluster Type with New Tanzu Mission Control Catalog
    https://blogs.vmware.com/tanzu/tanzu-mission-control-catalog-feature/
36. VMware Tanzu Advanced Quarterly Update
    https://blogs.vmware.com/tanzu/vmware-tanzu-advanced-quarterly-update-driving-devops-metrics-that-matter/
37. Cloud Native Runtimes for Tanzu
    https://vmtechie.blog/2021/06/15/cloud-native-runtimes-for-tanzu/
38. Installing Tanzu Kubernetes Grid
    https://vmtechie.blog/2020/05/04/installing-tanzu-kubernetes-grid/
39. Tanzu Service on VMware Cloud on AWS – Installing Tanzu Application Platform
    https://vmtechie.blog/2022/03/25/tanzu-service-on-vmware-cloud-on-aws-installing-tanzu-application-platform/
40. Running Plex on a Tanzu Community Edition Kubernetes cluster
    https://rudimartinsen.com/2022/01/28/tce-plex/
41. Forwarding Tanzu Kubernetes Grid logs to vRealize Log Insight Cloud using the Fluent Bit package
    https://www.definit.co.uk/2021/12/forwarding-tanzu-kubernetes-grid-logs-to-vrealize-log-insight-cloud-using-the-fluent-bit-package/
42. Forwarding TKG logs to vRealize Log Insight Cloud using Fluent Bit
    https://www.outofmemory.info/tanzu/tanzu-packages/fluent-bit/tkgm-vrlic-fluent-bit-integration/
43. A Beginner's Guide to Tanzu Kubernetes
    https://medium.com/@bonny.ophelie/a-beginners-guide-to-tanzu-kubernetes-getting-started-with-vmware-s-k8s-solution-da7566bcec73
44. Installing & Configuring Tanzu Application Platform (TAP) v0.2
    https://vmwaretanzu.medium.com/installing-configuring-tanzu-application-platform-tap-v0-2-967ba40fa222
45. TCE ตอนที่ 1— เปิดตัว Tanzu Community Edition มาลองเล่นกัน
    https://medium.com/vmware-tech-community-thailand/tce-%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%97%E0%B8%B5%E0%B9%88-1-%E0%B9%80%E0%B8%9B%E0%B8%B4%E0%B8%94%E0%B8%95%E0%B8%B1%E0%B8%A7-tanzu-community-edition-%E0%B8%A1%E0%B8%B2%E0%B8%A5%E0%B8%AD%E0%B8%87%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%99%E0%B8%81%E0%B8%B1%E0%B8%99-f518f03b0fbb
46. Deploying Tanzu TCE Workload Cluster using Docker
    https://medium.com/@lubomir-tobek/deploying-tanzu-tce-workload-cluster-using-docker-35670d0484fb
47. How to deploy a TKG cluster on AWS using Tanzu Mission Control
    https://little-stuff.com/2020/08/18/how-to-deploy-a-tkg-cluster-on-aws-using-tanzu-mission-control/
48. Creating a Tanzu Kubernetes cluster in vSphere 8 with Tanzu
    https://little-stuff.com/2023/05/06/creating-a-tanzu-kubernetes-cluster-in-vsphere-8-with-tanzu/
49. Managing a vSphere 8 with Tanzu Workload Cluster in Tanzu Mission Control
    https://little-stuff.com/2023/07/29/managing-a-vsphere-8-with-tanzu-workload-cluster-in-tanzu-mission-control/
50. Deploying VMware Tanzu Kubernetes Grid with Pure Storage vVols (Part I)
    https://www.codyhosterman.com/2020/07/deploying-vmware-tanzu-kubernetes-grid-with-pure-storage-vvols-part-i-deploy-tkg-on-vsphere/
51. imgpkg image collocation and tagging
    https://carvel.dev/blog/imgpkg-image-collocation-and-tagging/
52. Signing imgpkg Bundles with cosign
    https://carvel.dev/blog/signing-imgpkg-bundles-with-cosign/
53. Carvel In August 2022
    https://carvel.dev/blog/carvel-in-august-2022/
54. Using CUE and Carvel Together for Your Kubernetes Setup
    https://carvel.dev/blog/cue-and-carvel/
55. Package Repository Updates
    https://blogs.vmware.com/tanzu/package-repository-updates/
k8s01@bootstrap:~/scripts/tanzu-standard-scripts$