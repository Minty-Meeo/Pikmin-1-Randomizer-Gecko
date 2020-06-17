#To be inserted at 800dcc74
;╔════════════════════════════════════════════════════════════╗
;║ Restore old_GenObject                           Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;[write__9GeneratorFR18RandomAccessStream 	plugPikiKando.a generator.cpp]
;---Local Vars-------------------------------------------------
Generator = 30
;--------------------------------------------------------------

BODY:
	lwz	r0, 0x0034 (Generator)
	stw	r0, 0x0030	(Generator)

HIJACKED:
	stw	r29, 0x008C (sp)