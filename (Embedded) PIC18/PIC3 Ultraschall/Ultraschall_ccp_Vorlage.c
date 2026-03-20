// Hochschule Mannheim
// Institut für Embedded Systems
// PIC3_Ultraschall_ccp: Entfernungsmessung per Ultraschall + Echtzeituhr
// 13.12.2023 (Poh) sprintf / char LCDtext1+2

#include <stdio.h>
#include <stdlib.h>

#pragma config OSC=HS,WDT=OFF,LVP=OFF,CCP2MUX=OFF  // HS Oszillator, Watchdog Timer disabled, Low Voltage Programming

#define Simulator        // zum Gebrauch mit Hardware auskommentieren
// Define für LCD des neuen, grünen Demo-Boards:
//#define NEUE_PLATINE  // Achtung: define vor include! Bei altem braunem Demo-Board auskommentieren!

#include "p18f452.h"
#include "lcd.h"

//   LCD-Strings: "1234567890123456"   // 16 Zeichen/Zeile
char LCDtext1[20]=" Interrupt      ";  // LCD Zeile 1: Abstand Ultraschallsensor
char LCDtext2[20]=" Ultraschall    ";  // LCD Zeile 2: Echtzeituhr

unsigned int  Abstand=0; 		// Abstand des Objekts

unsigned char Vorzaehler=0;		// Uhrenvariablen:
unsigned char Stunde=23;
unsigned char Minute=59;
unsigned char Sekunde=0;

// Eigene Variablen
unsigned int captureWert = 0;


void high_prior_InterruptHandler (void);
void low_prior_InterruptHandler (void);


#pragma code high_prior_InterruptVector = 0x08
void high_prior_InterruptVector(void)
{
	_asm
			goto high_prior_InterruptHandler
	_endasm
}


#pragma code low_prior_InterruptVector = 0x18
void low_prior_InterruptVector(void)
{
	_asm
			goto low_prior_InterruptHandler
	_endasm
}


#pragma code init = 0x30
void init (void)
{
#ifndef Simulator	// LCD-Initialisierung mit Portzuweisung RA<3:1> und RD<3:0>
	lcd_init();
	lcd_clear();
#endif

	// weiter siehe Flussdiagramm ...
	TRISD = 0xF0;						// LCD 0 bis 3 auf 0 (Ausgang) 1111 0000 Zeile 1
	TRISA = 0xF1;						// LCD auf Ausgang setzen 1111 0001	Zeile 2

	PORTB = 0x00;						// Port reseten damit kein Trigger schon gesendet wird
	TRISBbits.TRISB1 = 0;				// RB1 (Trigger) auf 0 setzten (per Default auf 1)
	TMR1H = 0;							// Reseten damit kein Überlauf beim Puls hat
	TMR1L = 0;							// Reseten damit kein Überlauf beim Puls hat

	T1CON = 0x80;						// 16 Bit operation, kein Prescaler, No Oszi, External Clock not sync
										// Internal clock FOSC/4, Timer1 STOP
	T3CON = 0x90;						// 1001 0// Hochschule Mannheim
// Institut für Embedded Systems
// PIC3_Ultraschall_ccp: Entfernungsmessung per Ultraschall + Echtzeituhr
// 13.12.2023 (Poh) sprintf / char LCDtext1+2

#include <stdio.h>
#include <stdlib.h>

#pragma config OSC=HS,WDT=OFF,LVP=OFF,CCP2MUX=OFF  // HS Oszillator, Watchdog Timer disabled, Low Voltage Programming

#define Simulator        // zum Gebrauch mit Hardware auskommentieren
// Define für LCD des neuen, grünen Demo-Boards:
//#define NEUE_PLATINE  // Achtung: define vor include! Bei altem braunem Demo-Board auskommentieren!

#include "p18f452.h"
#include "lcd.h"

//   LCD-Strings: "1234567890123456"   // 16 Zeichen/Zeile
char LCDtext1[20]=" Interrupt      ";  // LCD Zeile 1: Abstand Ultraschallsensor
char LCDtext2[20]=" Ultraschall    ";  // LCD Zeile 2: Echtzeituhr

unsigned int  Abstand=0; 		// Abstand des Objekts

unsigned char Vorzaehler=0;		// Uhrenvariablen:
unsigned char Stunde=23;
unsigned char Minute=59;
unsigned char Sekunde=0;

// Eigene Variablen
unsigned int captureWert = 0;


void high_prior_InterruptHandler (void);
void low_prior_InterruptHandler (void);


#pragma code high_prior_InterruptVector = 0x08
void high_prior_InterruptVector(void)
{
	_asm
			goto high_prior_InterruptHandler
	_endasm
}


#pragma code low_prior_InterruptVector = 0x18
void low_prior_InterruptVector(void)
{
	_asm
			goto low_prior_InterruptHandler
	_endasm
}


#pragma code init = 0x30
void init (void)
{
#ifndef Simulator	// LCD-Initialisierung mit Portzuweisung RA<3:1> und RD<3:0>
	lcd_init();
	lcd_clear();
#endif

	// weiter siehe Flussdiagramm ...
	TRISD = 0xF0;						// LCD 0 bis 3 auf 0 (Ausgang) 1111 0000 Zeile 1
	TRISA = 0xF1;						// LCD auf Ausgang setzen 1111 0001	Zeile 2

	PORTB = 0x00;						// Port reseten damit kein Trigger schon gesendet wird
	TRISBbits.TRISB1 = 0;				// RB1 (Trigger) auf 0 setzten (per Default auf 1)
	TMR1H = 0;							// Reseten damit kein Überlauf beim Puls hat
	TMR1L = 0;							// Reseten damit kein Überlauf beim Puls hat

	T1CON = 0x80;						// 16 Bit operation, kein Prescaler, No Oszi, External Clock not sync
										// Internal clock FOSC/4, Timer1 STOP
	T3CON = 0x88;						// 1000 1000 Timer3 (STOP => BIT0 = 0)
	TMR3H = 0x3C;						// 65.535 - 100.000/2 + 1 = 15.536 (Prescale 1/2)
	TMR3L = 0xB0;						//
	CCP2CON = 0x05;						// Capture Mode every rising edge

	IPR2 = 0x01;						// Priority einstellen 0000 0001	Timer3 LOW	CCP2 HIGH
	PIE2 = 0x03;						// Interrupts aktivieren 0000 0011	Timer3 Overflow Interrupt aktiv		CCP2 Interrupt aktiv
	RCON = 0x80;						// Prios werden beachtet
	T1CONbits.TMR1ON = 1;				// 1000 0001 Timer1 START
	T3CONbits.TMR3ON = 1;				// 1000 1101 Timer3 START
	INTCON = 0xC0;						// Globale und Peripheral interupts aktvieren
}


// hochpriorisierte ISR:
// Messung der Dauer des Echoimpulses (an RB3) durch CCP2 Modul
// Steigende Flanke an RB3/CCP2: Capture-Wert speichern
// Fallende Flanke: Differenz mit gespeichertem Wert bilden
#pragma code
#pragma interrupt high_prior_InterruptHandler
void high_prior_InterruptHandler(void)							// Bei rising und falling edge wird interrupt gestartet
{
	// Siehe Flussdiagramm:
	
	if(CCP2CON == 0x05){										// Bei rising edge
		captureWert = CCPR2;									// Wert abfangen/speichern
		PIR1bits.TMR1IF = 0;									// Timer1 Interrupt Flag reseten
		CCP2CONbits.CCP2M0 = 0;									// Flanke fallend
	}
	
	else if (CCP2CONbits.CCP2M0 == 0) {							// Bei falling edge
		
		if(PIR1bits.TMR1IF == 1){								// bei Timer1 Überlauf wird Overflow Interrupt Flag
																// automatisch auf 1 gesetzt
			Abstand = 65535;									// maximal Wert setzen
		}

		else{
			Abstand = (CCPR2 - captureWert) / 58;				// Abstand berechnen
		}

		CCP2CONbits.CCP2M0 = 1;									// Flanke steigend
	}

	PIR2bits.CCP2IF = 0;										// High Prio wieder freischalten
}


// niedrigpriorisierte ISR:
// 100ms-Intervalle von Timer 3 verwenden, um die Abstandsmessung darzustellen.
// Die Intervalle dienen zugleich als Zeitbasis für die Uhr.
#pragma code
#pragma interruptlow low_prior_InterruptHandler
void low_prior_InterruptHandler(void)
{
	// Siehe Flussdiagramm:
	// Startwert für 100ms Intervalle in Timer3 laden
	TMR3H = 0x3C;						// Setzten für einen Startwert damit er 100 ms inkrementiert...
	TMR3L = 0xB0;						// ... bei 1 MHz (65.535 - 50.000 + 1 = 15.536)
	
	if(Abstand != 65535){	// Timer Überlauf?
		sprintf(LCDtext1, (const far rom char*)"Abstand: %3dcm  ", Abstand);  // Abstand anzeigen
	}
	else {
		sprintf(LCDtext1, (const far rom char*)"Abstand: ---    ");  // kein Messwert vorhanden
	}
	
#ifndef Simulator
	lcd_gotoxy(1,1);		// LCD Zeile 1 ausgeben:
	lcd_printf(LCDtext1);	// LCDtext1 Abstand: ...
#endif

	// Zählung der Echtzeit-Uhr
	++Vorzaehler;

	if(Vorzaehler == 10){
		// Jede Sekunde die Uhrzeit anzeigen
    	Sekunde++;
    	if (Sekunde >= 60) {
        	Sekunde = 0;
        	Minute++;
        		if (Minute >= 60) {
            	Minute = 0;
            	Stunde++;
        	}
    	}
		sprintf(LCDtext2, (const far rom char*)"Zeit: %02d:%02d:%02d  ", Stunde, Minute, Sekunde);
		// Vorzaehler = 0;
	}
#ifndef Simulator
	lcd_gotoxy(2,1);					// LCD Zeile 2 ausgeben:
	lcd_printf(LCDtext2);				// LCDtext2 Zeit: ...
#endif

	// weiter siehe Flussdiagramm ...
	if(Stunde >= 24){
		Stunde = 0;
		Minute = 0;
		Sekunde = 0;
	}

	TMR1H = 0;							// Reset damit kein überlauf zwischen steigender und fallender Flanke...
	TMR1L = 0;							// ... wenn überlauf: Objekt gone oder zu weit weg
	LATBbits.LATB1 = 1; 				// RB1 auf HIGH (Pulsstart)
	// Delay von 10 us
   	Nop();
	Nop();
   	Nop();
	Nop();
   	Nop();
   	Nop();
	Nop();
   	Nop();
	Nop();
   	Nop();
    LATBbits.LATB1 = 0; 				// RB1 auf LOW (Pulsende)
	PIR2bits.TMR3IF = 0;				// Interrupt Bit Timer3 reseten

}
void main() {
	init();
	while(1);
}
000 Timer3 (STOP => BIT0 = 0)
	TMR3H = 0x3C;						// 65.535 - 100.000/2 + 1 = 15.536 (Prescale 1/2)
	TMR3L = 0xB0;						//
	CCP2CON = 0x05;						// Capture Mode every rising edge

	IPR2 = 0x01;						// Priority einstellen 0000 0001	Timer3 LOW	CCP2 HIGH
	PIE2 = 0x03;						// Interrupts aktivieren 0000 0011	Timer3 Overflow Interrupt aktiv		CCP2 Interrupt aktiv
	RCON = 0x80;						// Prios werden beachtet
	T1CONbits.TMR1ON = 1;				// 1000 0001 Timer1 START
	T3CONbits.TMR3ON = 1;				// 1000 1101 Timer3 START
	INTCON = 0xC0;						// Globale und Peripheral interupts aktvieren
}


// hochpriorisierte ISR:
// Messung der Dauer des Echoimpulses (an RB3) durch CCP2 Modul
// Steigende Flanke an RB3/CCP2: Capture-Wert speichern
// Fallende Flanke: Differenz mit gespeichertem Wert bilden
#pragma code
#pragma interrupt high_prior_InterruptHandler
void high_prior_InterruptHandler(void)							// Bei rising und falling edge wird interrupt gestartet
{
	// Siehe Flussdiagramm:
	
	if(CCP2CON == 0x05){										// Bei rising edge
		captureWert = CCPR2;									// Wert abfangen/speichern
		PIR1bits.TMR1IF = 0;									// Timer1 Interrupt Flag reseten
		CCP2CONbits.CCP2M0 = 0;									// Flanke fallend
	}
	
	else if (CCP2CONbits.CCP2M0 == 0) {							// Bei falling edge
		
		if(PIR1bits.TMR1IF == 1){								// bei Timer1 Überlauf wird Overflow Interrupt Flag
																// automatisch auf 1 gesetzt
			Abstand = 65535;									// maximal Wert setzen
		}

		else{
			Abstand = (CCPR2 - captureWert) / 58;				// Abstand berechnen
		}

		CCP2CONbits.CCP2M0 = 1;									// Flanke steigend
	}

	PIR2bits.CCP2IF = 0;										// High Prio wieder freischalten
}


// niedrigpriorisierte ISR:
// 100ms-Intervalle von Timer 3 verwenden, um die Abstandsmessung darzustellen.
// Die Intervalle dienen zugleich als Zeitbasis für die Uhr.
#pragma code
#pragma interruptlow low_prior_InterruptHandler
void low_prior_InterruptHandler(void)
{
	// Siehe Flussdiagramm:
	// Startwert für 100ms Intervalle in Timer3 laden
	TMR3H = 0x3C;						// Setzten für einen Startwert damit er 100 ms inkrementiert...
	TMR3L = 0xB0;						// ... bei 1 MHz (65.535 - 50.000 + 1 = 15.536)
	
	if(Abstand != 65535){	// Timer Überlauf?
		sprintf(LCDtext1, (const far rom char*)"Abstand: %3dcm  ", Abstand);  // Abstand anzeigen
	}
	else {
		sprintf(LCDtext1, (const far rom char*)"Abstand: ---    ");  // kein Messwert vorhanden
	}
	
#ifndef Simulator
	lcd_gotoxy(1,1);		// LCD Zeile 1 ausgeben:
	lcd_printf(LCDtext1);	// LCDtext1 Abstand: ...
#endif

	// Zählung der Echtzeit-Uhr
	++Vorzaehler;

	if(Vorzaehler == 10){
		// Jede Sekunde die Uhrzeit anzeigen
    	Sekunde++;
    	if (Sekunde >= 60) {
        	Sekunde = 0;
        	Minute++;
        		if (Minute >= 60) {
            	Minute = 0;
            	Stunde++;
        	}
    	}
		sprintf(LCDtext2, (const far rom char*)"Zeit: %02d:%02d:%02d  ", Stunde, Minute, Sekunde);
		Vorzaehler = 0;
	}
#ifndef Simulator
	lcd_gotoxy(2,1);					// LCD Zeile 2 ausgeben:
	lcd_printf(LCDtext2);				// LCDtext2 Zeit: ...
#endif

	// weiter siehe Flussdiagramm ...
	if(Stunde >= 24){
		Stunde = 0;
		Minute = 0;
		Sekunde = 0;
	}

	TMR1H = 0;							// Reset damit kein überlauf zwischen steigender und fallender Flanke...
	TMR1L = 0;							// ... wenn überlauf: Objekt gone oder zu weit weg
	LATBbits.LATB1 = 1; 				// RB1 auf HIGH (Pulsstart)
	// Delay von 10 us
   	Nop();
	Nop();
   	Nop();
	Nop();
   	Nop();
   	Nop();
	Nop();
   	Nop();
	Nop();
   	Nop();
    LATBbits.LATB1 = 0; 				// RB1 auf LOW (Pulsende)
	PIR2bits.TMR3IF = 0;				// Interrupt Bit Timer3 reseten

}
void main() {
	init();
	while(1);
}
