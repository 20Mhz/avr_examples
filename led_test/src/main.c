/*
 * main.c
 *
 * Created: 11/17/2011 12:24:08 AM
 *  Author: Ronald Valenzuela
 */ 

#include <avr/io.h>
#define F_CPU 8000000UL  // 8 MHz
//#define F_CPU 14.7456E6
#include <util/delay.h>
#include <avr/sleep.h>

#include "avr_mcu_section.h"
AVR_MCU(F_CPU, "atmega128");

// Monitor registers on VCD trace (simavr feature)
const struct avr_mmcu_vcd_trace_t _mytrace[]  _MMCU_ = {
	{ AVR_MCU_VCD_SYMBOL("DDRE"), .what = (void*)&DDRE, },	
	{ AVR_MCU_VCD_SYMBOL("PORTE"),  .what = (void*)&PORTE, },	
	{ AVR_MCU_VCD_SYMBOL("PORTE4"), .mask = (1 << PIN4), .what = (void*)&PORTE, },	
	{ AVR_MCU_VCD_SYMBOL("PORTE5"), .mask = (1 << PIN5), .what = (void*)&PORTE, },	
	{ AVR_MCU_VCD_SYMBOL("PORTE6"), .mask = (1 << PIN6), .what = (void*)&PORTE, },	
	{ AVR_MCU_VCD_SYMBOL("PORTE7"), .mask = (1 << PIN7), .what = (void*)&PORTE, },	
};

int main(void)
{
	int sw;
	unsigned char value;
	DDRG &= ~(1<<PIN4);
	DDRG = 0x00;
	DDRE |= 0xff;
	value = 0x10;
	#ifdef SIM
	int i;
	for(i=0;i<100;i++)
	#else
	while(1)
	#endif
	{
		PORTE = value & 0xF0;
		
		#ifndef SIM
		_delay_ms(500);
		#endif

		sw = PING  & (1 << PING4);
		if(sw)
				value = (value==0x80) ? 0x10 : value*2;
		else 
				value = (value==0x10) ? 0x80 : value/2;
    }
	sleep_cpu();
}
