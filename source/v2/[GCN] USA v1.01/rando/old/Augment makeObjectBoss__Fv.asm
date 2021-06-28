#To be inserted at 8014d340
;╔════════════════════════════════════════════════════════════╗
;║ Augment makeObjectBoss__Fv                      Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;NO STACK FRAME!!!
;In function [makeObjectBoss__Fv 	plugPikiNishimura.a genBoss.cpp]


;--------------------------------------------------------------------------------
alloc__6SystemFUl = 0x80047004
__ct__15TekiPersonalityFv = 0x8014ca60
;--------------------------------------------------------------------------------
;Tail
;0411b2d0 3860002c   // Resize GenObjectTeki
;--------------------------------------------------------------------------------

li	r3, 0x0038
lis	r12,      alloc__6SystemFUl@h
ori	r12, r12, alloc__6SystemFUl@l
mtctr	r12
bctrl	;-->[alloc__6SystemFUl]
stw	r3, 0x0018 (r31)
lis	r12,      __ct__15TekiPersonalityFv@h
ori	r12, r12, __ct__15TekiPersonalityFv@l
mtctr	r12
bctrl	;-->[__ct__15TekiPersonalityFv]

lwz	r12, 0x0018 (r31)   ;dereference ParaMultiParameters
lwz	r12, 0x0000 (r12)
lwz	r12, 0x0000 (r12)




HIJACKED:
	;don't










