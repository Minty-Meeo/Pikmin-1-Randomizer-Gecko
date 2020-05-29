#To be inserted at 80099e50
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Pellets                               Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;In function [doRead__15GenObjectPelletFR18RandomAccessStream]
;r31 has the pointer to the pellet GEN Object
;   Member at 0x1C is an ID32
;r3 is the index from the pelMgr table as returned by [getConfigIndex__9PelletMgrFUl]

getConfigIndex = 0x80098c48

PROLOGUE:
mflr	r0
stwu	sp, -0x0018 (sp)
stw	r0, 0x0004 (sp)
stmw	r28, 0x0008 (sp)


cmpwi	r3, 19   ; Is this a number pellet or some stupid corpse?
ble-	FUCK_OFF
cmpwi	r3, 52   ; Is this some other stupid corpse?
bge-	FUCK_OFF
cmpwi	r3, 34   ; There's a special place in hell for you three
beq-	FUCK_OFF
cmpwi	r3, 35   ; There's a special place in hell for you three
beq-	FUCK_OFF
cmpwi	r3, 36   ; There's a special place in hell for you three
beq-	FUCK_OFF


;Actually while we still have the results for comparison against 36
blt-	0x0008
subi	r3, r3, 3    ; Cut out those three in the middle
subi	r3, r3, 19   ; Convert Pellet ID to "UFO Part ID"




;Cipher Shift the UFO Part ID
addi	r3, r3, 19
li	r0, 30          ; Limit returned value from 0 - 29
divw	r30, r3 ,  r0   ; Modulo 30 (1/3)
mullw	r30, r30,  r0   ; Modulo 30 (2/3)
sub	r30, r3 , r30   ; Modulo 30 (3/3)







b	GO_FORTH
GO_BACK:

mflr	r29
mulli	r30, r30, 4    ; u8 index -> u32 index
lwzx	r30, r29, r30
b SKIP_FAR



GO_FORTH:
bl	GO_BACK
;This is a Randomly sorted list of all UFO Part ID32s
.long 0x75737433 ;ust3
.long 0x756E3131 ;un11
.long 0x75663039 ;uf09
.long 0x756E3032 ;un02
.long 0x756E3034 ;un04
.long 0x756E3035 ;un05
.long 0x75663032 ;uf02
.long 0x756E3038 ;un08
.long 0x75737431 ;ust1
.long 0x75663036 ;uf06
.long 0x756E3130 ;un10
.long 0x756E3134 ;un14
.long 0x756E3037 ;un07
.long 0x75663035 ;uf05
.long 0x75737432 ;ust2
.long 0x75663031 ;uf01
.long 0x75663037 ;uf07
.long 0x75663131 ;uf11
.long 0x75663038 ;uf08
.long 0x756E3039 ;un09
.long 0x756E3036 ;un06
.long 0x756E3132 ;un12
.long 0x756E3133 ;un13
.long 0x756E3033 ;un03
.long 0x75737434 ;ust4
.long 0x756E3031 ;un01
.long 0x75663130 ;uf10
.long 0x75737435 ;ust5
.long 0x75663034 ;uf04
.long 0x75663033 ;uf03

;This is a list of all UFO Part ID32s
;.long 0x75737431   ;ust1  Bowspirit
;.long 0x75737432   ;ust2  Gluon Drive
;.long 0x75737433   ;ust3  Anti-Dioxin Filter
;.long 0x75737434   ;ust4  Eternal Fuel Dynamo
;.long 0x75737435   ;ust5  Main Engine
;.long 0x75663031   ;uf01  Whimsical Radar
;.long 0x75663032   ;uf02  Interstellar Radio
;.long 0x75663033   ;uf03  Guard Satellite
;.long 0x75663034   ;uf04  Chronos Reactor
;.long 0x75663035   ;uf05  Radiation Canopy
;.long 0x75663036   ;uf06  Geiger Counter
;.long 0x75663037   ;uf07  Sagittarius
;.long 0x75663038   ;uf08  Libra
;.long 0x75663039   ;uf09  Omega Stabilizer
;.long 0x75663130   ;uf10  Ionium Jet #1
;.long 0x75663131   ;uf11  Ionium Jet #2
;.long 0x756E3031   ;un01  Shock Absorber
;.long 0x756E3032   ;un02  Gravity Jumper
;.long 0x756E3033   ;un03  Pilot's Seat
;.long 0x756E3034   ;un04  Nova Blaster
;.long 0x756E3035   ;un05  Automatic Gear
;.long 0x756E3036   ;un06  Zirconium Rotor
;.long 0x756E3037   ;un07  Extraordinary Bolt
;.long 0x756E3038   ;un08  Repair-Type Bolt
;.long 0x756E3039   ;un09  Space Float
;.long 0x756E3130   ;un10  Massage Machine
;.long 0x756E3131   ;un11  Secret Safe
;.long 0x756E3132   ;un12  Positron Generator
;.long 0x756E3133   ;un13  Analog Computer
;.long 0x756E3134   ;un14  UV Lamp

SKIP_FAR:
stw	r30, 0x001C (r31)
stw	r30, 0x0020 (r31)

lis	r3, getConfigIndex@h
ori	r3, r3, getConfigIndex@l
mtctr	r3
lwz	r3, 0x301C (r13)
lwz	r4, 0x001C (r31)
bctrl


FUCK_OFF:

HIJACKED:
stw	r3, 0x0018 (r31)


EPILOGUE:
lmw	r28, 0x0008 (sp)
lwz	r0, 0x0004 (sp)
lwz	sp, 0 (sp)
mtlr	r0






























