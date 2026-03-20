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


------


vim /etc/udev/rules.d/90-oracleasm.rules



##重载udev
udevadm control --reload-rules
udevadm trigger--type=devices

[root@dlhymmsdb01 ~]# ls /dev/dlhymmsdb_asm/*
/dev/dlhymmsdb_asm/dlhymmsdb_asmd01  /dev/dlhymmsdb_asm/dlhymmsdb_asmd05  /dev/dlhymmsdb_asm/dlhymmsdb_asmm01  /dev/dlhymmsdb_asm/dlhymmsdb_asmr01  /dev/dlhymmsdb_asm/dlhymmsdb_asms01
/dev/dlhymmsdb_asm/dlhymmsdb_asmd02  /dev/dlhymmsdb_asm/dlhymmsdb_asmd06  /dev/dlhymmsdb_asm/dlhymmsdb_asmm02  /dev/dlhymmsdb_asm/dlhymmsdb_asmr02  /dev/dlhymmsdb_asm/dlhymmsdb_asms02
/dev/dlhymmsdb_asm/dlhymmsdb_asmd03  /dev/dlhymmsdb_asm/dlhymmsdb_asmd07  /dev/dlhymmsdb_asm/dlhymmsdb_asmm03  /dev/dlhymmsdb_asm/dlhymmsdb_asmr03  /dev/dlhymmsdb_asm/dlhymmsdb_asms03
/dev/dlhymmsdb_asm/dlhymmsdb_asmd04  /dev/dlhymmsdb_asm/dlhymmsdb_asmd08  /dev/dlhymmsdb_asm/dlhymmsdb_asmm04  /dev/dlhymmsdb_asm/dlhymmsdb_asmr04


---老配置---
  1 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29a91b3c6033bc42067e02ad049", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asms01", OWNER="oragrid", GROUP="dba", MODE="0660"
  2 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29fb9a1ffec1bfc8106ff4b491e", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asms02", OWNER="oragrid", GROUP="dba", MODE="0660"
  3 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29f27ef533adb401c9993d5f207", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asms03", OWNER="oragrid", GROUP="dba", MODE="0660"
  4 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29d91c6cb9bfa5a189d9515819c", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmr01", OWNER="oragrid", GROUP="dba", MODE="0660"
  5 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2936c4cd866cbee000362cdf1c4", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmr02", OWNER="oragrid", GROUP="dba", MODE="0660"
  6 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29336d3b83398b2ca9ab5ac0241", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmr03", OWNER="oragrid", GROUP="dba", MODE="0660"
  7 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c293abc13f57e814dfede0a519b7", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmr04", OWNER="oragrid", GROUP="dba", MODE="0660"
  8 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29e9bcc3a6c08b80ca171abbf5b", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmm01", OWNER="oragrid", GROUP="dba", MODE="0660"
  9 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29feafbf11aa6ff96fd5ac287b0", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmm02", OWNER="oragrid", GROUP="dba", MODE="0660"
 10 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2966c3c471bbb53af5787a2bc64", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmm03", OWNER="oragrid", GROUP="dba", MODE="0660"
 11 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c297f3a583ba2208d65dfbdebb15", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmm04", OWNER="oragrid", GROUP="dba", MODE="0660"
 12 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c295fd78e6dfe7fd4524767f528d", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd01", OWNER="oragrid", GROUP="dba", MODE="0660"
 13 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2973a23ba9ffda1108c5b4b8c28", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd02", OWNER="oragrid", GROUP="dba", MODE="0660"
 14 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29e1b25e473bd6aa542498722a3", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd03", OWNER="oragrid", GROUP="dba", MODE="0660"
 15 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29ac47222a0352276605b5fc370", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd04", OWNER="oragrid", GROUP="dba", MODE="0660"
 16 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2940620cbf56d347e38ea38d727", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd05", OWNER="oragrid", GROUP="dba", MODE="0660"
 17 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2937f647cf1949c923276020f45", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd06", OWNER="oragrid", GROUP="dba", MODE="0660"
 18 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29be7b74fec4e3f5417382adf64", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd07", OWNER="oragrid", GROUP="dba", MODE="0660"
 19 KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29b02b616275a6ca5443019793f", SYMLINK+="dlffdcoradb_asm/dlffdcoradb_asmd08", OWNER="oragrid", GROUP="dba", MODE="0660"
--- END ---


---
# test asm 扩容
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29bb5c237d457406847ca62704a", SYMLINK+="dlmax_asm/dlmax_asms01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29efa0801d11d0457d243617791", SYMLINK+="dlmax_asm/dlmax_asms02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29b47ed72ec16aab501079b4127", SYMLINK+="dlmax_asm/dlmax_asms03", OWNER="oragrid", GROUP="dba", MODE="0660"

KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2980dbf25f81c92612419634778", SYMLINK+="dlmax_asm/dlmax_asmr01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29fe2d54b2e6a5b3f07afd19a56", SYMLINK+="dlmax_asm/dlmax_asmr02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c292a365aaa33ee5dcdd2c7a4a1b", SYMLINK+="dlmax_asm/dlmax_asmr03", OWNER="oragrid", GROUP="dba", MODE="0660"

KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c293121ce8bb64c6b77b99db695b", SYMLINK+="dlmax_asm/dlmax_asmd01", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29d7028afa4a09b29ac11bf1157", SYMLINK+="dlmax_asm/dlmax_asmd02", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c29d9a27bc7f385100d97f3bde58", SYMLINK+="dlmax_asm/dlmax_asmd03", OWNER="oragrid", GROUP="dba", MODE="0660"
---
# New configuration for dlmax_asm
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c299a00c3b8fd5bc40840889a7ea", SYMLINK+="dlmax_asm/dlmax_asmd04", OWNER="oragrid", GROUP="dba", MODE="0660"
KERNEL=="sd*", SUBSYSTEM=="block", PROGRAM=="/usr/lib/udev/scsi_id -g -u -d /dev/$parent", RESULT=="36000c2995e3725904ad2d0468199c652", SYMLINK+="dlmax_asm/dlmax_asmd05", OWNER="oragrid", GROUP="dba", MODE="0660"

36000c2995e3725904ad2d0468199c652

parted /dev/sdl mklabel gpt
parted /dev/sdl mkpart primary "1 -1"

ll /dev/dlmax_asm/*

vim /etc/udev/rules.d/90-oracleasm.rules



udevadm control --reload-rules
udevadm trigger

echo 1 > /sys/class/block/sdm/device/rescan


asmca -silent \
-addDisk \
-diskGroupName DATA \
-diskList '/dev/dlmax_asm/dlmax_asmd04'


[oragrid@dltestoradb01:/oragrid] asmcmd lsdg
State    Type    Rebal  Sector  Logical_Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512             512   4096  4194304    196596    46752                0           46752              0             N  DATA/
MOUNTED  EXTERN  N         512             512   4096  4194304     98292    77444                0           77444              0             N  REDO/
MOUNTED  NORMAL  N         512             512   4096  4194304     30708    29664            10236            9714              0             Y  SYSTEM/
[oragrid@dltestoradb01:/oragrid]
[oragrid@dltestoradb01:/oragrid]
[oragrid@dltestoradb01:/oragrid] asmcmd lsdsk
Path
/dev/dlmax_asm/dlmax_asmd01
/dev/dlmax_asm/dlmax_asmd02
/dev/dlmax_asm/dlmax_asmd03
/dev/dlmax_asm/dlmax_asmr01
/dev/dlmax_asm/dlmax_asmr02
/dev/dlmax_asm/dlmax_asmr03
/dev/dlmax_asm/dlmax_asms01
/dev/dlmax_asm/dlmax_asms02
/dev/dlmax_asm/dlmax_asms03
[oragrid@dltestoradb01:/oragrid] asmca -silent \
> -addDisk \
> -diskGroupName DATA \
> -diskList '/dev/dlmax_asm/dlmax_asmd04'



[oragrid@dltestoradb01:/oragrid] asmcmd lsdsk
Path
/dev/dlmax_asm/dlmax_asmd01
/dev/dlmax_asm/dlmax_asmd02
/dev/dlmax_asm/dlmax_asmd03
/dev/dlmax_asm/dlmax_asmd04
/dev/dlmax_asm/dlmax_asmr01
/dev/dlmax_asm/dlmax_asmr02
/dev/dlmax_asm/dlmax_asmr03
/dev/dlmax_asm/dlmax_asms01
/dev/dlmax_asm/dlmax_asms02
/dev/dlmax_asm/dlmax_asms03
[oragrid@dltestoradb01:/oragrid] asmcmd lsdg
State    Type    Rebal  Sector  Logical_Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512             512   4096  4194304    262128   112272                0          112272              0             N  DATA/
MOUNTED  EXTERN  N         512             512   4096  4194304     98292    77444                0           77444              0             N  REDO/
MOUNTED  NORMAL  N         512             512   4096  4194304     30708    29664            10236            9714              0             Y  SYSTEM/
[oragrid@dltestoradb01:/oragrid]

[oragrid@dltestoradb01:/oragrid] asmcmd lsop
Group_Name  Pass       State  Power  EST_WORK  EST_RATE  EST_TIME
[oragrid@dltestoradb01:/oragrid]
[oragrid@dltestoradb01:/oragrid]
[oragrid@dltestoradb01:/oragrid] asmcmd lsdsk -G DATA
Path
/dev/dlmax_asm/dlmax_asmd01
/dev/dlmax_asm/dlmax_asmd02
/dev/dlmax_asm/dlmax_asmd03
/dev/dlmax_asm/dlmax_asmd04



✔ 1. 查看现有磁盘组
asmcmd lsdg
✔ 2. 添加磁盘到 DATA
asmca -silent -addDisk -diskGroupName DATA -diskList '/dev/dlmax_asm/dlmax_asmd05'
✔ 3. 查看磁盘已被识别
asmcmd lsdsk -G DATA
✔ 4. 手工触发 rebalance（可选）
sqlplus / as sysasmalter diskgroup DATA rebalance power 8;
✔ 5. 查看 rebalance 进度
asmcmd lsop
