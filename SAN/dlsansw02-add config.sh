#开启端口
conf t
int fc1/29-31
  no shut

#将端口加入 VSAN 102
conf t
vsan database
     vsan 102 interface fc1/29
     vsan 102 interface fc1/30
     vsan 102 interface fc1/31

#在交换机上等待 FLOGI 后查看：
dlsansw02# show flogi database | include fc1/29
fc1/29           102   0x3903c0  10:00:70:b7:e4:2a:26:06 20:00:70:b7:e4:2a:26:06
dlsansw02# show flogi database | include fc1/30
fc1/30           102   0x3903e0  10:00:70:b7:e4:2a:4d:e7 20:00:70:b7:e4:2a:4d:e7
dlsansw02# show flogi database | include fc1/31
fc1/31           102   0x390400  10:00:70:b7:e4:2a:26:69 20:00:70:b7:e4:2a:26:69


#配置 device-alias
conf t
device-alias database
device-alias name dlisnesxi23_slot4P1 pwwn 10:00:70:b7:e4:2a:26:06
device-alias name dlisnesxi24_slot4P1 pwwn 10:00:70:b7:e4:2a:4d:e7
device-alias name dlisnesxi25_slot4P1 pwwn 10:00:70:b7:e4:2a:26:69
exit
device-alias commit

#现有Zone配置
zone name dlisnesxi21_slot4P1-powermax2k_SPB_slot2P1-slot3p1 vsan 102
    member device-alias dlisnesxi21_slot4P1
    member device-alias powermax2k_SPB_slot2P1
    member device-alias powermax2k_SPB_slot3P1

zone name dlisnesxi22_slot4P1-powermax2k_SPB_slot2P1-slot3p1 vsan 102
    member device-alias dlisnesxi22_slot4P1
    member device-alias powermax2k_SPB_slot2P1
    member device-alias powermax2k_SPB_slot3P1

zone name dlisnesxi21_slot4P1_PMX369_E1D1_PMX369_E1D2 vsan 102
    member device-alias dlisnesxi21_slot4P1
    member device-alias PMX369_E1D1_S1_P5
    member device-alias PMX369_E1D2_S2_P5

zone name dlisnesxi22_slot4P1_PMX369_E1D1_PMX369_E1D2 vsan 102
    member device-alias dlisnesxi22_slot4P1
    member device-alias PMX369_E1D1_S1_P5
    member device-alias PMX369_E1D2_S2_P5


#使用 device-alias 创建 zone PMX369
zone name dlisnesxi23_slot4P1_PMX369_E1D1_PMX369_E1D2 vsan 102
    member device-alias dlisnesxi23_slot4P1
    member device-alias PMX369_E1D1_S1_P5
    member device-alias PMX369_E1D2_S2_P5
zone name dlisnesxi24_slot4P1_PMX369_E1D1_PMX369_E1D2 vsan 102
    member device-alias dlisnesxi24_slot4P1
    member device-alias PMX369_E1D1_S1_P5
    member device-alias PMX369_E1D2_S2_P5

zone name dlisnesxi25_slot4P1_PMX369_E1D1_PMX369_E1D2 vsan 102
    member device-alias dlisnesxi25_slot4P1
    member device-alias PMX369_E1D1_S1_P5
    member device-alias PMX369_E1D2_S2_P5
#使用 device-alias 创建 zone PMX2K
zone name dlisnesxi23_slot4P1-powermax2k_SPB_slot2P1-slot3p1 vsan 102
    member device-alias dlisnesxi23_slot4P1
    member device-alias powermax2k_SPB_slot2P1
    member device-alias powermax2k_SPB_slot3P1

zone name dlisnesxi24_slot4P1-powermax2k_SPB_slot2P1-slot3p1 vsan 102
    member device-alias dlisnesxi24_slot4P1
    member device-alias powermax2k_SPB_slot2P1
    member device-alias powermax2k_SPB_slot3P1

zone name dlisnesxi25_slot4P1-powermax2k_SPB_slot2P1-slot3p1 vsan 102
    member device-alias dlisnesxi25_slot4P1
    member device-alias powermax2k_SPB_slot2P1
    member device-alias powermax2k_SPB_slot3P1

#加入 zoneset 并激活
zoneset name zoneset02 vsan 102
    member dlisnesxi23_slot4P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi24_slot4P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi25_slot4P1_PMX369_E1D1_PMX369_E1D2
    member dlisnesxi23_slot4P1-powermax2k_SPB_slot2P1-slot3p1
    member dlisnesxi24_slot4P1-powermax2k_SPB_slot2P1-slot3p1
    member dlisnesxi25_slot4P1-powermax2k_SPB_slot2P1-slot3p1
exit
zoneset activate name zoneset02 vsan 102
#END
#保存配置
copy running-config startup-config
