#include <stdint.h>
#include "lpc17xx.h"
#include <stdbool.h>

int counter = 0;
int lauf = 0;
bool toRight = true;
bool on = false;
bool check = false;

void Initialize_SysTick(void) {
    // Timer von 125 ms
    SysTick->CTRL = 0;
    SysTick->LOAD = 1249999;  // Wert der runtergezählt wird (Bei Frequenz von 100 MHz) (=12499999)
    // Formel: Zeit in sek = (Reload-Wert + 1) / Systemtaktfrequenz
    //         Reload Wert = Zeit in Sekunden * Systemtaktfrequenz - 1
    NVIC_SetPriority(SysTick_IRQn, 1);  // Systick Prio auf ganz hoch
    SysTick->VAL = 0;  // Damit er richtig startet
    SysTick->CTRL = 7;  // Enable alles
}

void SysTick_Handler(void) {

    // Wenn gedrückt wird, soll er zählen
    if ((LPC_GPIO2->FIOPIN1 & (1 << 2)) == 0) {
        counter++;
        check = true;
    }

    LPC_GPIO2->FIOCLR0 = 0xFF; // Alle LEDs ausschalten

    // LEDs laufen lassen
    if (on) {
        if (toRight) {
            if (lauf >= 8) {
                lauf = 0;
            }
            LPC_GPIO2->FIOSET0 = (1 << lauf); // LED einschalten
            lauf++;
        } else {
            if (lauf <= -1) {
                lauf = 7;
            }
            LPC_GPIO2->FIOSET0 = (1 << lauf); // LED einschalten
            lauf--;
        }
    }

    if (check && ((LPC_GPIO2->FIOPIN & (1 << 10)) != 0)) {
        // Bei mehr als 8 Interrupts aufrufen = länger als 2 Sekunden
        if (counter >= 16) {  // und GPIO auf nicht gedrückt
            // LEDs an bzw. aus machen
            on = !on;
            counter = 0;
        }
        if (counter >= 1 && counter < 16) {
            // LEDs Laufrichtung ändern
            toRight = !toRight;
            counter = 0;
        }
        check = false;
    }
}

int main(void) {
    /* Init */
    LPC_GPIO2->FIODIR |= 0xFF;      // P2.7 .. P2.0 sind Ausgänge (LEDs)
    LPC_GPIO2->FIOMASK = ~0x1CFF;   // Zugriff auf Port2: Nur die LED-Ausgänge P2.7 .. P2.0 
																		// sind betroffen und der Status von P2.12 .. P2.10 kann gelesen werden.
    Initialize_SysTick();

    /* MainLoop */
    while (1) {}
}