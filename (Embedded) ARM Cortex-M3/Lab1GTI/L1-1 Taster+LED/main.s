		AREA Byte_Sort, CODE
		EXPORT __main
		INCLUDE LPC1768.inc
		ALIGN        ;;Ensure that the code is aligned
		ENTRY

__main	PROC
	
init
; P2.10 als GPIO INPUT (0) und P02.2 als Output konfigurieren
		LDR R0, =FIO2DIR
		LDR R1, [R0]
		BIC R1, R1, #0x400
		ORR R1, R1, #0xFC			; Bits 2-7 als Ausgang gesetzt (1111 1100)
		STR R1, [R0]
		
		MOV R3, #0x0
		MOV R2, #0x4
		LDR R5, =FIO2PIN
hop
		; Aktueller zustand von FIO2PIN
		LDR R6, [R5]
		TST R6, #0x400
		
		BEQ notSet
		; Überschreiben von FIO2PIN das Bit 3 (P2.2) ein Signal ausgibt
		STR R2, [R5]
		B hop
notSet
		; Überschreiben von FIO2PIN das Bit 3 (P2.2) kein Signal ausgibt
		STR R3, [R5]
		B hop

		endp
		end