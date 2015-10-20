#include <avr/io.h>
//
// Notes to self...
// I should have error codes since debugging 
// with printf takes too much time
void initI2C(){
	TWBR = 8; // for 100kHz@8Mhz :: TWPS = 1
	// Enable ack bit
	//TWCR |= (1<<TWEA);
	//// Enable START condition
	//TWCR |= (1<<TWSTA);
	//// Enable STOP condition
	//TWCR |= (1<<TWSTO);
	// Enable TWI
	TWCR |= (1<<TWEN);
	// Enable Interrupt
	//TWCR |= (1<<TWIE);

}

// Communication based on Datasheet Example
//
#define TWI_START 0x08
#define TWI_MTX_SLAW_ACK 0x18
#define TWI_MTX_SLAW_NACK 0x20
#define TWI_MTX_SLAR_ACK 0x40
#define TWI_MTX_DATAW_ACK 0x28
#define TWI_MTX_DATAR_ACK 0x50
#define TWI_MTX_DATAR_NACK 0x58

#define F_CPU 8000000UL  // 8 MHz
#include <util/delay.h>
int writeI2C(uint8_t dev_addr, uint8_t pointer, uint16_t data){
	int i;
	// START 
	TWCR = (1<<TWINT) | (1<<TWSTA) | (1<<TWEN) ; // TWINT starts operation
	while(!(TWCR & (1<<TWINT))); // Wait for START to be transmitted
	//printf("address returned state is: 0x%x\n", 0xFF & (TWSR & 0xF8));
	if((TWSR & 0xF8) != TWI_START) // check status
			return -1;

	// Transmit Address
	TWDR = (dev_addr << 1) ; // SLA+W	
	TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWIE) ; // Send SLA+W
	while(!(TWCR & (1<<TWINT))); // Waint for SLA+W to be transmitted
	//printf("address returned state is: 0x%x\n", 0xFF & (TWSR & 0xF8));
	if((TWSR & 0xF8) != TWI_MTX_SLAW_ACK) // check status
			return -1;

    // Set pointer	
	TWDR = pointer; 
	TWCR = (1<<TWINT) | (1<<TWEN); // Send DATA+W
	while(!(TWCR & (1<<TWINT))); // Waint for SLA+W to be transmitted
	//printf("write pointer state is: 0x%x\n", 0xFF & (TWSR & 0xF8));
	if((TWSR & 0xF8) != TWI_MTX_DATAW_ACK) // check status
			return -1;

	// Write Data x2
	for(i=1;i>=0;i--){
		TWDR = 0xFF & (data >> 8*i); 
		TWCR = (1<<TWINT) | (1<<TWEN); // Send DATA+W
		while(!(TWCR & (1<<TWINT))); // Waint for SLA+W to be transmitted
		if((TWSR & 0xF8) != TWI_MTX_DATAW_ACK) // check status
				return -1;
	}
		//printf("write data state is: 0x%x\n", 0xFF & (TWSR & 0xF8));

	// Trasmit STOP
	TWCR = (1<<TWINT | (1<<TWSTO) | (1<<TWEN)); // TWINT starts operation

	return 0;
}

int readI2C(uint8_t dev_addr, uint8_t pointer, uint16_t *data){
	int i;
	// START 
	TWCR = (1<<TWINT | (1<<TWSTA) | (1<<TWEN)); // TWINT starts operation
	while(!(TWCR & (1<<TWINT))); // Waint for START to be transmitted
	if((TWSR & 0xF8) != TWI_START) // check status
			return -1;

	// Transmit Address
	TWDR = (dev_addr << 1)   ; // SLA+W For setting pointer	
	TWCR = (1<<TWINT) | (1<<TWEN); // Send SLA+R
	while(!(TWCR & (1<<TWINT))); // Waint for SLA+W to be transmitted
	if((TWSR & 0xF8) != TWI_MTX_SLAW_ACK) // check status
			return -1;

    // Set pointer	
	TWDR = pointer; 
	TWCR = (1<<TWINT) | (1<<TWEN); // Send DATA+W
	while(!(TWCR & (1<<TWINT))); // Waint for SLA+W to be transmitted
	if((TWSR & 0xF8) != TWI_MTX_DATAW_ACK) // check status
			return -1;
	// Trasmit STOP
	TWCR = (1<<TWINT | (1<<TWSTO) | (1<<TWEN)); // TWINT starts operation

	 //printf("Pointer set\n");
	_delay_ms(5);

	// START 
	TWCR = (1<<TWINT | (1<<TWSTA) | (1<<TWEN)); // TWINT starts operation
	while(!(TWCR & (1<<TWINT))); // Waint for START to be transmitted
	if((TWSR & 0xF8) != TWI_START) // check status
			return -1;
	// Transmit Address
	TWDR = (dev_addr << 1) | 1  ; // SLA+R For Reading 
	TWCR = (1<<TWINT) | (1<<TWEN); // Send SLA+R
	while(!(TWCR & (1<<TWINT))); // Waint for SLA+W to be transmitted
	//printf("address returned state is: 0x%x\n", 0xFF & (TWSR & 0xF8));
	if((TWSR & 0xF8) != TWI_MTX_SLAR_ACK) // check status
			return -1;


	// Read Data x2
	TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWEA); // Get DATA
	while(!(TWCR & (1<<TWINT))); // Waint for data to be received
	//printf("Data returned state is: 0x%x\n", 0xFF & (TWSR & 0xF8));
	if((TWSR & 0xF8) != TWI_MTX_DATAR_ACK) // check status
			return -1;
	*data =  (TWDR<<8) & 0xFF00; 
	TWCR = (1<<TWINT) | (1<<TWEN); // Get DATA
	while(!(TWCR & (1<<TWINT))); // Waint for data to be received
		if((TWSR & 0xF8) != TWI_MTX_DATAR_NACK) // check status
			return -1;
	*data |=  TWDR; 
	

	// Trasmit STOP
	TWCR = (1<<TWINT | (1<<TWSTO) | (1<<TWEN)); // TWINT starts operation

	return 0;
}
