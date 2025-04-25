
#include "LPC17xx.h"
#include "adc.h"

void Timer1_Config(void);
uint16_t AD_value;

int main(void)
{
	//SystemInit();
	Timer1_Config();
	ADC_Config();

    while (1); 
}

void Timer1_Config(void)
{
	
	LPC_SC->PCONP |= (1<<2);//enable Timer1
	LPC_TIM1->PR = 25000-1;
	LPC_TIM1->MCR = 3;
	LPC_TIM1->MR0 = 10-1;
	
	NVIC_EnableIRQ(TIMER1_IRQn);
	NVIC_SetPriority(TIMER1_IRQn, 1);
	LPC_TIM1->TCR = 1;          //start Timer 0
	
	
	//Put some code in order to enable Timer1 interrupt with priority level 1
	// and let Timer1 generate an Interrupt every 100 ms
}

void TIMER1_IRQHandler (void) 
{  
 // Put some code lines here
	if ((LPC_ADC->ADGDR & (1 << 31)) != 0){
		//Read and store AD value
		AD_value	= LPC_ADC->ADGDR;						// 0b0 1111 1111 1111 0000
		AD_value = AD_value & 0xFFF0;
		AD_value = (AD_value >> 4);
		
		//Start new AD conversion
		ADC_StartConversion ();
	}
 //Clear timer1 interrupt
  LPC_TIM1->IR = 1;
}

/************************************ EOF ***********************************/


