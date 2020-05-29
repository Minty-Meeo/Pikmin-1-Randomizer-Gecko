#To be inserted at 8011b49c
;╔════════════════════════════════════════════════════════════╗
;║ GenObhjectTeki to GenObjectRandoTeki            Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [doRead__13GenObjectTekiFR18RandomAccessStream]
; NO STACK FRAME!!!
; r30 is pointer to the GEN Object

;--------------------------------------------------------------------------------
LIMIT = 0   ;Tekis with low HP.  Often spawned in corridors or in circ GenAreas
BASIC = 1   ;Tekis with much HP.  A few may be littered around a map.
BOSS = 2    ;Tekis with much HP.  Often a setpiece, considered a "Sub-Boss".
GEYSER = 3
WEIRD = 0 ;Tekis that would be WEIRD to be spawned in vanilla.
;--------------------------------------------------------------------------------

bl	SKIP
RANDOTEKI_TABLE:
	.byte BASIC   ;00 frog      Yellow Wollywog
	.byte WEIRD   ;01 iwagen    Iwagen
	.byte WEIRD   ;02 iwagon    Rolling Boulder
	.byte LIMIT   ;03 chappy    Dwarf Bulborb
	.byte BASIC   ;04 swallow   Spotty Bulborb
	.byte LIMIT   ;05 mizigen   Honeywisps Generator
	.byte LIMIT   ;06 qurione   Lone Honeywisp (invalid)
	.byte LIMIT   ;07 palm      Pellet Posy
	.byte BASIC   ;08 collec    Breadbug
	.byte BOSS    ;09 kinoko    Puffstool
	.byte BOSS    ;0A shell     Pearly Clamclamp
	.byte BASIC   ;0B napkid    Snitchbug
	.byte BASIC   ;0C hollec    Breadbug Nest
	.byte WEIRD   ;0D pearl     Lone Pearl (invalid)
	.byte WEIRD   ;0E rocpe     Lone Rocket Pearl (invalid)
	.byte BASIC   ;0F tank      Fiery Blowhog
	.byte BASIC   ;10 mar       Puffy Blowhog
	.byte BOSS    ;11 beatle    Armored Cannon Beetle
	.byte LIMIT   ;12 kabekuiA  Female Sheargrub
	.byte LIMIT   ;13 kabekuiB  Male Sheargrub
	.byte LIMIT   ;14 kabekuiC  Shearwig
	.byte BOSS    ;15 tamago    Giant Egg
	.byte BOSS    ;16 dororo    Smoky Progg
	.byte LIMIT   ;17 hibaA     Fire Geyser
	.byte BOSS    ;18 miurin    Mamuta
	.byte LIMIT   ;19 otama     Wogpole
	.byte WEIRD   ;1A usuba     Usuba (invalid)
	.byte WEIRD   ;1B yamash3   (invalid)
	.byte WEIRD   ;1C yamash4   (invalid)
	.byte WEIRD   ;1D yamash5   (invalid)
	.byte LIMIT   ;1E namazu    Water Dumple
	.byte LIMIT   ;1F chappb    Dwarf Bulbear
	.byte BASIC   ;20 swallob   Spotty Bulbear
	.byte BASIC   ;21 frow      White Wollywog
	.byte WEIRD   ;22 nakata1   (invalid)
	.byte 0 ;padding

SKIP:
	lwz	r3, 0x001C (r30)
	mflr	r12
	lbzx	r3, r12, r3
	stw	r3, 0x001C (r30)

HIJACKED:
	lwz	r0, 0x001C (sp)




