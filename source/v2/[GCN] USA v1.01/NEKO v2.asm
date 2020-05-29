;╔════════════════════════════════════════════════════════════╗
;║ Neko Codes v2 on Gecko Thread                   Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;---STACK------------------------------------------------------
; 0x0000 Old SP
; 0x0004 LR Reserved
;---Compiler Constants-----------------------------------------
;gpr_save = 20

permVar0 = 31
permVar1 = 30
permVar2 = 29
permVar3 = 28

tempVar0 = 27
tempVar1 = 26
tempVar2 = 25
tempVar3 = 24
;---Local Vars-------------------------------------------------
neko_file     = permVar0
command_count = permVar1
dest_ptr      = permVar2
src_ptr       = permVar3
;---Function Pointers------------------------------------------
randomInt__7NSystemFi    = 0x8011e8a4
rand                     = 0x80218070
;---Constants--------------------------------------------------
RANDO_LIMIT   = 0
RANDO_BASIC   = 1
RANDO_HARD    = 2
RANDO_GEYSER  = 3
RANDO_DECO    = 4
RANDO_DELETE  = 5
;--------------------------------------------------------------

EXPOSITION:
	;

PROLOGUE:
	mflr	r0
	stwu	sp, -0x0008 (sp)
	stw	r0, 0x0004 (sp)

BODY:
	bl	SKIP_neko_file
		.ascii "NEKO"    ;File Magic
		.short 1         ;Version
		.short 1         ;Command Count
	
		.byte 4          ;Memcpy size	
		.byte 1          ;Destination - ptr levels
		.long 0x80000000 ;Destination - addr or value
		.short 0x0000    ;Destination - ptr level 1
		.byte 0          ;Source - ptr levels
		.long 0x12345678 ;Source - addr or value
		
		.balign 4
	SKIP_neko_file:
	mflr	neko_file
	
	;lwz	r0, 0x0000 (neko_file)
	;lhz	r0, 0x0004 (neko_file)
	lhz	command_count, 0x0006 (neko_file)
	addi	neko_file, neko_file, 8
	
	LOOP_command_count:
		memcpy_size = tempVar0
		lbz	memcpy_size, 0x0000 (neko_file)
		addi	neko_file, neko_file, 1
		
		mr	r3, neko_file
		mr	r4, memcpy_size
		bl	ParseNekoCommand
		mr.	dest_ptr, r3
		mr	neko_file, r4
		
		mr	r3, neko_file
		mr	r4, memcpy_size
		bl	ParseNekoCommand
		mr.	src_ptr, r3
		mr	neko_file, r4
		
		subic.	command_count, command_count, 1
		bne-	LOOP_command_count
		
	LOOP_END_command_count:

EPILOGUE:
	lwz	r0, 0x0004 (sp)
	lwz	sp, 0x0000 (sp)
	mtlr	r0
	blr

HIJACKED:









SUBROUTINES:
	;ParseNekoCommand( HackStream neko_file, int memcpy_size )
	ParseNekoCommand:
		mflr	r0
		stwu	sp, -(0x0008 + (5 * 0x04)) (sp)
		stw	r0, 0x0004 (sp)
		stmw	r27, 0x0008 (sp)
		mr	r31, r3
		mr	r30, r4
		_neko_file   = 31
		_memcpy_size = 30
		_level_count = 29
		_pointer     = 28
		_offset      = 27
		
		lbz	_level_count, 0x0000 (_neko_file)
		addi	_neko_file, _neko_file, 1
		cmpwi	_level_count, 0
		beq-	IS_RAW
		lwz	_pointer, 0x0000 (_neko_file)
		addi	_neko_file, _neko_file, 4
		LOOP_level_count:
			lhz	_offset, 0x0000 (_neko_file)
			extsh	_offset, _offset
			add	_pointer, _pointer, _offset
			addi	_neko_file, _neko_file, 2
			subic.	_level_count, _level_count, 1
			bne-	LOOP_level_count
			b	DONE_DEREFERENCING_DEST
		LOOP_END_level_count:
		IS_RAW:
			mr	_pointer, _neko_file
			add	_neko_file, _neko_file, _memcpy_size
		DONE_DEREFERENCING_DEST:
		mr	r3, _pointer
		mr	r4, _neko_file
		
		
		lmw	r27, 0x0008 (sp)
		lwz	r0, 0x0004 (sp)
		lwz	sp, 0x0000 (sp)
		mtlr r0
		blr
	







	;