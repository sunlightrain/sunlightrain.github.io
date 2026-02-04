
#开启端口
conf t
int fc1/29-31
  no shut

#将端口加入 VSAN 101
vsan database
     vsan 101 name vsan101
     vsan 101 interface fc1/29
     vsan 101 interface fc1/30
     vsan 101 interface fc1/31

或在交换机上等待 FLOGI 后查看：
dlsansw01# show flogi database | include fc1/29
fc1/29           101   0xdd03c0  10:00:70:b7:e4:2a:26:54 20:00:70:b7:e4:2a:26:54
dlsansw01# show flogi database | include fc1/30
fc1/30           101   0xdd03e0  10:00:70:b7:e4:2a:4d:db 20:00:70:b7:e4:2a:4d:db
dlsansw01# show flogi database | include fc1/31
fc1/31           101   0xdd0400  10:00:70:b7:e4:2a:26:b7 20:00:70:b7:e4:2a:26:b7

#配置 device-alias
conf t
device-alias database
device-alias name dlisnesxi23_slot1P1 pwwn 10:00:70:b7:e4:2a:26:54
device-alias name dlisnesxi24_slot1P1 pwwn 10:00:70:b7:e4:2a:4d:db
device-alias name dlisnesxi25_slot1P1 pwwn 10:00:70:b7:e4:2a:26:b7
exit
device-alias commit


#现有配置
zone name dlisnesxi21_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi21_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi22_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi22_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1

zone name dlisnesxi21_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi21_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

zone name dlisnesxi22_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi22_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1



#使用 device-alias 创建 zone PMX369
zone name dlisnesxi23_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi23_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1
zone name dlisnesxi24_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi24_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1
zone name dlisnesxi25_slot1P1_PMX369_E1D1_PMX369_E1D2 vsan 101
    member device-alias dlisnesxi25_slot1P1
    member device-alias PMX369_E1D1_S1_P1
    member device-alias PMX369_E1D2_S2_P1
#使用 device-alias 创建 zone PMX2K
zone name dlisnesxi23_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi23_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1
zone name dlisnesxi24_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi24_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1
zone name dlisnesxi25_slot1P1-powermax2k_SPA_slot2P1-slot3p1 vsan 101
    member device-alias dlisnesxi25_slot1P1
    member device-alias powermax2k_SPA_slot2P1
    member device-alias powermax2k_SPA_slot3P1

#加入 zoneset 并激活
zoneset name zoneset01 vsan 101
    member dlisnesxi23_slot1P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi24_slot1P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi25_slot1P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi23_slot1P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi24_slot1P1-powermax2k_SPA_slot2P1-slot3p1
    member dlisnesxi25_slot1P1-powermax2k_SPA_slot2P1-slot3p1
exit
zoneset activate name zoneset01 vsan 101
#END
#保存配置
copy running-config startup-config