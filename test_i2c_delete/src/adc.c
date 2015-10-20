#include <avr/io.h>

int initADC(){
	// set Internal Bandgap as Vref
	ADMUX |= (1 << REFS0);
	ADMUX |= (1 << REFS1);
	ADMUX &= 0xE0; // MUX[4:0] = 0 means Single ended ADC0 Selected
	// Enable ADC
	ADCSRA |= (1 << ADEN);
}

int singleADC(short unsigned int channel, short unsigned int *data){

	ADMUX |= (0x1F & channel); // MUX[4:0] = 0 means Single ended ADC0 Selected
	ADCSRA |= (1<< ADSC); // Trigger single conversion
	while (ADCSRA & (1 << ADSC) == 0) {}; // Wait for data

	// Make sure you read ADCL first to lock conversion
	*data = ADCL & 0xFF;
	*data |= ADCH << 8 ;

}
