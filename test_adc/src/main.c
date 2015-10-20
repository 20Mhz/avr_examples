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

#define V_BANDGAP 2560

// Prototypes
int initUSART0STDIO();
int printCHAR(char, FILE *);
int initADC();
int singleADC(short unsigned int, short int*);

// Variables
extern FILE uart_str;

// Functions
int initDevice() {
	#define BAUD 51 // 51@8Mhz = 9600 
	initUSART0STDIO(BAUD);
	initADC();
	return 0;
}

int main(void)
{
	uint32_t miliVolt;
	int i;
	short unsigned int data0, data1;
	initDevice();
	#ifdef SIM
	for(i=0;i<=10;i++)
	#else
	while(1)
	#endif
	{
		#ifndef SIM
		_delay_ms(500);
		#endif
		singleADC(0,&data0);
		miliVolt = (V_BANDGAP * (uint32_t )(0x3FF & data0)) / 0x3FF;
		printf("Voltage Measured: %lu mV\n", miliVolt);

		//singleADC(1,&data1);
		//miliVolt = (V_BANDGAP * (uint32_t )(0x3FF & data1)) / 0x3FF;
		//printf("Voltage Measured: %lu mV\n", miliVolt);
		//printf("data0,1: %d, %d\n", data0, data1 );
	}
	sleep_cpu();
}
