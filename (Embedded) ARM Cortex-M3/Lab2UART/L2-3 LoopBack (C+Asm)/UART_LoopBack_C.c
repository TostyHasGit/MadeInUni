
#include <stdio.h>
#include <LPC17xx.H>

// Put some lines here  e.g. DEFINE ...

unsigned char MyChar;
unsigned int PortNum, UDL, FDRvalue, UART_mode, IntEnableValue, FIFO_mode, Temp;
// PortNum = Port Number excepted to be 0 or 2 for the the LandTiger EVB
// UDL = U_DLM*256 + U_DLL to set the data rate
// FDRvalue  = Content of the register UxFDR (Fractional Divider)
// UART_mode = Content of the register UxLCR without the DLAB bit
// IntEnableValue = Content of the register UxIER
// FIFO_mode = Content of the register UxFCR (FIFO Control Register)



extern void UART_init(int UART_PortNum, int UxDL, int UxFDR_LCR, int UxIER_FCR);
extern void UART_PutChar(int UART_PortNum, char PutChar);
extern int UART_GetChar(int UART_PortNum);

int main(void){
	PortNum = 0;
	UDL = 13;						//	Divisor
	FDRvalue = 0x10;		//	+4,33% -> 120192,31
	UART_mode = 0x03;		//	DLAB 0  Set Break 0  	Stick Parity 0  	Even Parity Select 0  
											//	Parity Enable 0  			Number of Stop Bits 0  	Word Length Select 11
	IntEnableValue = 0; //	RBR 0		THRE 0				RX Line Status 0	
											//	3-7 Reserved					ABEOIntEn 0				ABTOIntEn	0			10-31 Reserved
	FIFO_mode = 0x03;		//	Reset RX FIFO, TX FIFO und enable FIFO
		
	// Port, Divisor, FDR und LCR, IER und FCR
	UART_init(PortNum, UDL, (FDRvalue << 8) + (UART_mode), (IntEnableValue << 8) + FIFO_mode);

	while(1){
		MyChar = UART_GetChar(PortNum);
		if (MyChar != 0xFF){
			UART_PutChar(PortNum, MyChar);
		}
	}
}