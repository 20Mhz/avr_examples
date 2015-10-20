/*
 * usart.c
 *
 * Created: 11/19/2011 8:20:25 PM
 *  Author: Ronald Valenzuela
 */ 

#include <avr/io.h>
#include <stdio.h>

void USART_init(unsigned int ubrr) {  
	
	UBRR0H = (unsigned char) (ubrr >> 8);   
	UBRR0L = (unsigned char) ubrr;
	// ASynchronous op
	UCSR0C &= ~(1<<UMSEL0); 
	// No Parity
	UCSR0C &= ~(3 << UPM0);
	// 1 Stop bit
	UCSR0C &= ~(1 << UCSR0B);
	// 8 char bit
	UCSR0C |= (3 << UCSZ00);
	//rise clock receive
	UCSR0C |= (1<<UCPOL0);
	
	//Enabling interrupts
	UCSR0B |= (1<<RXCIE0) | (1<<TXCIE0);
	//Enable Tx Rx
	UCSR0B |= (1<<RXEN0) | (1<<TXEN0);  

	//habilitamos el bit I
	//sei();
}

void USART_Transmit (unsigned int data) {
	// Wait for empty transmit buffer
	while(!(UCSR0A & (1<<UDRE0))) ;
	 
	UDR0 = data;
}

int USART_putchar(char c, FILE *stream){
	if(c == '\n')
		USART_putchar('\r',stream);
	//loop_until_bit_is_set(UCSR0A, UDRE0);	
	while(!(UCSR0A & (1<<UDRE0))) ;
	UDR0 = c;
	return 0;
} 