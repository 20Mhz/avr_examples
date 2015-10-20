/*
 * main.c
 *
 * Created: 09/24/2015 12:24:08 AM
 *  Author: Ronald Valenzuela
 */ 

#define F_CPU 8000000UL  // 8 MHz
#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/sleep.h>

#include "avr_mcu_section.h"

#ifdef SIM
AVR_MCU(F_CPU, "atmega128");

// Monitor registers on VCD trace (simavr feature)
const struct avr_mmcu_vcd_trace_t _mytrace[]  _MMCU_ = {
	// USART
	{ AVR_MCU_VCD_SYMBOL("UDR0"), .what = (void*)&UDR0, },	
	{ AVR_MCU_VCD_SYMBOL("UCSR0A"), .what = (void*)&UCSR0A, },	
	//{ AVR_MCU_VCD_SYMBOL("UDRE0"), .what = (void*)&UDRE0, },	
	{ AVR_MCU_VCD_SYMBOL("UCSR0B"), .what = (void*)&UCSR0B, },	
	{ AVR_MCU_VCD_SYMBOL("UCSR0C"), .what = (void*)&UCSR0B, },	
	{ AVR_MCU_VCD_SYMBOL("UBRR0H"), .what = (void*)&UBRR0H, },	
	{ AVR_MCU_VCD_SYMBOL("UBRR0L"), .what = (void*)&UBRR0L, },	
};
#endif

#define V_BANDGAP 2560

// Prototypes
int initUSART0STDIO();
int initADC();
int singleADC(short unsigned int, short int*);
int initBT();

// Variables
extern FILE uart_str;

// Functions
int initDevice() {
	#define BAUD 51 // 51@8Mhz = 9600 
	//#define BAUD 3 // 3@8Mhz = 115200 
	initUSART0STDIO(BAUD);
	return 0;
}

int main(void)
{
	int i;
	int flash=1;
	initDevice();
	DDRE |= 0x80;

	#ifdef SIM
	for(i=0;i<=10;i++)
	#else
	while(1)
	#endif
	{
		if (flash) PORTE |= 0x80; else PORTE &= ~0x80;
		#ifndef SIM
		_delay_ms(500);
		#endif
		flash ^=1;
		printf("This is an UART0 test");
	}
	sleep_cpu();
}
