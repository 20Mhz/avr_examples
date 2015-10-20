#include <avr/io.h>
#include <stdio.h>
#include <math.h>

#define F_CPU 8000000UL  // 8 MHz
#include <util/delay.h>

int writeI2C(uint8_t dev_addr, uint8_t pointer, uint16_t data);
int readI2C(uint8_t dev_addr, uint8_t pointer, uint16_t *data);

int configINA219();
int calibration_32V_3A();
int getAmpINA219();

static uint16_t current_div;
static uint16_t power_div;

int configINA219(){
	// Setup from INA219
	// BRNG = Bus Voltage Range (0=16V 1=24V)
	// RST::-::BRNG::PG1::PG0::BADC4::BADC3::BADC2
	// BADC1::SADC4::SADC3::SADC2::SADC1::MODE3::MODE2::MODE1
	// Breakout uses 0.1 Ohm Rshunt
	// At +-320mV FSR -> +-3.2A 
	// Using PGA/8 max 400mA
	//
	// 32V BUS // 1/8 PGA  
	uint16_t conf=0x399F; // To config Reg 
	uint16_t rb_conf; // read-back config

	if(writeI2C(0x40, 0x00, conf)) // Write Conf 16V
		return -1;
	// Verify Conf Register 0x00
	if(readI2C(0x40, 0x00, &rb_conf)) // Read Conf
		return -2;
	if(conf!=rb_conf)
		return -3;

	// Succeed
	return 0;
}

int getAmpINA219(){
	int16_t vshunt;	
	int16_t current;	
	// Read Shunt Register 0x01
	if(readI2C(0x40, 0x01, &vshunt)){ // Read Conf
		printf("Error while Reading Shunt Voltage (0x01).\n");
		return -1;
	}
	printf("Readed Shunt is: %x\n", vshunt);	
	printf("Computed Voltage is: %.2fmV\n", 1.0*abs(vshunt)/0x7D00*320);	

	calibration_32V_3A();
	if(readI2C(0x40, 0x04, &current)){ // Read Current 
		printf("Error while Reading Current (0x04).\n");
		return -2;
	}
	printf("Computed I (0x04) is: %.2fmA\n", (1.0*current)/current_div);	

	return 0;
}


int calibration_32V_3A(){
// 1. Parameters
// VBUS_MAX = 32V
// VSHUNT_MAX=320mV
// RSHUNT = 0.1
// 2. Determine Max current
// AMAX_CURRENT = 320mA / 0.1 Ohm = 3.2A
// 3. Chose desired Max Current
// MAX_CURRENT = 3A
// 4. Calculate possible LSBs and chose one
// MIN_LSB = 3A/(2^15-1) = 3A/3267 = 91.56uA
// MAX_LSB = 3A/2^12 = 3A/4096 = 732.42uA
// CHOSEN_LSB = 100uA
// 5. Compute Calibration Register
// CAL = trunc(0.04096/(CHOSEN_LSB*RSHUNT))
// CAL = 4096
// 6. Calculate Power LSB
// Power_LSB = 20 * VBUS_LSB = 20*4mV = 400uW
// 7. Compute Max Current and shunt voltage before overflow
// MAX_CURRENT_RANGE = CHOSEN_LSB*32767;
// MAX_CURRENT_RANGE = 3.2767A
// Since this is more than 3.2, then 
// MAX_CURRENT_OVERFLOW = 3.2A
// MAX_SHUNT_VOLTAGE = MAX_CURRENT_OVERFLOW*RSHUNT;
// MAX_SHUNT_VOLTAGE = 320mV
// if >= to VSHUNT_MAX then keep VSHUNT_MAX
// 8. Compute Max Power
// MAX_POWER = MAX_CURRENT_OVERFLOW * VBUS_MAX
// MAX_POWER = 3.2 * 320 = 102.4W
// 9. Compute corrected full-scale calibration value based on measured current
// CORR_FULL_SCALE_Cal = trunc(Cal*MEAS_CURRENT/INA219_Current)
//
	uint16_t cal=4096;
	current_div = 10;
	power_div = 2;
	if(writeI2C(0x40, 0x05, cal)) // Write Conf 16V
		return -1;

	return 0;
}

