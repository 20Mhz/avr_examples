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
	// ADC
	{ AVR_MCU_VCD_SYMBOL("ADCSRA"), .what = (void*)&UBRR0L, },	
	{ AVR_MCU_VCD_SYMBOL("ADCL"), .what = (void*)&UBRR0L, },	
	{ AVR_MCU_VCD_SYMBOL("ADCH"), .what = (void*)&UBRR0L, },	
	{ AVR_MCU_VCD_SYMBOL("ADC_Start_Conversion"), .mask=(1<<ADSC), .what = (void*)&ADCSRA, },	
};
#endif

// Macros
#define V_BANDGAP 2560
#define BAUD 9600 // 51@8Mhz = 9600 
#define UBRR_MACRO 51 

// Prototypes
int initUSART0STDIO();
int initADC();
int singleADC(short unsigned int, short int*);
int initBT();

// Variables
extern FILE uart_str;

// Functions
int initDevice() {
	initUSART0STDIO(UBRR_MACRO);
	initADC();
	initBT();
	return 0;
}

uint32_t checkSupply(){
	// Monitor Power Supply
	uint32_t miliVolt;
	short unsigned int data0;
	singleADC(0,&data0);
	miliVolt = (V_BANDGAP * (uint32_t )(0x3FF & data0)) / 0x3FF;
	printf("Supply Voltage: %lu mV\n", 4*miliVolt);
	flushUART();
	return miliVolt;
}

int main(void)
{
	int status=0, flash=1;
	char received[256]="(NULL)";
	// Init
	DDRE |= 0xf0;
	initDevice();
	PORTE =  0x30; // Status Report (Initialized)

	#ifdef SIM
	int i;
	for(i=0;i<=10;i++)
	#else
	while(1)
	#endif
	{
		PORTE =  0x20; // Status Report (Not Connected)
		#ifndef SIM
		// Wait for BT Connection
		while(!status)
			status = PING  & (1 << PING0);
		PORTE = 0x10; // Status Report (Connected)

	 	// Flash the led so we know we are alive
		if(flash) PORTE |= 0x80; else PORTE &= ~0x80;	
		_delay_ms(500);
		#endif
		flash ^=1; 

		// Monitor Supply
		checkSupply();
		}
	sleep_cpu();
}
