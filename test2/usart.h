#ifndef USART_HEADER
#define USART_HEADER


	void USART_init(unsigned int);
	int  USART_putchar(char c, FILE *stream);
	void USART_Transmit (unsigned int data);
	
#endif 