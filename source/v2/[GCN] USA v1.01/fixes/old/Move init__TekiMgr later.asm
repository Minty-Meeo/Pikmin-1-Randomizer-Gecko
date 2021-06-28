#To be inserted at 8010f5fc
.macro	call addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm


end__7MemStatFPc       = 0x80086848
start__7MemStatFPc     = 0x80086738
setHeap__9StdSystemFi  = 0x8003f068
startStage__7TekiMgrFv = 0x8014a898

init__12GeneratorMgrFv = 0x800dd8c8
GeneratorMgr = 0x3080
TekiMgr = 0x3160
gsys    = 0x2DEC
memStat = 0x2FE8


;NOP out instruction at {8010f474}

lwz	r3, memStat (r13)
subi	r4, r13, 0x2574
call	start__7MemStatFPc

lwz	r3, gsys (r13)
li	r4, 4
call	setHeap__9StdSystemFi
mr	r20, r3

lwz	r3, TekiMgr (r13)
call	startStage__7TekiMgrFv

lwz	r3, gsys (r13)
mr	r4, r20
call	setHeap__9StdSystemFi

lwz	r3, memStat (r13)
subi	r4, r13, 0x2574
call	end__7MemStatFPc




HIJACKED:
	lwz	r21, 0x3068 (r13)






