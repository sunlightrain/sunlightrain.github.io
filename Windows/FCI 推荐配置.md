项目            VMware 推荐方案
共享磁盘类型     Clustered VMDK（共享 VMDK）
磁盘格式               Eager Zeroed Thick（EZT）
SCSI 控制器            Paravirtual SCSI + Bus Sharing = Physical
Boot Disk             独立 SCSI 控制器 + Bus Sharing = None
Datastore           VMFS6（启用 Clustered VMDK），或 vSAN（支持 SCSI3‑PR）
No multi-writer         禁止使用
架构                    推荐 CAB，禁止生产使用 CIB
共享磁盘 SCSI ID        所有节点保持一致