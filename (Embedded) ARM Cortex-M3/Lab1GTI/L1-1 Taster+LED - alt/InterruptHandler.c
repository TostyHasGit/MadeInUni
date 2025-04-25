#include <LPC17xx.h>  // Header f�r LPC1768

void TIMER0_IRQHandler(void) {
    // Schritt 1: Timer-Interrupt-Flag l�schen
    LPC_TIM0->IR = 1;  // Setzt das Match-Interrupt-Flag f�r MR0 zur�ck

    // Schritt 2: Zustand der LEDs (P2.3 bis P2.7) toggeln
    LPC_GPIO2->FIOPIN ^= (0xF8);  // XOR mit 0xF8, um P2.3 bis P2.7 zu toggeln

    // Schritt 3: Timer stoppen
    LPC_TIM0->TCR = 0;  // Timer stoppen
}
