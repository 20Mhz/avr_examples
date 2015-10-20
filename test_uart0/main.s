	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	initDevice
	.type	initDevice, @function
initDevice:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r24,lo8(51)
	ldi r25,0
	call initUSART0STDIO
	ldi r24,0
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	initDevice, .-initDevice
.global	__mulsf3
.global	__ltsf2
.global	__gtsf2
.global	__fixunssfsi
	.section	.rodata
.LC0:
	.string	"This is an UART0 test"
	.text
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,16
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 16 */
/* stack size = 18 */
.L__stack_usage = 18
	ldi r24,lo8(1)
	ldi r25,0
	std Y+2,r25
	std Y+1,r24
	call initDevice
	ldi r24,lo8(34)
	ldi r25,0
	ldi r18,lo8(34)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(-128)
	movw r30,r24
	st Z,r18
.L14:
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	breq .L4
	ldi r24,lo8(35)
	ldi r25,0
	ldi r18,lo8(35)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(-128)
	movw r30,r24
	st Z,r18
	rjmp .L5
.L4:
	ldi r24,lo8(35)
	ldi r25,0
	ldi r18,lo8(35)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	andi r18,lo8(127)
	movw r30,r24
	st Z,r18
.L5:
	ldi r24,0
	ldi r25,0
	ldi r26,lo8(-6)
	ldi r27,lo8(67)
	std Y+3,r24
	std Y+4,r25
	std Y+5,r26
	std Y+6,r27
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(-6)
	ldi r21,lo8(68)
	ldd r22,Y+3
	ldd r23,Y+4
	ldd r24,Y+5
	ldd r25,Y+6
	call __mulsf3
	movw r26,r24
	movw r24,r22
	std Y+7,r24
	std Y+8,r25
	std Y+9,r26
	std Y+10,r27
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(-128)
	ldi r21,lo8(63)
	ldd r22,Y+7
	ldd r23,Y+8
	ldd r24,Y+9
	ldd r25,Y+10
	call __ltsf2
	tst r24
	brge .L17
	ldi r24,lo8(1)
	ldi r25,0
	std Y+12,r25
	std Y+11,r24
	rjmp .L8
.L17:
	ldi r18,0
	ldi r19,lo8(-1)
	ldi r20,lo8(127)
	ldi r21,lo8(71)
	ldd r22,Y+7
	ldd r23,Y+8
	ldd r24,Y+9
	ldd r25,Y+10
	call __gtsf2
	cp __zero_reg__,r24
	brge .L18
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(32)
	ldi r21,lo8(65)
	ldd r22,Y+3
	ldd r23,Y+4
	ldd r24,Y+5
	ldd r25,Y+6
	call __mulsf3
	movw r26,r24
	movw r24,r22
	movw r22,r24
	movw r24,r26
	call __fixunssfsi
	movw r26,r24
	movw r24,r22
	std Y+12,r25
	std Y+11,r24
	rjmp .L11
.L12:
	ldi r24,lo8(-56)
	ldi r25,0
	std Y+14,r25
	std Y+13,r24
	ldd r24,Y+13
	ldd r25,Y+14
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	std Y+14,r25
	std Y+13,r24
	ldd r24,Y+11
	ldd r25,Y+12
	sbiw r24,1
	std Y+12,r25
	std Y+11,r24
.L11:
	ldd r24,Y+11
	ldd r25,Y+12
	sbiw r24,0
	brne .L12
	rjmp .L13
.L18:
	ldd r22,Y+7
	ldd r23,Y+8
	ldd r24,Y+9
	ldd r25,Y+10
	call __fixunssfsi
	movw r26,r24
	movw r24,r22
	std Y+12,r25
	std Y+11,r24
.L8:
	ldd r24,Y+11
	ldd r25,Y+12
	std Y+16,r25
	std Y+15,r24
	ldd r24,Y+15
	ldd r25,Y+16
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	std Y+16,r25
	std Y+15,r24
.L13:
	ldd r24,Y+1
	ldd r25,Y+2
	ldi r31,1
	eor r24,r31
	std Y+2,r25
	std Y+1,r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call puts
	rjmp .L14
	.size	main, .-main
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
