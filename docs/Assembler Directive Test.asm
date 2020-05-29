;https://web.mit.edu/gnu/doc/html/as_7.html

compiler_flag = 1



.byte	0xFF
.short	0xDEAD
.hword 0xAAAA
.word	0xBEEF
.int	0xFFFF
.long	0x12345678
.llong	0x5959595959595959
.balign 4
.float	1.2
.double	1.2
.asciz	"haha lol"
.ascii	"haha lol"
.if	compiler_flag
.ascii "        "
.else	
.endif	