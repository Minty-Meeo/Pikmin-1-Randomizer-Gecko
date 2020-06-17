#To be inserted at 8007fa90
;╔════════════════════════════════════════════════════════════╗
;║ Augment PlayerState class                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [__ct__11PlayerStateFv 	plugPikiKando.a playerState.cpp]
;---Tails------------------------------------------------------
;04054e34 386001d0   ; Resize PlayerState class (0x01CC)
;---Compiler Constants-----------------------------------------
permVar0 = 31
permVar1 = 30

tempVar0 = 29
tempVar1 = 28
tempVar2 = 27
tempVar3 = 26
;---Local Vars-------------------------------------------------
PlayerState          = permVar0
rando_ufoparts_array = permVar1
;---Function Pointers------------------------------------------
alloc__6SystemFUl = 0x80047004
getConfigFromIdx__9PelletMgrFi = 0x80098c88
getConfigIndex__9PelletMgrFUl  = 0x80098c48
isUfoPartsID__6PelletFUl       = 0x800953ac
memset                         = 0x80003320
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
;---Constants--------------------------------------------------
ufopart_count = 30
;--------------------------------------------------------------




EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	lis	r12,      alloc__6SystemFUl@h
	ori	r12, r12, alloc__6SystemFUl@l
	mtctr	r12
	li	r3, ( ufopart_count + 3 ) & 0xFFFFFFFC
	bctrl	;-->[alloc__6SystemFUl]
	mr	rando_ufoparts_array, r3
	
	lis	r12,      memset@h
	ori	r12, r12, memset@l
	mtctr	r12
	mr	r3, rando_ufoparts_array
	li	r4, -1
	li	r5, ( ufopart_count + 3 ) & 0xFFFFFFFC
	bctrl	;-->[memset]
	
	success_counter   = tempVar0
	array_index       = tempVar1
	id_from_array     = tempVar2
	curr_possible_id  = tempVar3
	
	li	success_counter, 0
	
	LOOP_generate_30_unique_indexes:
		lis	r12,      randomInt__7NSystemFi@h
		ori	r12, r12, randomInt__7NSystemFi@l
		mtctr	r12
		li	r3, ufopart_count - 1
		bctrl	;-->[randomInt__7NSystemFi]
		addi	curr_possible_id, r3, 19                ;Add 19 to reach the start of ufoparts in pelMgr
		cmpwi	curr_possible_id, 33                    ;After index 33 of pelMgr, 3 unrelated corpses appear
		ble-	0x0008                                  ;Need to skip those if the current index is > 33
		addi	curr_possible_id, curr_possible_id, 3   ;Add 3 to skip some corpses in the middle of the list
		
		li	array_index, 0
		LOOP_array_index:                                                  ;while (1) {
			lbzx	id_from_array, rando_ufoparts_array, array_index   ;   id_from_array = rando_ufoparts_array[array_index];
			cmpw	id_from_array, curr_possible_id                    ;   if (id_from_array == curr_possible_id) {
			beq-	LOOP_generate_30_unique_indexes                    ;      goto LOOP_generate_30_unique_indexes; }
			cmpw	array_index, success_counter                       ;   if (array_index == success_counter ) {
			beq-	LOOP_DONE_array_index                              ;      break; }
			addi	array_index, array_index, 1                        ;   array_index++]
			b	LOOP_array_index                                   ;}
		LOOP_DONE_array_index:
		
		addi	success_counter, success_counter, 1
		stbx	curr_possible_id, rando_ufoparts_array, array_index
		cmpwi	success_counter, ufopart_count
		blt-	LOOP_generate_30_unique_indexes
	LOOP_DONE_generate_30_unique_indexes:

EPILOGUE:
	;

HIJACKED:
	mr	r3, PlayerState














