# PROGRAM SETTINGS
SOURCE=main.c usart.c 
ELF_FILE=./build/usart_test.elf
IMAGE_TO_WRITE=./build/usart_test.hex
IMAGE_TO_READ=./program_on_mem

#AVR-GCC Settings
INCLUDE_PATH=/usr/local/CrossPack-AVR-20100115/avr/include/
INCLUDE_EXTRA=/Users/ronaldv/Projects/AVR/sim/simavr/include/ 
PART=atmega64


# AVR DUDE SETTINGS
AVRDUDE_SETTINGS=-C ~/etc/avrdude.conf -c ftdi -p m64 -Pft0 
AVRDUDE_COMMAND_READ= -U flash:r:${IMAGE_TO_READ}:i
AVRDUDE_COMMAND_WRITE= -U flash:w:${IMAGE_TO_WRITE}:i

create_elf:
	avr-gcc -Os  ${SOURCE} -o ${ELF_FILE} -I${INCLUDE_PATH}  -I${INCLUDE_EXTRA} -Wa,-gstabs \
		 -mmcu=${PART} -Wl,--undefined=_mmcu,--section-start=.mmcu=0x910000

create_hex: create_elf
	avr-objcopy -j .text -O ihex ${ELF_FILE} ${IMAGE_TO_WRITE} 

clean: 
	rm ${ELF_FILE} ${IMAGE_TO_WRITE}

all: create_elf create_hex 

read_flash: 
	avrdude ${AVRDUDE_SETTINGS} ${AVRDUDE_COMMAND_READ}

write_flash:
	avrdude ${AVRDUDE_SETTINGS} ${AVRDUDE_COMMAND_WRITE}
