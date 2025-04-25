
#include "lpc17xx.h"                              /* LPC17xx definitions    */
#include "adc.h"

/*----------------------------------------------------------------------------
  config ADC
 *----------------------------------------------------------------------------*/
void ADC_Config (void) {

  //Put your code here to perform the following tasks:
  //        1. Enable the AD Converter in the PCONP Register
  LPC_SC->PCONP |= (1 << 12);
	
	//				2. Configure the AD Pin  -->  AD0.5 Pin
	LPC_PINCON->PINSEL3 |= (3 << 30);
	
  //				3. Select AD channel, AD Frequency, enable AD function in the AD module
	//LPC_SC->PCLKSEL0 |= (1 << 24);
	//LPC_SC->PCLKSEL0 &= ~(1 << 25);
	LPC_ADC->ADCR = (1 << 5);	// Channel AD0.5 auswählen
	LPC_ADC->ADCR |= (1 << 8);	// 25 MHz / (1+1)
	LPC_ADC->ADCR |= (1 << 21);	// A/D is operational
	//LPC_ADC->ADGDR |= (1 << 31);	// Done (zur Sicherheit)
	ADC_StartConversion();
}

/*----------------------------------------------------------------------------
  start ADC Conversion
 *----------------------------------------------------------------------------*/
void ADC_StartConversion (void) {
  //Put code to start an AD conversion                    /* start conversion */
  //Please remember that a new conversion must start every 100 ms 
	LPC_ADC->ADCR |= (1 << 24);
	LPC_ADC->ADCR &= ~(1 << 25);
	LPC_ADC->ADCR &= ~(1 << 26);
}



/*********************************************************************************
**                            End Of File
*********************************************************************************/
