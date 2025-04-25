; Dateiname:
; Beschreibung:
;
;
; Entwickler:
; Version: 1.0    Datum:

	list p=18f452		; Select Processor for Assembler
#include <p18f452.inc>	; Registers / ASM Include File in Search Path  C:\Program Files (x86)\Microchip\MPASM Suite

	config OSC=HS,WDT=OFF,LVP=OFF ;Configuration Bits - defined in include file
	; HS Oszillator, Watchdog Timer disabled, Low Voltage Programming

BANK0 EQU 0x000
BANK1 EQU 0x100
BANK2 EQU 0x200
BANK3 EQU 0x300
BANK4 EQU 0x400
BANK5 EQU 0x500

;//***** Variables *****
;//Bank0
;//Bank1
;//Bank2
;//Bank4
;//Bank5

;//***** Vector Table *****
	ORG 0x00
ResetVect
	GOTO Init

	ORG 0x08
IntVectHigh
;//No Interrupts Enabled

	ORG 0x18
IntVectLow
;//No Interrupts Enabled

;//***** Main Program *****
	ORG 0x30
;//Initialisation Code
Init
;// Taster
	;CLRF PORTA, 0
	MOVLW 0xff
	MOVWF TRISA, 0

;// LEDs
	;CLRF PORTB, 0
	MOVLW 0xf0
	MOVWF TRISB, 0

;// Lautsprecher
	;CLRF PORTC, 0
	MOVLW 0xfb
	MOVWF TRISC, 0

;// AD Wandler
	MOVLW 0x0e
	MOVWF ADCON1, 0

	MOVLW 0x81
	MOVWF ADCON0, 0

;//Main Application Code
MainLoop
	BTFSC	PORTA, RA4, 0			;// Auf Taster warten (BTFSC Bit Test File, skip if clear)
	BRA		MainLoop
	BSF		ADCON0, GO, 0			;// Lesen Starten

LoopA
	BTFSC 	ADCON0, DONE, 0
	BRA		LoopA					;// Warten bis Lesen beendet

;// LEDs
	MOVFF	ADRESH, 0x20			;// Ergebnis speichern
	SWAPF 	ADRESH					;// AX zu XA ändern damit man es auf die LEDs schicken kann
	MOVFF	ADRESH, PORTB			;// LEDs werden benachrichtigt
	BTG		PORTC, RC2				;// Sound wird ausgegeben

LoopB
	DECFSZ	0x20, 1, 0				;// Random Zeitintervall für die Frequenz
	BRA 	LoopB
	BRA		MainLoop
	END
