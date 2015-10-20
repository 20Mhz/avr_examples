	.file	"main.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_12
	.type	__vector_12, @function
__vector_12:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
	ldi r30,lo8(97)
	ldi r31,hi8(97)
	ld r24,Z
	ori r24,lo8(-128)
	st Z,r24
	ldi r30,lo8(98)
	ldi r31,hi8(98)
	ld r24,Z
	ori r24,lo8(-128)
	st Z,r24
/* epilogue start */
	pop r31
	pop r30
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_12, .-__vector_12
.global	__vector_13
	.type	__vector_13, @function
__vector_13:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
	ldi r30,lo8(97)
	ldi r31,hi8(97)
	ld r24,Z
	ori r24,lo8(-128)
	st Z,r24
	ldi r30,lo8(98)
	ldi r31,hi8(98)
	ld r24,Z
	andi r24,lo8(127)
	st Z,r24
/* epilogue start */
	pop r31
	pop r30
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_13, .-__vector_13
.global	__vector_33
	.type	__vector_33, @function
__vector_33:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
/* prologue: Signal */
/* frame size = 0 */
/* epilogue start */
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_33, .-__vector_33
	.data
.LC0:
	.string	"Supply Voltage: %lu mV\n"
	.text
.global	checkSupply
	.type	checkSupply, @function
checkSupply:
	push r13
	push r14
	push r15
	push r16
	push r17
	push r29
	push r28
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	movw r22,r28
	subi r22,lo8(-(1))
	sbci r23,hi8(-(1))
	call singleADC
	ldd r22,Y+1
	ldd r23,Y+2
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	andi r23,hi8(1023)
	andi r24,hlo8(1023)
	andi r25,hhi8(1023)
	ldi r18,lo8(2560)
	ldi r19,hi8(2560)
	ldi r20,hlo8(2560)
	ldi r21,hhi8(2560)
	call __mulsi3
	ldi r18,lo8(1023)
	ldi r19,hi8(1023)
	ldi r20,hlo8(1023)
	ldi r21,hhi8(1023)
	call __udivmodsi4
	mov r13,r21
	movw r14,r18
	mov r16,r20
	mov r17,r21
	rcall .
	rcall .
	rcall .
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	in r30,__SP_L__
	in r31,__SP_H__
	std Z+2,r25
	std Z+1,r24
	movw r26,r16
	movw r24,r14
	ldi r18,2
1:	lsl r24
	rol r25
	rol r26
	rol r27
	dec r18
	brne 1b
	std Z+3,r24
	std Z+4,r25
	std Z+5,r26
	std Z+6,r27
	call printf
	in r24,__SP_L__
	in r25,__SP_H__
	adiw r24,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r25
	out __SREG__,__tmp_reg__
	out __SP_L__,r24
	call flushUART
	movw r22,r14
	mov r24,r16
	mov r25,r13
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r28
	pop r29
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
	.size	checkSupply, .-checkSupply
.global	initDevice
	.type	initDevice, @function
initDevice:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(51)
	ldi r25,hi8(51)
	call initUSART0STDIO
	call initADC
	call initBT
.L10:
	lds r24,99
	sbrs r24,0
	rjmp .L10
	call initTimer
	call initI2C
	in r24,34-32
	ori r24,lo8(-80)
	out 34-32,r24
	in r24,35-32
	ori r24,lo8(-112)
	out 35-32,r24
	cbi 35-32,5
	call zg_init
	in r24,89-32
	ori r24,lo8(64)
	out 89-32,r24
/* #APP */
 ;  124 "./src/main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(0)
	ldi r25,hi8(0)
/* epilogue start */
	ret
	.size	initDevice, .-initDevice
.global	main
	.type	main, @function
main:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	call initDevice
	ldi r18,lo8(-15536)
	ldi r19,hi8(-15536)
	ldi r28,lo8(200)
	ldi r29,hi8(200)
	rjmp .L20
.L15:
	movw r24,r28
/* #APP */
 ;  105 "/usr/local/CrossPack-AVR-20100115/lib/gcc/avr/4.3.3/../../../../avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r18,lo8(-(-1))
	sbci r19,hi8(-(-1))
.L20:
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	brne .L15
	call checkSupply
	call configINA219
	or r24,r25
	brne .L19
	call getAmpINA219
	rjmp .L19
.L17:
	call zg_drv_process
.L19:
	call zg_get_conn_state
	cpi r24,lo8(1)
	brne .L17
	ldi r18,lo8(-15536)
	ldi r19,hi8(-15536)
	rjmp .L15
	.size	main, .-main
	.data
.LC1:
	.string	"Got interrupted"
	.text
.global	__vector_7
	.type	__vector_7, @function
__vector_7:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call puts
	call zg_isr
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_7, .-__vector_7
.global	local_ip
	.data
	.type	local_ip, @object
	.size	local_ip, 4
local_ip:
	.byte	10
	.byte	0
	.byte	1
	.byte	31
.global	gateway_ip
	.type	gateway_ip, @object
	.size	gateway_ip, 4
gateway_ip:
	.byte	10
	.byte	0
	.byte	1
	.byte	1
.global	subnet_mask
	.type	subnet_mask, @object
	.size	subnet_mask, 4
subnet_mask:
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
.global	ssid
	.section	.progmem.data,"a",@progbits
	.type	ssid, @object
	.size	ssid, 8
ssid:
	.string	"odyssea"
.global	security_type
	.data
	.type	security_type, @object
	.size	security_type, 1
security_type:
	.byte	3
.global	security_passphrase
	.section	.progmem.data
	.type	security_passphrase, @object
	.size	security_passphrase, 11
security_passphrase:
	.string	"SF#467emvc"
.global	wep_keys
	.type	wep_keys, @object
	.size	wep_keys, 52
wep_keys:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
.global	wireless_mode
	.data
	.type	wireless_mode, @object
	.size	wireless_mode, 1
wireless_mode:
	.byte	1
	.comm ssid_len,1,1
	.comm security_passphrase_len,1,1
.global __do_copy_data
.global __do_clear_bss
