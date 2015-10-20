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
#include <avr/interrupt.h>

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
	//{ AVR_MCU_VCD_SYMBOL("ADCSRA"), .what = (void*)&UBRR0L, },	
	//{ AVR_MCU_VCD_SYMBOL("ADCL"), .what = (void*)&UBRR0L, },	
	//{ AVR_MCU_VCD_SYMBOL("ADCH"), .what = (void*)&UBRR0L, },	
	{ AVR_MCU_VCD_SYMBOL("ADC_Start_Conversion"), .mask=(1<<ADSC), .what = (void*)&ADCSRA, },	
	{ AVR_MCU_VCD_SYMBOL("PWM"), .mask=(1<<7), .what = (void*)&PORTF, },	
	{ AVR_MCU_VCD_SYMBOL("TWSR"), .what = (void*)&TWSR, },	
	{ AVR_MCU_VCD_SYMBOL("TWINT"), .mask=(1<<TWINT), .what = (void*)&TWCR, },	
	{ AVR_MCU_VCD_SYMBOL("TWEA"), .mask=(1<<TWEA), .what = (void*)&TWCR, },	
	{ AVR_MCU_VCD_SYMBOL("TWSTA"), .mask=(1<<TWSTA), .what = (void*)&TWCR, },	
	{ AVR_MCU_VCD_SYMBOL("TWSTO"), .mask=(1<<TWSTO), .what = (void*)&TWCR, },	
	{ AVR_MCU_VCD_SYMBOL("TWWC"), .mask=(1<<TWWC), .what = (void*)&TWCR, },	
	{ AVR_MCU_VCD_SYMBOL("TWEN"), .mask=(1<<TWEN), .what = (void*)&TWCR, },	
	{ AVR_MCU_VCD_SYMBOL("TWIE"), .mask=(1<<TWIE), .what = (void*)&TWCR, },	

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
void flushUART();
void initTimer();
void initI2C();
int writeI2C(uint8_t dev_addr, uint8_t pointer, uint16_t data);
int readI2C(uint8_t dev_addr, uint8_t pointer, uint16_t *data);
int configINA219();
int calibration_32V_3A();
int getAmpINA219();

// Variables
extern FILE uart_str;

// Interrupts

ISR(TIMER1_COMPA_vect)
{
	DDRF |= 0x80;
	PORTF |= (1<<7); // Set PWM Output
}
ISR(TIMER1_COMPB_vect)
{
	DDRF |= 0x80;
	PORTF &= ~(1<<7); // Clear PWM Output
}
ISR(TWI_vect)
{
}

// Functions
int initDevice() {
	// Setup UART
	initUSART0STDIO(UBRR_MACRO);
	// Setup ADC
	initADC();
	// Setup BT
	initBT();
	// Enable Timer
	 initTimer();
	// Enable I2C
	initI2C();
	// Enable Interrupts
	sei();
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

void main(void)
{
	int status=0, flash=1;
	uint16_t data;
	char received[256]="(NULL)";
	char r;
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
		_delay_ms(5000);
		#endif
		flash ^=1; 

		// Monitor Supply Voltage
		checkSupply();
		//if(flash)
		//		OCR1BL = 18;
		//else 
		//		OCR1BL = 5;

		// Setup from INA219
		// BRNG = Bus Voltage Range (0=16V 1=24V)
		// RST::-::BRNG::PG1::PG0::BADC4::BADC3::BADC2
		// BADC1::SADC4::SADC3::SADC2::SADC1::MODE3::MODE2::MODE1
		// Breakout uses 0.1 Ohm Rshunt
		// At +-320mV FSR -> +-3.2A 
		// Using PGA/8 max 400mA
		if(!configINA219()){
			getAmpINA219();	
		}
		
		//printf("Press M (More) or L (Less): \n");
		//r = getCHAR(stdin);
		//switch(r){
		//	case 'M':
		//		printf("incrementing OCR1BL\n");
		//		OCR1BL += 1; // ~1ms
		//		printf("OCR1BL=%u\n", 0x00FF & OCR1BL);
		//		break;
		//	case 'L':
		//		printf("decrementing OCR1BL\n");
		//		OCR1BL -= 1; // ~1ms
		//		printf("OCR1BL=%u\n", 0x00FF & OCR1BL);
		//		break;
		//	default:
		//		break;
		//}
	}
	sleep_cpu();
}
