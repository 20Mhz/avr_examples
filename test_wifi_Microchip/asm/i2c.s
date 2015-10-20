	.file	"i2c.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	initI2C
	.type	initI2C, @function
initI2C:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(8)
	sts 112,r24
	ldi r30,lo8(116)
	ldi r31,hi8(116)
	ld r24,Z
	ori r24,lo8(4)
	st Z,r24
/* epilogue start */
	ret
	.size	initI2C, .-initI2C
.global	writeI2C
	.type	writeI2C, @function
writeI2C:
/* prologue: function */
/* frame size = 0 */
	mov r25,r24
	ldi r24,lo8(-92)
	sts 116,r24
.L4:
	lds r24,116
	sbrs r24,7
	rjmp .L4
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(8)
	breq .+2
	rjmp .L5
	lsl r25
	sts 115,r25
	ldi r24,lo8(-123)
	sts 116,r24
.L6:
	lds r24,116
	sbrs r24,7
	rjmp .L6
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(24)
	brne .L5
	sts 115,r22
	ldi r24,lo8(-124)
	sts 116,r24
.L7:
	lds r24,116
	sbrs r24,7
	rjmp .L7
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(40)
	brne .L5
	ldi r18,lo8(8)
	ldi r19,hi8(8)
	ldi r22,lo8(-124)
.L9:
	movw r24,r20
	mov r0,r18
	rjmp 2f
1:	lsr r25
	ror r24
2:	dec r0
	brpl 1b
	sts 115,r24
	sts 116,r22
.L8:
	lds r24,116
	sbrs r24,7
	rjmp .L8
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(40)
	brne .L5
	subi r18,lo8(-(-8))
	sbci r19,hi8(-(-8))
	ldi r24,hi8(-8)
	cpi r18,lo8(-8)
	cpc r19,r24
	brne .L9
	ldi r24,lo8(-108)
	sts 116,r24
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	rjmp .L10
.L5:
	ldi r18,lo8(-1)
	ldi r19,hi8(-1)
.L10:
	movw r24,r18
/* epilogue start */
	ret
	.size	writeI2C, .-writeI2C
.global	readI2C
	.type	readI2C, @function
readI2C:
/* prologue: function */
/* frame size = 0 */
	mov r18,r24
	movw r30,r20
	ldi r24,lo8(-92)
	sts 116,r24
.L18:
	lds r24,116
	sbrs r24,7
	rjmp .L18
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(8)
	breq .+2
	rjmp .L19
	mov r24,r18
	lsl r24
	sts 115,r24
	ldi r24,lo8(-124)
	sts 116,r24
.L20:
	lds r24,116
	sbrs r24,7
	rjmp .L20
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(24)
	breq .+2
	rjmp .L19
	sts 115,r22
	ldi r24,lo8(-124)
	sts 116,r24
.L21:
	lds r24,116
	sbrs r24,7
	rjmp .L21
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(40)
	breq .+2
	rjmp .L19
	ldi r24,lo8(-108)
	sts 116,r24
	ldi r24,lo8(10000)
	ldi r25,hi8(10000)
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/lib/gcc/avr/4.3.3/../../../../avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(-92)
	sts 116,r24
.L22:
	lds r24,116
	sbrs r24,7
	rjmp .L22
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(8)
	brne .L19
	lsl r18
	ori r18,lo8(1)
	sts 115,r18
	ldi r24,lo8(-124)
	sts 116,r24
.L23:
	lds r24,116
	sbrs r24,7
	rjmp .L23
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(64)
	brne .L19
	ldi r24,lo8(-60)
	sts 116,r24
.L24:
	lds r24,116
	sbrs r24,7
	rjmp .L24
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(80)
	brne .L19
	lds r24,115
	mov r19,r24
	ldi r18,lo8(0)
	std Z+1,r19
	st Z,r18
	ldi r24,lo8(-124)
	sts 116,r24
.L25:
	lds r24,116
	sbrs r24,7
	rjmp .L25
	lds r24,113
	andi r24,lo8(-8)
	cpi r24,lo8(88)
	brne .L19
	lds r24,115
	ldi r25,lo8(0)
	or r18,r24
	or r19,r25
	std Z+1,r19
	st Z,r18
	ldi r24,lo8(-108)
	sts 116,r24
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	rjmp .L26
.L19:
	ldi r18,lo8(-1)
	ldi r19,hi8(-1)
.L26:
	movw r24,r18
/* epilogue start */
	ret
	.size	readI2C, .-readI2C
