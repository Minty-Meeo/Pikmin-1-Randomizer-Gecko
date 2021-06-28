inside_GenTypeOne__init      = 0x800de02c
inside_GenTypeAtOnce__init   = 0x800de41c
inside_GenTypeInitRand__init = 0x800de6a0


;---Compiler Constants-----------------------------------------
header_size = 28
;---Local Vars-------------------------------------------------
Generator = 3
;--------------------------------------------------------------



;===Header Code================================================
sc
mfspr	r3, SRR0
addi	r3, r3, (header_size-1)*4

lwz	r12, -0x000C (r3)
sub	r11, r3, r12
rlwinm	r11, r11, 0, 6, 29
oris	r11, r11, 0x4800
ori	r11, r11, 0x0001
stw	r11, 0x0000 (r12)
icbi	0, r12

lwz	r12, -0x0008 (r3)
sub	r11, r3, r12
rlwinm	r11, r11, 0, 6, 29
oris	r11, r11, 0x4800
ori	r11, r11, 0x0001
stw	r11, 0x0000 (r12)
icbi	0, r12

lwz	r12, -0x0004 (r3)
sub	r11, r3, r12
rlwinm	r11, r11, 0, 6, 29
oris	r11, r11, 0x4800
ori	r11, r11, 0x0001
stw	r11, 0x0000 (r12)
icbi	0, r12
blr
.long inside_GenTypeOne__init
.long inside_GenTypeAtOnce__init
.long inside_GenTypeInitRand__init
;==============================================================


PROLOGUE:
	mflr	r0
	stw	r0, 0x0004 (sp)
	stwu	sp, -0x0008 (sp)

BODY:
	lis	r12, 0x8000
	lwz	r12, 0x0050 (r12) ;[Gecko Function Table]
	mtlr	r12
	blrl	;-->[Randomize Generator]
	
EPILOGUE:
	lwz	sp, 0x0000 (sp)
	lwz	r0, 0x0004 (sp)
	mtlr	r0

HIJACKED:
	lwz	r12, 0x0004 (r3)

blr



















