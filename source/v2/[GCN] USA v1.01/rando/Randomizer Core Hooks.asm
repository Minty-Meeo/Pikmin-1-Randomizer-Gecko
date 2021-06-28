#To be inserted at 800dc0fc
;800de020 | init__10GenTypeOneFP9Generator
;800de410 | init__13GenTypeAtOnceFP9Generator
;800de694 | init__15GenTypeInitRandFP9Generator
;800dc0fc | init__9GeneratorFv


EXPOSITION:
	;mr	r3, r31   ;[init__10GenTypeOneFP9Generator]
	;mr	r3, r29   ;[init__13GenTypeAtOnceFP9Generator]
	;mr	r3, r29   ;[init__15GenTypeInitRandFP9Generator]
	mr	r3, r31   ;[init__9GeneratorFv]

BODY:
	lis	r12, 0x8000
	lwz	r12, 0x0050 (r12) ;[Gecko Function Table]
	mtlr	r12
	blrl	;-->[Randomize Generator]

HIJACKED:
	;lwz	r3, 0x0030 (r31)   ;[init__10GenTypeOneFP9Generator]
	;lwz	r3, 0x0030 (r29)   ;[init__13GenTypeAtOnceFP9Generator]
	;lwz	r3, 0x0030 (r29)   ;[init__15GenTypeInitRandFP9Generator]
	lwz	r3, 0x0030 (r31)   ;[init__9GeneratorFv]

