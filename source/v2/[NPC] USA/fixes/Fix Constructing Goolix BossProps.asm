#To be inserted at 80150860
;╔════════════════════════════════════════════════════════════╗
;║ Fix Constructing Goolix BossProps               Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;---STACK------------------------------------------------------

;---Compiler Constants-----------------------------------------

;---Function Pointers------------------------------------------

;---Constants--------------------------------------------------

;---Macros-----------------------------------------------------
.macro	call	addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm

.macro	lfsi	fprD, val
bl	0x0008
.float	\val
mflr	r12
lfs	\fprD, 0x0000 (r12)
.endm
;--------------------------------------------------------------

EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	lwz	r5, 0x0040 (r30)   ;Load UseList from BossMgr
	lwz	r5, 0x0008 (r5)    ;Goolix is third entry

EPILOGUE:
	;
	
HIJACKED:
	;li	r5, 1   (don't)






