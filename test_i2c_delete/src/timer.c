// Operation:
// PWM requires 1-2ms Duty Cycle over 20ms Period
// 1024 Prescaler at 8MHz gives 128us tics
// 20ms/128us = 156.25 tics
// We will count to 156 and then clear the timer
// SG90 workd with range 18 tics max 4 tics min
//

#include <avr/io.h>
void initTimer(){
	// Clear Timer on Compare Mode (CTC)
	TCCR1B |= (1<<WGM12); //WGM = 4	
	// Prescaler set to 1024
	TCCR1B |= (5<<CS00);
	OCR1AL = 156; // 20ms
	OCR1BL = 8; // ~1ms
	TIMSK |= (1<<OCIE1A);
	TIMSK |= (1<<OCIE1B);
}
