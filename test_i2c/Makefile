# PROGRAM SETTINGS
SOURCE=./src/main.c ./src/ina219.c ./src/i2c.c ./src/bt.c ./src/timer.c ./src/adc.c ./src/uart_print.c
ELF_FILE=./build/test_i2c.elf
IMAGE_TO_WRITE=./build/test_i2c.hex
IMAGE_TO_READ=./program_on_mem

#AVR-GCC Settings
INCLUDE_PATH=-I/usr/local/CrossPack-AVR-20100115/avr/include/
INCLUDE_SIMAVR=-I/Users/ronaldv/Projects/AVR/simavr/simavr/sim/avr/ -I/Users/ronaldv/Projects/AVR/sim/simavr/include/ -I/Users/ronaldv/Projects/AVR/simavr/simavr/sim/ 
PART=atmega64


# AVR DUDE SETTINGS
AVRDUDE_SETTINGS=-C ~/etc/avrdude.conf -v -c ftdi -p m64 -Pft0 
AVRDUDE_COMMAND_READ= -U flash:r:${IMAGE_TO_READ}:i
AVRDUDE_COMMAND_WRITE= -U flash:w:${IMAGE_TO_WRITE}:i

create_sim_elf:
	avr-gcc -g -std=c99 -D SIM   ${SOURCE} -o ${ELF_FILE} ${INCLUDE_PATH}  ${INCLUDE_SIMAVR} -Wa,-gstabs \
         -mmcu=${PART} -Wl,--undefined=_mmcu,--section-start=.mmcu=0x910000

create_elf:
	avr-gcc -Os  ${SOURCE} -o ${ELF_FILE} ${INCLUDE_PATH}  ${INCLUDE_SIMAVR} -Wa,-gstabs \
         -mmcu=${PART} -Wl,--undefined=_mmcu,--section-start=.mmcu=0x910000 -lm -Wl,-u,vfprintf -lprintf_flt

create_hex: create_elf
	avr-objcopy  -O ihex ${ELF_FILE} ${IMAGE_TO_WRITE} 

clean: 
	rm ${ELF_FILE} ${IMAGE_TO_WRITE} sim/run_avr

all: create_elf create_hex

buildNburn: all write_flash

read_flash: 
	avrdude ${AVRDUDE_SETTINGS} ${AVRDUDE_COMMAND_READ}

write_flash:
	sudo kextunload -bundle-id com.apple.driver.AppleUSBFTDI
	avrdude ${AVRDUDE_SETTINGS} ${AVRDUDE_COMMAND_WRITE}
	sudo sudo kextload -bundle-id com.apple.driver.AppleUSBFTDI

run_avr:
	make -C sim

sim: create_sim_elf run_avr
	./sim/run_avr -v -v -t -m atmega128 -f 8000000 ${ELF_FILE} 

sim_gdb: create_sim_elf
	./sim/run_avr -v -v -g -t -m atmega128 -f 8000000 ${ELF_FILE} 

show_sim:
	gtkwave -f gtkwave_trace.vcd -S init.tcl &
