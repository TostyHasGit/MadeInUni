// Hochschule Mannheim / Institut für Mikrocomputertechnik und Embedded Systems
//
// Versuch: PIC2  DA-Wandler durch PWM    Dateiname: PIC2_PWM.c
//
// Eine am Analogeingang RA0/AN0 vorgegebene Spannung wird digitalisiert,
// der Wert AnalogIn=xxxx am LCD angezeigt
// und über eine Pulsweitenmodulation am Ausgang RC2/CCP1 ausgegeben.
// Das dort angeschlossene RC-Glied macht daraus wieder eine Analogspannung,
// die am Eingang RE2/AN7 eingelesen und als Istwert AnalogOut=yyyy angezeigt wird.
//
// 08.12.2011 (Poh) Kommentare für LCD (Prototypen in lcd.h)
// 24.05.2011 (Poh) Configuration Bit Settings, Anpassungen für NEUE_PLATINE, Includes im Projektverzeichnis
// 07.06.2020 (Poh) #ifdef Umschaltung zwischen Simulation und Hardware mit LCD
// 30.06.2020 (Poh) umstrukturiert / AD-Wandlungsstart 1x
// 05.12.2023 (Poh) sprintf / char LCDtext1+2
//
// Name/Gruppe:
//

#pragma config OSC=HS,WDT=OFF,LVP=OFF  // HS Oszillator, Watchdog Timer disabled, Low Voltage Programming

#define Simulator        // zum Gebrauch mit Hardware auskommentieren
// Define für LCD des neuen, grünen Demo-Boards:
// #define NEUE_PLATINE  // Achtung: define vor include! Bei altem braunem Demo-Board auskommentieren!
#include "p18f452.h"
#include "lcd.h"         // Enthält alle Prototypen für das LCD
#include "stdio.h"       // für sprintf

void init();

unsigned int x=0;  // Analogwert AN0 (Sollwert Vorgabe durch Poti)
unsigned int y=0;  // Analogwert AN7 (Istwert des PWM-Mittelwerts am RC-Glied)

char LCDtext1[20]=" Analog Out per ";  // LCD Zeile 1: Analogwert AN0 (Poti)  16 Zeichen pro Zeile
char LCDtext2[20]=" PWM through RC ";  // LCD Zeile 2: Analogwert AN7 (Istwert des PWM-Mittelwerts am RC-Glied)


void init()
{
	// IO Ports
	//TRISAbits.TRISA0 = 1;		// RA0 = Eingang(1)
	//TRISEbits.TRISE2 = 1;		// RE2 = Eingang(1)

	// RC2 als Ausgang für PWM
	TRISCbits.TRISC2 = 0;		// RC2/CCP1 = Ausgang(0)

#ifndef Simulator	// LCD-Initialisierung mit Portzuweisung RA<3:1> und RD<3:0>
	lcd_init();		// Alle LCD-Funktionen werden für die Simulation herausgenommen,
	lcd_clear();	// da man sonst hier stecken bleibt.
#endif

	// CCP1 als PWM Modul konfigurieren
	CCP1CON = 0x0F;				// Aus dem Datenblatt CCP1 ist PWM
	PR2 = 0xFF;					// Periodenwert des Timer2 = 255
	CCPR1L = 0x00;				// Duty Cycle = 0

	// Timer 2 Einstellungen
	T2CON = 0x04;				// Vorteiler = 1: 0x04, bei Vorteiler = 16: 0x06 oder 0x07

	// A/D-Umsetzer Einstellungen
	ADCON0 = 0x81;				// 0000 0000 Datenblatt + Aufgabenblatt
	ADCON1 = 0x00;				// 1000 0001 Datenlatt + Aufgabenblatt

}

void main()
{
	init();
	while(1)
	{
		// A/D-Umsetzung durchführen

		// Auf Knopfdruck warten
		//while (PORTAbits.RA4 == 1) {}					// Tastereingabe

		// A/D-Umsetzer starten
		ADCON0bits.GO = 1;

		// Warten bis AD-Umsetzer fertig ist
		while (ADCON0bits.DONE != 0){}
		

		// A/D-Converter: Werteverarbeitung Kanal AN0 oder AN7
		//Analogkanal 0 wurde eingelesen (Poti Sollwert):
		if(!ADCON0bits.CHS2 && !ADCON0bits.CHS1 && !ADCON0bits.CHS0)
		{
			// Analogwert lesen + Berechnung von x (Sollwert)
			x = ADRES >> 6;								// Wir nehmen den aktuellen Wert von Adresse iund schieben es um 6 nach rechts
														// da er aus 10 Bits besteht und linksbündig ist und somit x zu groß wäre
				// Duty Cycle für PWM  einstellen
				CCPR1L = ADRESH;						// Aktualisieren des Duty Cycles
				CCP1CON = (ADRESL >> 2) + 0x0F;			// AD Ergebnis um zwei nach rechts verschieben (da CCP1CON = 00xx xxxx)
														// die 0x0F sind dazu da um es in PWM Modus zu behalten
				

				// Kanal 7 auswählen
				ADCON0 = 0xB9;							// 1011 1001
		}
		//Analogkanal 7 wurde eingelesen (RC-Ausgang Istwert):
		else if(ADCON0bits.CHS2 && ADCON0bits.CHS1 && ADCON0bits.CHS0)
		{
			// Analogwert lesen + Berechnung von y (Istwert)
			y = ADRES >> 6;								// Wir nehmen den aktuellen Wert von Adresse iund schieben es um 6 nach rechts
														// da er aus 10 Bits besteht und linksbündig ist und somit y zu groß wäre



			// String-Ausgabe für LCD: Werte in hex und dezimal:
			// (Um mit dem Logic Analyzer den gesamten im Stimulus vorgegebenen Ablauf mit Haltepunkt bei Nop()
			// sehen zu können, müssen die beiden sprintf-Zeilen auskommentiert und Prescaler 1 gewählt werden.
//			sprintf(LCDtext1, (const far rom char*)"AIn :%#5X %4dd", x,x);
//			sprintf(LCDtext2, (const far rom char*)"AOut:%#5X %4dd", y,y);

				// Kanal 0 auswählen
				ADCON0 = 0x81;							// 1000 0001
		}

#ifndef Simulator
		// Ausgabe an LCD
		ADCON1 = 0x0E;		// RA3:RA1 wieder digital I/O für LCD

		lcd_gotoxy(1,1);		// LCD Zeile 1
		lcd_printf(LCDtext1);
		lcd_gotoxy(2,1);		// LCD Zeile 2
		lcd_printf(LCDtext2);

		ADCON1 = 0x00;		// AAAA AAAA <-- Schrei der Frust

#else	// Simulation: PWM-Periode abwarten + Haltepunkt bei bestimmtem Analogwert ermöglichen
		while(!PIR1bits.TMR2IF);	// Eine Periode der PWM (Timer 2) abwarten
		PIR1bits.TMR2IF=0;			// bis der nächste Analogwert gelesen wird.

		if(y==0x1FA){		// = letzter aus "Stimulus ADRESL pic2pwm.txt" zu lesender AD-Wert
			Nop();		// <-- Hier einen Haltepunkt zum Anhalten nach einem gesamten Stimulus-Durchlauf setzten!
		}					// Ohne Haltepunkt wird die Injaktions-Textdatei zyklisch wiederholt durchgelesen.
#endif
	}  // while(1)
}
