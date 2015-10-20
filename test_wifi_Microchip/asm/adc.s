	.file	"adc.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	initADC
	.type	initADC, @function
initADC:
/* prologue: function */
/* frame size = 0 */
	sbi 39-32,6
	sbi 39-32,7
	in r24,39-32
	andi r24,lo8(-32)
	out 39-32,r24
	sbi 38-32,7
/* epilogue start */
	ret
	.size	initADC, .-initADC
.global	singleADC
	.type	singleADC, @function
singleADC:
/* prologue: function */
/* frame size = 0 */
	movw r30,r22
	in r25,39-32
	andi r24,lo8(31)
	or r24,r25
	out 39-32,r24
	sbi 38-32,6
	in r24,38-32
	in r18,36-32
	in r20,37-32
	mov r25,r20
	ldi r24,lo8(0)
	ldi r19,lo8(0)
	or r24,r18
	or r25,r19
	std Z+1,r25
	st Z,r24
/* epilogue start */
	ret
	.size	singleADC, .-singleADC
