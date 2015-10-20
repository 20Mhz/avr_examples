/*
 * main.c
 *
 *  Created: 06/05/2012 08:31:08 PM
 *  Author: Ronald Valenzuela
 */
 
#include <stdio.h>
#include <avr/io.h>
#define F_CPU 8000000UL  // 8 MHz
#include <util/delay.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>

#include "usart.h"
#include "avr_mcu_section.h"
AVR_MCU(F_CPU, "atmega128");
// tell simavr to listen to commands written in this (unused) register
AVR_MCU_SIMAVR_COMMAND(&PORTA);

// Monitor registers on VCD trace
const struct avr_mmcu_vcd_trace_t _mytrace[]  _MMCU_ = {
	{ AVR_MCU_VCD_SYMBOL("PORTA"),  .what = (void*)&PORTA, },	
	{ AVR_MCU_VCD_SYMBOL("PORTB"),  .what = (void*)&PORTB, },	
	{ AVR_MCU_VCD_SYMBOL("PINC"),  .what = (void*)&PINC, },	
	//{ AVR_MCU_VCD_SYMBOL("PORTE"),  .what = (void*)&PORTE, },	
	//{ AVR_MCU_VCD_SYMBOL("PORTE"), .mask = (1 << PIN0), .what = (void*)&PORTE, },	
};

ISR(USART0_RX_vect){

	//leemos el dato que está en el buffer y lo guardamos
	unsigned char recepcion = UDR0;
	//PORTE = (recepcion << 4) & 0xF0; 
	PORTE = recepcion;
}

ISR(USART0_TX_vect){

	//leemos el dato que está en el buffer y lo guardamos
	//unsigned char recepcion = UDR0;
	//PORTE = (1 << 4) & 0xF0;
}

// USART
#define FOSC 8000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

// STDIO  

FILE usart_file = FDEV_SETUP_STREAM(USART_putchar, NULL, _FDEV_SETUP_WRITE);

int ubrr= MYUBRR;

volatile uint8_t pressed = 0;

int main(void)
{
 // this tell simavr to put the UART in loopback mode
    PORTA = SIMAVR_CMD_UART_LOOPBACK;
 
	USART_init(MYUBRR);
	stdout = &usart_file;
	sei();
// this tells simavr to start the trace
    //PORTA = SIMAVR_CMD_VCD_START_TRACE;
	DDRB=0xFF;
	DDRC=0x00;
	PORTB = 0x55;
	printf("Hola Master, baud_rate is: %d\n", ubrr); 
	while(1) {
	pressed = (PINC & (1 << PC0)) ? 1:0;
	if (pressed==0) 
		break; 
	}
	_delay_ms(1500);
	printf("Saliendo del simulador\n"); 
	cli();
	sleep_cpu();
}

