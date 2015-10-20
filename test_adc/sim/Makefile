SIMAVR_HEADERS = -I ~/Projects/AVR/simavr/simavr/sim -I ~/Projects/AVR/simavr/simavr/ -I ~/Projects/AVR/simavr/include/
SIMAVR_LIBPATH = -L ~/Projects/AVR/simavr/simavr/obj-x86_64-apple-darwin14.5.0/
LIBS = -l simavr -l elf  

run_avr:
	gcc run_avr.c -g -o run_avr  $(SIMAVR_HEADERS) $(SIMAVR_LIBPATH) $(LIBS) 

.PHONY: run_avr
