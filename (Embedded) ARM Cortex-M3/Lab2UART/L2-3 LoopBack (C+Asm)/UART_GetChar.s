	THUMB ; Directive indicating the use of UAL
	AREA Code1, CODE, READONLY, ALIGN=4

	INCLUDE	LPC1768.inc
	EXPORT 	UART_GetChar
	;Assumption R0 = UART_PortNum (0 or 2 for LandTiger EVB)

UART_GetChar	PROC
;LSR: RDR lesen
;wenn gesetzt, RBR lesen

	STMFD	SP!,{R4,R5, LR}
	CBZ 	R0, UART_Port0	; Check if UART Port 0 or Port 2 selected

UART_Port2
	LDR		R3,=U2LSR	; UART Port 2 selected
	LDR		R4,=U2RBR
	B Reay

UART_Port0
	LDR		R3,=U0LSR	; UART Port 0 selected
	LDR		R4,=U0RBR
Reay
	LDR		R5, [R3]
	ANDS	R5, R5, #0x1
	BNE		RDR_set

	; Wenn RDR nicht gesetzt
	MOV		R0, #0x0
	SUBW	R0, #1
	B UART_Rx_Done
	
RDR_set
	; Zeichen lesen und in R0 schreiben
	LDRB R0, [R4]
	
	
UART_Rx_Done
	LDMFD	SP!,{R4,R5, PC}

	ENDP		; End Procedure

	END