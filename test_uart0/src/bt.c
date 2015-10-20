#include <stdio.h>
#include <avr/io.h>
#define F_CPU 8000000UL  // 8 MHz
#include <util/delay.h>

int initBT(){
	char status[16];
	// BT Reset
	DDRG |= (1<<PIN1);
	PORTG |= (1<<PIN1);
	_delay_ms(500);
	PORTG &= ~(1<<PIN1);
	_delay_ms(500);
	PORTG |= (1<<PIN1);
	// Send Connection setup
	//printf("$$$"); // Expect CMD\n
	////scanf("%4s",status);
	//printf("I,30\n"); // Expect AOK\n
	////scanf("%4s",status);
	//printf("SR,E0F847346113\n"); // Expect AOK\n
	////scanf("%4s",status);
	//printf("C\n"); // Expect AOK\n
	////scanf("%4s",status);
	//printf("---\n");
}
