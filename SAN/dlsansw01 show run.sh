dlsansw01#
dlsansw01#
dlsansw01# show running-config

!Command: show running-config
!Running configuration last done at: Mon Dec 15 13:18:41 2025
!Time: Fri Dec 26 08:24:03 2025

version 9.4(2a)
power redundancy-mode redundant
system default switchport trunk mode off
feature telnet
role name default-role
  description This is a system defined role and applies to all users.
  rule 5 permit show feature environment
  rule 4 permit show feature hardware
  rule 3 permit show feature module
  rule 2 permit show feature snmp
  rule 1 permit show feature system
username admin password 5 $5$lAmypJPxtEnSIoez$gYqM0c96c0nWCfM2ryqviONixU/YrM4HeTXvAA26J0A  role network-admin
ip domain-lookup
ip host dlsansw01  10.68.47.101
aaa group server radius radius
snmp-server user admin network-admin auth md5 0x9b3f0d7b732ddcaf4ad80cbfa47ea5b6 priv aes-128 0x9b3f0d7b732ddcaf4ad80cbfa47ea5b6 localizedkey
snmp-server host 10.68.38.64 traps version 2c private
snmp-server host 10.68.40.131 traps version 2c public
rmon event 1 log trap public description FATAL(1) owner PMON@FATAL
rmon event 2 log trap public description CRITICAL(2) owner PMON@CRITICAL
rmon event 3 log trap public description ERROR(3) owner PMON@ERROR
rmon event 4 log trap public description WARNING(4) owner PMON@WARNING
rmon event 5 log trap public description INFORMATION(5) owner PMON@INFO

port-monitor name fabricmon_edge_policy
  logical-type edge
  counter link-loss poll-interval 30 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon portguard FPIN
  counter sync-loss poll-interval 30 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon portguard FPIN
  counter signal-loss poll-interval 30 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon portguard FPIN
  counter invalid-words poll-interval 30 delta rising-threshold 1 event 4 falling-threshold 0 event 4 alerts syslog rmon portguard FPIN
  counter invalid-crc poll-interval 30 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon portguard FPIN
  counter state-change poll-interval 60 delta rising-threshold 5 event 4 falling-threshold 0 event 4 alerts syslog rmon
  counter tx-discards poll-interval 60 delta rising-threshold 200 event 4 falling-threshold 10 event 4 alerts syslog rmon
  counter lr-rx poll-interval 60 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon
  counter lr-tx poll-interval 60 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon
  counter timeout-discards poll-interval 60 delta rising-threshold 200 event 4 falling-threshold 10 event 4 alerts syslog rmon
  counter credit-loss-reco poll-interval 1 delta rising-threshold 1 event 4 falling-threshold 0 event 4 alerts syslog rmon
  counter tx-credit-not-available poll-interval 1 delta rising-threshold 10 event 4 falling-threshold 0 event 4 alerts syslog rmon
  counter rx-datarate poll-interval 10 delta rising-threshold 80 event 4 falling-threshold 70 event 4 alerts syslog rmon obfl
  counter tx-datarate poll-interval 10 delta rising-threshold 80 event 4 falling-threshold 70 event 4 alerts syslog rmon obfl
  no monitor counter err-pkt-from-port
  no monitor counter err-pkt-to-xbar
  no monitor counter err-pkt-from-xbar
  counter tx-slowport-oper-delay poll-interval 1 absolute rising-threshold 50 event 4 falling-threshold 0 event 4 alerts syslog rmon
  counter txwait poll-interval 1 delta rising-threshold 30 event 4 falling-threshold 10 event 4 alerts syslog rmon portguard FPIN
  counter txwait warning-signal-threshold 40 alarm-signal-threshold 60 portguard congestion-signals
  no monitor counter sfp-tx-power-low-warn
  no monitor counter sfp-rx-power-low-warn
  counter rx-datarate-burst poll-interval 10 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon obfl datarate 90
  counter tx-datarate-burst poll-interval 10 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon obfl datarate 90
  counter input-errors poll-interval 60 delta rising-threshold 5 event 4 falling-threshold 1 event 4 alerts syslog rmon
snmp-server enable traps switchfabric fabric-crc
snmp-server enable traps callhome event-notify
snmp-server enable traps callhome smtp-send-fail
snmp-server enable traps cfs state-change-notif
snmp-server enable traps cfs merge-failure
snmp-server enable traps fcdomain dmNewPrincipalSwitchNotify
snmp-server enable traps fcdomain dmDomainIdNotAssignedNotify
snmp-server enable traps fcdomain dmFabricChangeNotify
snmp-server enable traps aaa server-state-change
snmp-server enable traps scsi scsi-lunDiscovery-complete
snmp-server enable traps fcns reject-reg-req
snmp-server enable traps fcns local-entry-change
snmp-server enable traps fcns db-full
snmp-server enable traps fcns remote-entry-change
snmp-server enable traps rscn rscnElsRejectReqNotify
snmp-server enable traps rscn rscnIlsRejectReqNotify
snmp-server enable traps rscn rscnElsRxRejectReqNotify
snmp-server enable traps rscn rscnIlsRxRejectReqNotify
snmp-server enable traps fcs request-reject
snmp-server enable traps fcs discovery-complete
snmp-server enable traps fctrace route-test-complete
snmp-server enable traps zone request-reject1
snmp-server enable traps zone merge-success
snmp-server enable traps zone merge-failure
snmp-server enable traps zone default-zone-behavior-change
snmp-server enable traps zone unsupp-mem
snmp-server enable traps vni virtual-interface-created
snmp-server enable traps vni virtual-interface-removed
snmp-server enable traps vsan vsanStatusChange
snmp-server enable traps vsan vsanPortMembershipChange
snmp-server enable traps fspf fspfNbrStateChangeNotify
snmp-server enable traps feature-control FeatureOpStatusChange
snmp-server enable traps vrrp cVrrpNotificationNewMaster
snmp-server enable traps fdmi cfdmiRejectRegNotify
snmp-server enable traps sysmgr cseFailSwCoreNotifyExtended
snmp-server enable traps config ccmCLIRunningConfigChanged
snmp-server enable traps snmp authentication
snmp-server enable traps link cisco-xcvr-mon-status-chg
snmp-server enable traps zone enhanced-zone-db-change
snmp-server enable traps system Clock-change-notification
snmp-server enable traps feature-control ciscoFeatOpStatusChange
snmp-server enable traps syslog message-generated
snmp-server community public group network-operator
vsan database
  vsan 101 name "vsan101"
device-alias database
  device-alias name PMX369_E1D1_S1_P1 pwwn 50:00:09:78:00:05:c4:01
  device-alias name PMX369_E1D2_S2_P1 pwwn 50:00:09:78:00:05:c4:41
  device-alias name dlisnesxi01_slot3P1 pwwn 51:40:2e:c0:20:3c:32:24
  device-alias name dlisnesxi02_slot3P1 pwwn 51:40:2e:c0:20:3c:52:a4
  device-alias name dlisnesxi03_slot3P1 pwwn 51:40:2e:c0:20:3c:33:c8
  device-alias name dlisnesxi04_slot3P1 pwwn 51:40:2e:c0:20:3c:35:fc
  device-alias name dlisnesxi05_slot3P1 pwwn 51:40:2e:c0:20:3c:53:60
  device-alias name dlisnesxi06_slot3P1 pwwn 51:40:2e:c0:20:3c:33:64
  device-alias name dlisnesxi07_slot3P1 pwwn 51:40:2e:c0:20:3c:33:b0
  device-alias name dlisnesxi08_slot3P1 pwwn 51:40:2e:c0:20:3c:50:a8
  device-alias name dlisnesxi09_slot3P1 pwwn 51:40:2e:c0:20:3c:31:24
  device-alias name dlisnesxi10_slot3P1 pwwn 51:40:2e:c0:20:3c:33:08
  device-alias name dlisnesxi11_slot3P1 pwwn 51:40:2e:c0:20:3c:52:7c
  device-alias name dlisnesxi12_slot3P1 pwwn 51:40:2e:c0:20:3c:52:94
  device-alias name dlisnesxi13_slot3P1 pwwn 51:40:2e:c0:20:3c:52:84
  device-alias name dlisnesxi14_slot3P1 pwwn 51:40:2e:c0:20:3c:53:98
  device-alias name dlisnesxi15_slot3P1 pwwn 51:40:2e:c0:20:3c:33:a4
  device-alias name dlisnesxi16_slot3P1 pwwn 51:40:2e:c0:20:3c:52:04
  device-alias name dlisnesxi17_slot3P1 pwwn 51:40:2e:c0:20:3c:33:60
  device-alias name dlisnesxi18_slot3P1 pwwn 51:40:2e:c0:20:3c:33:3c
  device-alias name dlisnesxi19_slot3P1 pwwn 51:40:2e:c0:20:3c:52:b8
  device-alias name dlisnesxi20_slot3P1 pwwn 51:40:2e:c0:20:3c:4f:c4
  device-alias name dlisnesxi21_slot1P1 pwwn 10:00:70:b7:e4:2a:28:93
  device-alias name dlisnesxi22_slot1P1 pwwn 10:00:70:b7:e4:2a:28:48
  device-alias name powermax2k_SPA_slot2P0 pwwn 50:00:09:75:b0:41:f8:04
  device-alias name powermax2k_SPA_slot2P1 pwwn 50:00:09:75:b0:41:f8:05
  device-alias name powermax2k_SPA_slot2P2 pwwn 50:00:09:75:b0:41:f8:06
  device-alias name powermax2k_SPA_slot3P0 pwwn 50:00:09:75:b0:41:f8:08
  device-alias name powermax2k_SPA_slot3P1 pwwn 50:00:09:75:b0:41:f8:09
  device-alias name powermax2k_SPA_slot3P2 pwwn 50:00:09:75:b0:41:f8:0a

device-alias commit

fcdomain fcid database
  vsan 1 wwn 51:40:2e:c0:20:3c:52:04 fcid 0x1e0000 dynamic
    !        [dlisnesxi16_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:60 fcid 0x1e0020 dynamic
    !        [dlisnesxi17_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:3c fcid 0x1e0040 dynamic
    !        [dlisnesxi18_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:52:b8 fcid 0x1e0060 dynamic
    !        [dlisnesxi19_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:4f:c4 fcid 0x1e0080 dynamic
    !        [dlisnesxi20_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:53:60 fcid 0x1e00a0 dynamic
    !        [dlisnesxi05_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:64 fcid 0x1e00c0 dynamic
    !        [dlisnesxi06_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:b0 fcid 0x1e00e0 dynamic
    !        [dlisnesxi07_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:50:a8 fcid 0x1e0100 dynamic
    !        [dlisnesxi08_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:31:24 fcid 0x1e0120 dynamic
    !        [dlisnesxi09_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:08 fcid 0x1e0140 dynamic
    !        [dlisnesxi10_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:52:7c fcid 0x1e0160 dynamic
    !        [dlisnesxi11_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:52:94 fcid 0x1e0180 dynamic
    !        [dlisnesxi12_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:52:84 fcid 0x1e01a0 dynamic
    !        [dlisnesxi13_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:53:98 fcid 0x1e01c0 dynamic
    !        [dlisnesxi14_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:a4 fcid 0x1e01e0 dynamic
    !        [dlisnesxi15_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:35:fc fcid 0x1e0200 dynamic
    !        [dlisnesxi04_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:52:a4 fcid 0x1e0220 dynamic
    !        [dlisnesxi02_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:33:c8 fcid 0x1e0240 dynamic
    !        [dlisnesxi03_slot3P1]
  vsan 1 wwn 51:40:2e:c0:20:3c:32:24 fcid 0x1e0260 dynamic
    !        [dlisnesxi01_slot3P1]
  vsan 1 wwn 50:00:09:75:b0:41:f8:04 fcid 0x1e0280 dynamic
    !        [powermax2k_SPA_slot2P0]
  vsan 1 wwn 50:00:09:75:b0:41:f8:08 fcid 0x1e02a0 dynamic
    !        [powermax2k_SPA_slot3P0]
  vsan 1 wwn 50:00:09:75:b0:41:f8:05 fcid 0x1e02c0 dynamic
    !        [powermax2k_SPA_slot2P1]
  vsan 1 wwn 50:00:09:75:b0:41:f8:09 fcid 0x1e02e0 dynamic
    !        [powermax2k_SPA_slot3P1]
  vsan 1 wwn 50:00:09:75:b0:41:f8:06 fcid 0x1e0300 dynamic
    !        [powermax2k_SPA_slot2P2]
  vsan 1 wwn 50:00:09:75:b0:41:f8:0a fcid 0x1e0320 dynamic
    !        [powermax2k_SPA_slot3P2]
  vsan 101 wwn 51:40:2e:c0:20:3c:32:24 fcid 0xdd0000 dynamic
    !          [dlisnesxi01_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:52:a4 fcid 0xdd0020 dynamic
    !          [dlisnesxi02_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:c8 fcid 0xdd0040 dynamic
    !          [dlisnesxi03_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:35:fc fcid 0xdd0060 dynamic
    !          [dlisnesxi04_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:53:60 fcid 0xdd0080 dynamic
    !          [dlisnesxi05_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:64 fcid 0xdd00a0 dynamic
    !          [dlisnesxi06_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:b0 fcid 0xdd00c0 dynamic
    !          [dlisnesxi07_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:50:a8 fcid 0xdd00e0 dynamic
    !          [dlisnesxi08_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:31:24 fcid 0xdd0100 dynamic
    !          [dlisnesxi09_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:08 fcid 0xdd0120 dynamic
    !          [dlisnesxi10_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:52:7c fcid 0xdd0140 dynamic
    !          [dlisnesxi11_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:52:94 fcid 0xdd0160 dynamic
    !          [dlisnesxi12_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:52:84 fcid 0xdd0180 dynamic
    !          [dlisnesxi13_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:53:98 fcid 0xdd01a0 dynamic
    !          [dlisnesxi14_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:a4 fcid 0xdd01c0 dynamic
    !          [dlisnesxi15_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:52:04 fcid 0xdd01e0 dynamic
    !          [dlisnesxi16_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:60 fcid 0xdd0200 dynamic
    !          [dlisnesxi17_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:33:3c fcid 0xdd0220 dynamic
    !          [dlisnesxi18_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:52:b8 fcid 0xdd0240 dynamic
    !          [dlisnesxi19_slot3P1]
  vsan 101 wwn 51:40:2e:c0:20:3c:4f:c4 fcid 0xdd0260 dynamic
    !          [dlisnesxi20_slot3P1]
  vsan 101 wwn 50:00:09:75:b0:41:f8:04 fcid 0xdd0280 dynamic
    !          [powermax2k_SPA_slot2P0]
  vsan 101 wwn 50:00:09:75:b0:41:f8:08 fcid 0xdd02a0 dynamic
    !          [powermax2k_SPA_slot3P0]
  vsan 101 wwn 50:00:09:75:b0:41:f8:05 fcid 0xdd02c0 dynamic
    !          [powermax2k_SPA_slot2P1]
  vsan 101 wwn 50:00:09:75:b0:41:f8:09 fcid 0xdd02e0 dynamic
    !          [powermax2k_SPA_slot3P1]
  vsan 101 wwn 50:00:09:75:b0:41:f8:06 fcid 0xdd0300 dynamic
    !          [powermax2k_SPA_slot2P2]
  vsan 101 wwn 50:00:09:75:b0:41:f8:0a fcid 0xdd0320 dynamic
    !          [powermax2k_SPA_slot3P2]
  vsan 1 wwn 10:00:70:b7:e4:2a:28:93 fcid 0x1e0340 dynamic
    !        [dlisnesxi21_slot1P1]
  vsan 1 wwn 10:00:70:b7:e4:2a:28:48 fcid 0x1e0360 dynamic
    !        [dlisnesxi22_slot1P1]
  vsan 101 wwn 10:00:70:b7:e4:2a:28:93 fcid 0xdd0340 dynamic
    !          [dlisnesxi21_slot1P1]
  vsan 101 wwn 10:00:70:b7:e4:2a:28:48 fcid 0xdd0360 dynamic
    !          [dlisnesxi22_slot1P1]
  vsan 101 wwn 50:00:09:78:00:05:c4:01 fcid 0xdd0380 dynamic
    !          [PMX369_E1D1_S1_P1]
  vsan 101 wwn 50:00:09:78:00:05:c4:41 fcid 0xdd03a0 dynamic
    !          [PMX369_E1D2_S2_P1]
!Active Zone Database Section for vsan 101
zone name dlisnesxi01_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi01_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi02_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi02_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi03_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi03_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi04_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi04_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi05_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi05_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi06_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi06_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi07_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi07_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi08_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi08_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi09_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi09_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi10_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi10_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi11_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi11_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi12_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi12_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi13_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi13_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi14_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi14_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi15_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi15_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi16_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi16_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi17_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi17_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi18_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi18_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi19_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi19_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi20_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi20_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi21_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi21_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi22_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi22_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi05_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi05_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi06_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi06_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi07_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi07_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi08_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi08_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi09_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi09_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi10_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi10_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi11_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi11_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi12_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi12_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi13_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi13_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi14_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi14_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi21_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi21_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi22_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi22_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zoneset name zoneset01 vsan 101
    member dlisnesxi01_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi02_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi03_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi04_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi05_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi06_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi07_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi08_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi09_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi10_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi11_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi12_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi13_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi14_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi15_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi16_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi17_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi18_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi19_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi20_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi21_slot1P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi22_slot1P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi05_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi06_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi07_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi08_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi09_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi10_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi11_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi12_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi13_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi14_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi21_slot1P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi22_slot1P1_PMX369_E1D1_PMX369_E1D2

zoneset activate name zoneset01 vsan 101
do clear zone database vsan 101
!Full Zone Database Section for vsan 101
zone name dlisnesxi01_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi01_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi02_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi02_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi03_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi03_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi04_slot3P1-powermax2k_SPA_slot2P0-slot3p0 vsan 101
    member device-alias dlisnesxi04_slot3P1
    member device-alias powermax2k_SPA_slot2P0
    member device-alias powermax2k_SPA_slot3P0

zone name dlisnesxi05_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi05_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi06_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi06_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi07_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi07_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi08_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi08_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi09_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi09_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi10_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi10_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi11_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi11_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi12_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi12_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi13_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi13_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi14_slot3P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi14_slot3P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi15_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi15_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi16_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi16_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi17_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi17_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi18_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi18_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi19_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi19_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi20_slot3P1-powermax2k_SPA_slot2P2-slot3p2 vsan 101
    member device-alias dlisnesxi20_slot3P1
    member device-alias powermax2k_SPA_slot2P2
    member device-alias powermax2k_SPA_slot3P2

zone name dlisnesxi21_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi21_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi22_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi22_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi05_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi05_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi06_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi06_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi07_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi07_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi08_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi08_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi09_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi09_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi10_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi10_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi11_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi11_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi12_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi12_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi13_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi13_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi14_slot3P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi14_slot3P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi21_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi21_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi22_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi22_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zoneset name zoneset01 vsan 101
    member dlisnesxi01_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi02_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi03_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi04_slot3P1-powermax2k_SPA_slot2P0-slot3p0
    member dlisnesxi05_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi06_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi07_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi08_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi09_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi10_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi11_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi12_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi13_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi14_slot3P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi15_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi16_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi17_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi18_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi19_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi20_slot3P1-powermax2k_SPA_slot2P2-slot3p2
    member dlisnesxi21_slot1P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi22_slot1P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi05_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi06_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi07_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi08_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi09_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi10_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi11_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi12_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi13_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi14_slot3P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi21_slot1P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi22_slot1P1_PMX369_E1D1_PMX369_E1D2



interface mgmt0
  ip address 10.68.47.101 255.255.255.0
vsan database
  vsan 101 interface fc1/5
  vsan 101 interface fc1/6
  vsan 101 interface fc1/7
  vsan 101 interface fc1/8
  vsan 101 interface fc1/9
  vsan 101 interface fc1/10
  vsan 101 interface fc1/11
  vsan 101 interface fc1/12
  vsan 101 interface fc1/13
  vsan 101 interface fc1/14
  vsan 101 interface fc1/15
  vsan 101 interface fc1/16
  vsan 101 interface fc1/17
  vsan 101 interface fc1/18
  vsan 101 interface fc1/19
  vsan 101 interface fc1/20
  vsan 101 interface fc1/21
  vsan 101 interface fc1/22
  vsan 101 interface fc1/23
  vsan 101 interface fc1/24
  vsan 101 interface fc1/25
  vsan 101 interface fc1/26
  vsan 101 interface fc1/27
  vsan 101 interface fc1/28
  vsan 101 interface fc1/39
  vsan 101 interface fc1/40
  vsan 101 interface fc1/41
  vsan 101 interface fc1/42
  vsan 101 interface fc1/43
  vsan 101 interface fc1/44
switchname dlsansw01
cli alias name ShowIntStats source sys/show_int_tabular.py
no terminal log-all
line console
line vty
boot kickstart bootflash:/m9148-s6ek9-kickstart-mz.9.4.2a.bin
boot system bootflash:/m9148-s6ek9-mz.9.4.2a.bin
interface fc1/1
interface fc1/2
interface fc1/3
interface fc1/4
interface fc1/5
interface fc1/6
interface fc1/7
interface fc1/8
interface fc1/9
interface fc1/10
interface fc1/11
interface fc1/12
interface fc1/13
interface fc1/14
interface fc1/15
interface fc1/16
interface fc1/17
interface fc1/18
interface fc1/19
interface fc1/20
interface fc1/21
interface fc1/22
interface fc1/23
interface fc1/24
interface fc1/25
interface fc1/26
interface fc1/27
interface fc1/28
interface fc1/29
interface fc1/30
interface fc1/31
interface fc1/32
interface fc1/33
interface fc1/34
interface fc1/35
interface fc1/36
interface fc1/37
interface fc1/38
interface fc1/39
interface fc1/40
interface fc1/41
interface fc1/42
interface fc1/43
interface fc1/44
interface fc1/45
interface fc1/46
interface fc1/47
interface fc1/48

interface fc1/1
  port-license acquire

interface fc1/2
  port-license acquire

interface fc1/3
  port-license acquire

interface fc1/4
  port-license acquire

interface fc1/5
  port-license acquire
  no shutdown

interface fc1/6
  port-license acquire
  no shutdown

interface fc1/7
  port-license acquire
  no shutdown

interface fc1/8
  port-license acquire
  no shutdown

interface fc1/9
  port-license acquire
  no shutdown

interface fc1/10
  port-license acquire
  no shutdown

interface fc1/11
  port-license acquire
  no shutdown

interface fc1/12
  port-license acquire
  no shutdown

interface fc1/13
  port-license acquire
  no shutdown

interface fc1/14
  port-license acquire
  no shutdown

interface fc1/15
  port-license acquire
  no shutdown

interface fc1/16
  port-license acquire
  no shutdown

interface fc1/17
  port-license acquire
  no shutdown

interface fc1/18
  port-license acquire
  no shutdown

interface fc1/19
  port-license acquire
  no shutdown

interface fc1/20
  port-license acquire
  no shutdown

interface fc1/21
  port-license acquire
  no shutdown

interface fc1/22
  port-license acquire
  no shutdown

interface fc1/23
  port-license acquire
  no shutdown

interface fc1/24
  port-license acquire
  no shutdown

interface fc1/25
  port-license acquire
  no shutdown

interface fc1/26
  port-license acquire
  no shutdown

interface fc1/27
  port-license acquire
  no shutdown

interface fc1/28
  port-license acquire
  no shutdown

interface fc1/29
  port-license acquire

interface fc1/30
  port-license acquire

interface fc1/31
  port-license acquire

interface fc1/32
  port-license acquire

interface fc1/33
  port-license acquire

interface fc1/34
  port-license acquire

interface fc1/35
  port-license acquire

interface fc1/36
  port-license acquire

interface fc1/37
  port-license acquire

interface fc1/38
  port-license acquire

interface fc1/39
  port-license acquire
  no shutdown

interface fc1/40
  port-license acquire
  no shutdown

interface fc1/41
  port-license acquire
  no shutdown

interface fc1/42
  port-license acquire
  no shutdown

interface fc1/43
  port-license acquire
  no shutdown

interface fc1/44
  port-license acquire
  no shutdown

interface fc1/45
  port-license acquire

interface fc1/46
  port-license acquire

interface fc1/47
  port-license acquire

interface fc1/48
  port-license acquire
ip default-gateway 10.68.47.1

dlsansw01#
dlsansw01#
dlsansw01#