#include <stdio.h>
#include <avr/io.h>



int printCHAR(char character, FILE *stream)
{
	while ((UCSR0A & (1 << UDRE0)) == 0) {};
	UDR0 = character;
	return 0;
}


FILE uart_str = FDEV_SETUP_STREAM(printCHAR, NULL, _FDEV_SETUP_RW);

int initUSART0STDIO(int baud){
	// Setup UART0
	UCSR0B |= (1 << RXEN0) | (1 << TXEN0);
	UCSR0C |= (1 << UMSEL0) | (1 << UCSZ00) | (1 << UCSZ01);

	UBRR0H = (unsigned char) (baud >> 8) ;
	UBRR0L = (unsigned char) baud;

	stdout = &uart_str;
	printf("UART0 initialized as stdio.\n");
}
