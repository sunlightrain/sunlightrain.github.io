HYMMSDB ASM Add Shared Disk
dlhymmsdb01
DLISNMIS-PMAX01-DSCL01-VMFS10
DLISNMIS-PMAX01-Clustered-DSCL01-VMFS02

dlhymmsdb02
DLISNMIS-PMAX01-DSCL01-VMFS07
DLISNMIS-PMAX01-Clustered-DSCL01-VMFS02

DLISNMIS-PMAX01-DSCL01-VMFS12 128G*8
SCSI controller 1 [1:9] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01.vmdk
SCSI controller 1 [1:10] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_19.vmdk
SCSI controller 1 [1:11] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_20.vmdk
SCSI controller 1 [1:12] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_21.vmdk
SCSI controller 1 [1:13] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_22.vmdk
SCSI controller 1 [1:14] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_23.vmdk
SCSI controller 1 [1:15] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_24.vmdk
SCSI controller 1 [1:16] [DLISNMIS-PMAX01-DSCL01-VMFS12] dlhymmsdb01/dlhymmsdb01_25.vmdk

1.验证新磁盘可见 lsblk
2.Node1进行分区
for disk in sdv sdw sdx sdy sdz sdaa sdab sdac;
do
parted /dev/$disk mklabel gpt
parted /dev/$disk mkpart primary "1 -1"
done
3.Node2 重读分区表
sudo partprobe /dev/sdv
sudo partprobe /dev/sdw
sudo partprobe /dev/sdx
sudo partprobe /dev/sdy
sudo partprobe /dev/sdz
sudo partprobe /dev/sdaa
sudo partprobe /dev/sdab
sudo partprobe /dev/sdac

4.重复上述步骤，直至所有磁盘分区完成。

# 查看SCSI ID
/usr/lib/udev/scsi_id -g -u -d /dev/sdv
/usr/lib/udev/scsi_id -g -u -d /dev/sdw
/usr/lib/udev/scsi_id -g -u -d /dev/sdx
/usr/lib/udev/scsi_id -g -u -d /dev/sdy
/usr/lib/udev/scsi_id -g -u -d /dev/sdz
/usr/lib/udev/scsi_id -g -u -d /dev/sdaa
/usr/lib/udev/scsi_id -g -u -d /dev/sdab
/usr/lib/udev/scsi_id -g -u -d /dev/sdac

#结果如下：

36000c297ad825f7f217cb9b203aed086
36000c2976388afa3a0c4bc645da4c6fc
36000c29f617115d6f610f92868cd82dc
36000c29f2e304cdf8f4e19d30acff4db
36000c29a83484cf276a2b180b5f4488e
36000c29ec02e4400310234589502a0bf
36000c2982d3ec0f60000e0f6d4e87d68
36000c29b7d543db15316e9b95714750c



vim /etc/udev/rules.d/90-oracleasm.rules
[root@dlhymmsdb01 ~]# cat /etc/udev/rules.d/90-oracleasm.rules
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29a91b3c6033bc42067e02ad049", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asms01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29fb9a1ffec1bfc8106ff4b491e", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asms02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29f27ef533adb401c9993d5f207", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asms03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29d91c6cb9bfa5a189d9515819c", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmr01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2936c4cd866cbee000362cdf1c4", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmr02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29336d3b83398b2ca9ab5ac0241", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmr03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c293abc13f57e814dfede0a519b7", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmr04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29e9bcc3a6c08b80ca171abbf5b", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmm01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29feafbf11aa6ff96fd5ac287b0", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmm02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2966c3c471bbb53af5787a2bc64", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmm03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c297f3a583ba2208d65dfbdebb15", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmm04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c295fd78e6dfe7fd4524767f528d", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2973a23ba9ffda1108c5b4b8c28", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29e1b25e473bd6aa542498722a3", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd03", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29ac47222a0352276605b5fc370", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2940620cbf56d347e38ea38d727", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd05", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2937f647cf1949c923276020f45", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd06", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29be7b74fec4e3f5417382adf64", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd07", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29b02b616275a6ca5443019793f", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd08", OWNER="oragrid", GROUP="dba", MODE="0660"
[root@dlhymmsdb01 ~]#

#New Configuration
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c297ad825f7f217cb9b203aed086", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd09", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2976388afa3a0c4bc645da4c6fc", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd10", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29f617115d6f610f92868cd82dc", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd11", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29f2e304cdf8f4e19d30acff4db", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd12", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29a83484cf276a2b180b5f4488e", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd13", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29ec02e4400310234589502a0bf", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd14", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2982d3ec0f60000e0f6d4e87d68", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd15", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29b7d543db15316e9b95714750c", SYMLINK+="dlhymmsdb_asm/dlhymmsdb_asmd16", OWNER="oragrid", GROUP="dba", MODE="0660"

udevadm control --reload-rules
udevadm trigger



dlhymmsdb_asm/dlhymmsdb_asmd09
dlhymmsdb_asm/dlhymmsdb_asmd10
dlhymmsdb_asm/dlhymmsdb_asmd11
dlhymmsdb_asm/dlhymmsdb_asmd12
dlhymmsdb_asm/dlhymmsdb_asmd13
dlhymmsdb_asm/dlhymmsdb_asmd14
dlhymmsdb_asm/dlhymmsdb_asmd15
dlhymmsdb_asm/dlhymmsdb_asmd16

# 验证
ll /dev/dlhymmsdb_asm/dlhymmsdb_asm*
