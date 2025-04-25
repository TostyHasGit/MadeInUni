		AREA Byte_Sort, CODE
		EXPORT __main
		INCLUDE LPC1768.inc
		ALIGN        ;;Ensure that the code is aligned
		ENTRY

__main	PROC



; P2.10 als GPIO Input (0) und P2.2 als Output konfigurieren
		LDR R1, =FIO2DIR
		LDR R4, [R1]
		BIC R4, R4, #0x200
		ORR R4, R4, #0xFC		; Bits 2-7 als Ausgang gesetzt (1111 1100)
		STR R4, [R1]
		
; Timer reseten
		LDR R0, =T0TCR
		MOV R0, #0x2
		
; Vergleichswert 100 ms
		LDR R0, =T0MR0
		LDR R1, =0xF4240
		STR R1, [R0]
		
; Interrupt aufruf (Reset und Interrupt)
		LDR R0, =T0MCR
		MOV R1, #0x3
		STR R1, [R0]

; Interrupt verarbeitung (höhere Ebene)
;		LDR R0, =NVIC_ISER_0
;		MOV R1, #0x1
;		STR R1, [R0]

; Ausgang an Pins reseten
		LDR R0, =FIO2CLR
		MOV R1, #0xFF
		STR R1, [R0]

Hop
; Pins testen
		LDR R1, =FIO2PIN
		LDR R4, [R1]
		TST R4, #0x200
		BLEQ Bit10_set
		BIC R4, R4, #0x4
		B Hop

Bit10_set
; P2.2 einschalten, solange der Taster gedrückt ist
        LDR R0, =FIO2SET
        MOV R1, #0x4              ; P2.2 einschalten
        STR R1, [R0]

; Timer starten für Entprellung
        LDR R0, =T0TCR
        MOV R1, #0x1              ; Timer starten
        STR R1, [R0]

; Warten, bis Timer-Interrupt eintritt
        B Hop
		ENDP
		END
