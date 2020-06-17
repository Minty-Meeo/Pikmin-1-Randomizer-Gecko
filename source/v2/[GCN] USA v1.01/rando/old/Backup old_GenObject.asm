#To be inserted at 800dcaf4
;╔════════════════════════════════════════════════════════════╗
;║ Backup old_GenObject                            Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;In function [read__9GeneratorFR18RandomAccessStream 	plugPikiKando.a generator.cpp]
;---Local Vars-------------------------------------------------
Generator = 30
;--------------------------------------------------------------

BODY:
	lwz	r0, 0x0030 (Generator)
	stw	r0, 0x0034	(Generator)

HIJACKED:
	lwz	r0, 0x00EC (sp)