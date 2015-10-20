#include <stdio.h>
#include <avr/io.h>
#define F_CPU 8000000UL  // 8 MHz
#include <util/delay.h>



int printCHAR(char character, FILE *stream)
{
	if (character == '\n') {
        printCHAR('\r', stream);
    }
	while ((UCSR0A & (1 << UDRE0)) == 0) {};
	UDR0 = character;
	return 0;
}

int getCHAR(FILE *stream){
	uint8_t c;
	while ((UCSR0A & (1 << RXC0)) == 0) {};
	c = UDR0;
	return c;
}

void flushUART(){
	unsigned char dummy;
	while (UCSR0A & (1<<RXC0)) dummy = UDR0;
}

FILE uart_str = FDEV_SETUP_STREAM(printCHAR, getCHAR, _FDEV_SETUP_RW);
//FILE uart_str = FDEV_SETUP_STREAM(printCHAR, NULL, _FDEV_SETUP_RW);

int initUSART0STDIO(int baud){
	// Setup UART0
	UCSR0B |= (1 << RXEN0) | (1 << TXEN0);
	UCSR0B &= ~(1 << RXCIE); // Disable interrupt
	// ASync
	UCSR0C &= ~(1 << UMSEL0); 
	// 8-bit
	UCSR0C |=  (0x3 << UCSZ00) | (1 << UCPOL0);
	//baud = 0xCF;
	UBRR0H = (unsigned char) (baud >> 8) ;
	UBRR0L = (unsigned char) baud;

	stdout = &uart_str;
	stdin = &uart_str;
	flushUART();
	printf("UART0 initialized as stdio.");
}
