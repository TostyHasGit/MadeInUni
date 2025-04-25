
/*----------------------------------------------------------------------------
 * Name:    CAN_AD_3_4_main.c
 * Purpose: main File for LPC1768 Microcontrollers        
 * Version: Version 1.0 / 02.05.2019 (KBL, HS-Mannheim)
 *----------------------------------------------------------------------------*/


#include "LPC17xx.h"
#include "adc.h"
#include "GLCD.h"
#include <stdio.h>

extern void  ADC_StartConversion(void);

void Timer1_Config(void);


const uint16_t My_CAN_ID = 0x701;
uint16_t AD_value;
uint8_t  AD_New_Value_Ready;
float AD_Voltage;
char NewLine[21], AD_Val_String[6];
float erg;


int main(void)
{
	GLCD_Init();                                    /* Initialize the GLCD */
	GLCD_Clear(White);                              /* Clear the GLCD */
  GLCD_SetBackColor(Blue);                        /* Set the Back Color */
  GLCD_SetTextColor(White);                       /* Set the Text Color */
	
	GLCD_DisplayString(0, 0, "  EMB Lab3: CAN/ADC ");/* print string to LCD */
	sprintf(NewLine, "   Local ID: %#3x  ", My_CAN_ID);
	GLCD_DisplayString(1, 0, (unsigned char *) NewLine);/* print string to LCD */
	GLCD_DisplayString(2, 0, "Local ADValue:");	
	
	Timer1_Config();
	ADC_Config();
  ADC_StartConversion();
	
	AD_New_Value_Ready = 0;
	
	while (1) 
		{
			if(AD_New_Value_Ready)
				{
					GLCD_SetBackColor(Blue);                        /* Set the Back Color */
					GLCD_SetTextColor(White);                       /* Set the Text Color */
		  		    /*************************************************/
					//Put some code here
					erg = ((float) AD_value / 4095.0) * 3.3;
					sprintf(AD_Val_String, "%.3fV", erg);
					GLCD_DisplayString(2, 14, AD_Val_String);	
					/************************************************/
					AD_New_Value_Ready = 0;
				}
		}
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
	// and let Timer1 generate an Interrupt every 10 ms
}


void TIMER1_IRQHandler (void) 
{  
 // Put some code lines here
	if ((LPC_ADC->ADGDR & (1 << 31)) != 0){
		AD_New_Value_Ready = 1;		
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


