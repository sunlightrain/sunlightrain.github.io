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