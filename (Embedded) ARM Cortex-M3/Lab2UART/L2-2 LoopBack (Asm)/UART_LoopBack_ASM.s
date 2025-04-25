	THUMB ; Directive indicating the use of UAL
	AREA Code1, CODE, READONLY, ALIGN=4

	INCLUDE	LPC1768.inc

	IMPORT UART_init
	IMPORT UART_PutChar
	IMPORT UART_GetChar

	EXPORT __main
	ENTRY
__main	PROC
	; Configure UART
	LDR	R0, = 0x00		; UART_PortNum				; 0 or 2
	LDR	R1, = 0xD		; UxDL  = (UxDLM << 8) | (UxDLL)
	; UxDL ist zuständig für die Übertragungsgeschwindigkeit:		Divisor = Systemfrequenz / (16 * Baudrate)
	; Systemfrequenz	= 25 MHz
	; Datenrate 		= 115200 Bit/s
	; Divisor			= 13,5634
	
	
	LDR	R2, =0x1003		; (UxFDR (7:4 MULVAL  3:0 DIVADDVAL) <<8) | UxLCR (UART_Mode) ):
						;	DLAB 0  Set Break 0  Stick Parity 0  Even Parity Select 0  
						;	Parity Enable 0  Number of Stop Bits 0  Word Length Select 11
	LDR	R3, =0x0007		; (UxIER << 8) | UxFCR)		; TX FIFO Reset 1 ; RX FIFO Reset 1 ; FIFO Enable 1

	; R0 = UART_PortNum, R1 = U_DL , R2 = (UxFDR (7:4 MULVAL  3:0 DIVADDVAL) <<8) | UxLCR (UART_Mode),
	; R3 = (INT_ENABLE << 8) | FIFO_Mode
	; 8 Nutzdatenbits pro Sendung, keine Parität, 1 Stopp Bit ; Interrupts ausgeschaltet
	; FIFO aktiv, Trigger level = 1

	MOV R4,R0			; Copy of PortNum (weil R0..R3 Scratch-Register sind, d.h. 
						; in einer gerufenen Funtion verändert werden können!)
	BL 	UART_init
	
Read_String
	MOV R0, R4			; Port Nummer speichern
	BL UART_GetChar		; GetChar aufrufen
	MOVS R1, R0			; Ergebnis von GetChar steht im String
	BMI Read_String		; Default wert ist -1, heißt wenn nichts empfangen dann -1 und lese nochmal
	MOV R0, R4			; Port Nummer zurücksetzen
	BL UART_PutChar		; PutChar aufrufen
	B Read_String
	
	ENDP	; End Procedure
	END