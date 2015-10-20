	.file	"uart_print.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	printCHAR
	.type	printCHAR, @function
printCHAR:
	push r28
	push r29
	rcall .
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+1,r24
	std Y+3,r23
	std Y+2,r22
	nop
.L2:
	ldi r24,lo8(43)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	mov r24,r24
	ldi r25,0
	andi r24,32
	clr r25
	sbiw r24,0
	breq .L2
	ldi r24,lo8(44)
	ldi r25,0
	ldd r18,Y+1
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	printCHAR, .-printCHAR
.global	getCHAR
	.type	getCHAR, @function
getCHAR:
	push r28
	push r29
	rcall .
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+3,r25
	std Y+2,r24
	nop
.L5:
	ldi r24,lo8(43)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	tst r24
	brge .L5
	ldi r24,lo8(44)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	std Y+1,r24
	ldd r24,Y+1
	mov r24,r24
	ldi r25,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	getCHAR, .-getCHAR
.global	flushUART
	.type	flushUART, @function
flushUART:
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	rjmp .L8
.L9:
	ldi r24,lo8(44)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	std Y+1,r24
.L8:
	ldi r24,lo8(43)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	tst r24
	brlt .L9
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	flushUART, .-flushUART
.global	uart_str
	.data
	.type	uart_str, @object
	.size	uart_str, 14
uart_str:
	.zero	3
	.byte	3
	.zero	4
	.word	gs(printCHAR)
	.word	gs(getCHAR)
	.word	0
	.text
.global	initUSART0STDIO
	.type	initUSART0STDIO, @function
initUSART0STDIO:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,r25
	std Y+1,r24
	ldi r24,lo8(42)
	ldi r25,0
	ldi r18,lo8(42)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(24)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-107)
	ldi r25,0
	ldi r18,lo8(-107)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(70)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-112)
	ldi r25,0
	ldd r18,Y+1
	ldd r19,Y+2
	mov r18,r19
	lsl r19
	sbc r19,r19
	movw r30,r24
	st Z,r18
	ldi r24,lo8(41)
	ldi r25,0
	ldd r18,Y+1
	movw r30,r24
	st Z,r18
	ldi r24,lo8(uart_str)
	ldi r25,hi8(uart_str)
	sts __iob+2+1,r25
	sts __iob+2,r24
	ldi r24,lo8(uart_str)
	ldi r25,hi8(uart_str)
	sts __iob+1,r25
	sts __iob,r24
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	initUSART0STDIO, .-initUSART0STDIO
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
