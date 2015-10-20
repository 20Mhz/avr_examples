SIMAVR_HEADERS = -I ~/Projects/AVR/simavr/simavr/sim -I ~/Projects/AVR/simavr/simavr/ -I ~/Projects/AVR/simavr/include/ -I/Users/ronaldv/Projects/AVR/simavr/examples/parts
SIMAVR_LIBPATH = -L ~/Projects/AVR/simavr/simavr/obj-x86_64-apple-darwin14.5.0/
LIBS = -l simavr -l elf  
SOURCES=run_avr.c /Users/ronaldv/Projects/AVR/simavr/examples/parts/i2c_eeprom.c
run_avr:
	gcc $(SOURCES) -g -o run_avr  $(SIMAVR_HEADERS) $(SIMAVR_LIBPATH) $(LIBS) 

.PHONY: run_avr
