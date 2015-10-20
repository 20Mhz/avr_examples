	.file	"timer.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	initTimer
	.type	initTimer, @function
initTimer:
/* prologue: function */
/* frame size = 0 */
	in r24,78-32
	ori r24,lo8(8)
	out 78-32,r24
	in r24,78-32
	ori r24,lo8(5)
	out 78-32,r24
	ldi r24,lo8(-100)
	out 74-32,r24
	ldi r24,lo8(8)
	out 72-32,r24
	in r24,87-32
	ori r24,lo8(16)
	out 87-32,r24
	in r24,87-32
	ori r24,lo8(8)
	out 87-32,r24
/* epilogue start */
	ret
	.size	initTimer, .-initTimer
