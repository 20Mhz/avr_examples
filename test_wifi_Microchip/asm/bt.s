	.file	"bt.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	initBT
	.type	initBT, @function
initBT:
/* prologue: function */
/* frame size = 0 */
	lds r24,100
	ori r24,lo8(2)
	sts 100,r24
	lds r24,101
	ori r24,lo8(2)
	sts 101,r24
	ldi r24,lo8(1000)
	ldi r25,hi8(1000)
	ldi r18,lo8(200)
	ldi r19,hi8(200)
.L2:
	movw r30,r18
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/lib/gcc/avr/4.3.3/../../../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	sbiw r24,1
	brne .L2
	lds r24,101
	andi r24,lo8(-3)
	sts 101,r24
	ldi r24,lo8(1000)
	ldi r25,hi8(1000)
	ldi r18,lo8(200)
	ldi r19,hi8(200)
.L3:
	movw r30,r18
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/lib/gcc/avr/4.3.3/../../../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	sbiw r24,1
	brne .L3
	lds r24,101
	ori r24,lo8(2)
	sts 101,r24
	ldi r24,lo8(1000)
	ldi r25,hi8(1000)
	ldi r18,lo8(200)
	ldi r19,hi8(200)
.L4:
	movw r30,r18
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/lib/gcc/avr/4.3.3/../../../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	sbiw r24,1
	brne .L4
/* epilogue start */
	ret
	.size	initBT, .-initBT
