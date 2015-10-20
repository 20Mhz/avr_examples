	.file	"uart_print.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	printCHAR
	.type	printCHAR, @function
printCHAR:
	push r17
/* prologue: function */
/* frame size = 0 */
	mov r17,r24
	cpi r24,lo8(10)
	brne .L4
	ldi r24,lo8(13)
	call printCHAR
.L4:
	sbis 43-32,5
	rjmp .L4
	out 44-32,r17
	ldi r24,lo8(0)
	ldi r25,hi8(0)
/* epilogue start */
	pop r17
	ret
	.size	printCHAR, .-printCHAR
.global	getCHAR
	.type	getCHAR, @function
getCHAR:
/* prologue: function */
/* frame size = 0 */
.L7:
	sbis 43-32,7
	rjmp .L7
	in r24,44-32
	ldi r25,lo8(0)
/* epilogue start */
	ret
	.size	getCHAR, .-getCHAR
.global	flushUART
	.type	flushUART, @function
flushUART:
/* prologue: function */
/* frame size = 0 */
	rjmp .L11
.L12:
	in r24,44-32
.L11:
	sbic 43-32,7
	rjmp .L12
/* epilogue start */
	ret
	.size	flushUART, .-flushUART
.global	initUSART0STDIO
	.type	initUSART0STDIO, @function
initUSART0STDIO:
/* prologue: function */
/* frame size = 0 */
	in r25,42-32
	ori r25,lo8(24)
	out 42-32,r25
	cbi 42-32,7
	ldi r30,lo8(149)
	ldi r31,hi8(149)
	ld r25,Z
	andi r25,lo8(-65)
	st Z,r25
	ld r25,Z
	ori r25,lo8(6)
	st Z,r25
	sts 144,__zero_reg__
	out 41-32,r24
	ldi r24,lo8(uart_str)
	ldi r25,hi8(uart_str)
	sts (__iob+2)+1,r25
	sts __iob+2,r24
	sts (__iob)+1,r25
	sts __iob,r24
/* epilogue start */
	ret
	.size	initUSART0STDIO, .-initUSART0STDIO
.global	uart_str
	.data
	.type	uart_str, @object
	.size	uart_str, 14
uart_str:
	.skip 3,0
	.byte	3
	.skip 4,0
	.word	gs(printCHAR)
	.word	gs(getCHAR)
	.word	0
.global __do_copy_data
