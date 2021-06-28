;╔════════════════════════════════════════════════════════════╗
;║ Partner Code                                    Minty Meeo ║
;║ for "Replacement GenObjectBoss__birth"                     ║
;╚════════════════════════════════════════════════════════════╝
line_count = 7

__vt__GenObjectBoss__birth = 0x802ce7d8

sc
mfspr	r11, SRR0
addi	r11, r11, ( ( line_count + !( line_count & 1 ) ) * 4 ) + 0x08
lis	r12,      __vt__GenObjectBoss__birth@h
ori	r12, r12, __vt__GenObjectBoss__birth@l
stw	r11, 0x0000 (r12)
blr




