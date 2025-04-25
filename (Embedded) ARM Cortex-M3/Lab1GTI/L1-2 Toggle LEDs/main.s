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
		MOV R2, #0xFC
		LDR R5, =FIO2PIN
		
hop
		; Für Zeitschleife
		LDR R4, =2500000
		; Aktueller zustand von FIO2PIN
		LDR R6, [R5]
		TST R6, #0x400
		BEQ notSet
		B hop
		
notSet
		; Prellen vermeiden
		SUBS R4, R4, #1
		BNE notSet
		; Warten bis losgelassen wird
		LDR R6, [R5]
		TST R6, #0x400
		BNE set
		B hop

set
		; Toggeln von FIO2PIN das Bit 3-7 (P2.2 - P2.8)
		EOR R6, R6, #0xFC
		STR R6, [R5]
		B hop

		endp
		end