	.file	"g2100.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	spi_transfer
	.type	spi_transfer, @function
spi_transfer:
/* prologue: function */
/* frame size = 0 */
	movw r26,r24
	cbi 56-32,1
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	rjmp .L2
.L4:
	movw r30,r26
	add r30,r18
	adc r31,r19
	ld r24,Z
	out 47-32,r24
.L3:
	sbis 46-32,7
	rjmp .L3
	in r24,47-32
	st Z,r24
	subi r18,lo8(-(1))
	sbci r19,hi8(-(1))
.L2:
	cp r18,r22
	cpc r19,r23
	brlo .L4
	cpse r20,__zero_reg__
	sbi 56-32,1
.L6:
	ret
	.size	spi_transfer, .-spi_transfer
.global	zg_chip_reset
	.type	zg_chip_reset, @function
zg_chip_reset:
	push r13
	push r14
	push r15
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
	ldi r17,lo8(0)
	ldi r18,lo8(62)
	mov r13,r18
	ldi r25,lo8(46)
	mov r14,r25
	ldi r24,lo8(63)
	mov r15,r24
	ldi r16,lo8(-1)
.L12:
	sts hdr,r13
	sts hdr+1,__zero_reg__
	sts hdr+2,r14
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	sts hdr,r15
	tst r17
	breq .L9
	ldi r24,lo8(15)
	rjmp .L10
.L9:
	ldi r24,lo8(-128)
.L10:
	sts hdr+1,r24
	sts hdr+2,r16
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	cpi r17,lo8(1)
	breq .L11
	ldi r17,lo8(1)
	rjmp .L12
.L11:
	ldi r24,lo8(62)
	sts hdr,r24
	sts hdr+1,__zero_reg__
	ldi r24,lo8(42)
	sts hdr+2,r24
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r17,lo8(127)
.L13:
	sts hdr,r17
	sts hdr+1,__zero_reg__
	sts hdr+2,__zero_reg__
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	lds r24,hdr+1
	sbrs r24,4
	rjmp .L13
	ldi r17,lo8(111)
.L17:
	sts hdr,r17
	sts hdr+1,__zero_reg__
	sts hdr+2,__zero_reg__
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	lds r24,hdr+1
	tst r24
	brne .L16
	lds r24,hdr+2
	tst r24
	breq .L17
.L16:
/* epilogue start */
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
	.size	zg_chip_reset, .-zg_chip_reset
.global	zg_interrupt2_reg
	.type	zg_interrupt2_reg, @function
zg_interrupt2_reg:
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
	ldi r16,lo8(hdr)
	ldi r17,hi8(hdr)
	ldi r24,lo8(110)
	sts hdr,r24
	sts hdr+1,__zero_reg__
	sts hdr+2,__zero_reg__
	movw r24,r16
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(45)
	sts hdr,r24
	ldi r24,lo8(-1)
	sts hdr+1,r24
	sts hdr+2,r24
	sts hdr+3,__zero_reg__
	sts hdr+4,__zero_reg__
	movw r24,r16
	ldi r22,lo8(5)
	ldi r23,hi8(5)
	ldi r20,lo8(1)
	call spi_transfer
/* epilogue start */
	pop r17
	pop r16
	ret
	.size	zg_interrupt2_reg, .-zg_interrupt2_reg
.global	zg_interrupt_reg
	.type	zg_interrupt_reg, @function
zg_interrupt_reg:
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
	mov r16,r24
	mov r17,r22
	ldi r24,lo8(66)
	sts hdr,r24
	sts hdr+1,__zero_reg__
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(2)
	ldi r23,hi8(2)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(1)
	sts hdr,r24
	lds r18,hdr+1
	tst r17
	breq .L23
	mov r25,r16
	rjmp .L24
.L23:
	ldi r25,lo8(0)
.L24:
	mov r24,r16
	com r24
	and r24,r18
	or r25,r24
	sts hdr+2,r25
	sts hdr+1,r16
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
/* epilogue start */
	pop r17
	pop r16
	ret
	.size	zg_interrupt_reg, .-zg_interrupt_reg
.global	zg_isr
	.type	zg_isr, @function
zg_isr:
/* prologue: function */
/* frame size = 0 */
	in r24,89-32
	andi r24,lo8(-65)
	out 89-32,r24
	ldi r24,lo8(1)
	sts intr_occured,r24
/* epilogue start */
	ret
	.size	zg_isr, .-zg_isr
.global	zg_process_isr
	.type	zg_process_isr, @function
zg_process_isr:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(65)
	sts hdr,r24
	sts hdr+1,__zero_reg__
	sts hdr+2,__zero_reg__
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r18,lo8(1)
	lds r25,hdr+2
	lds r24,hdr+1
	and r25,r24
	sbrs r25,7
	rjmp .L33
	sts hdr,r18
	ldi r24,lo8(-128)
	sts hdr+1,r24
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(2)
	ldi r23,hi8(2)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(53)
	rjmp .L31
.L33:
	sbrs r25,6
	rjmp .L34
	sts hdr,r18
	ldi r24,lo8(64)
	sts hdr+1,r24
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(2)
	ldi r23,hi8(2)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(51)
.L31:
	ori r24,lo8(64)
	sts hdr,r24
	sts hdr+1,__zero_reg__
	sts hdr+2,__zero_reg__
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	ldi r20,lo8(1)
	call spi_transfer
	lds r23,hdr+1
	ldi r22,lo8(0)
	lds r24,hdr+2
	ldi r25,lo8(0)
	or r22,r24
	or r23,r25
	andi r23,hi8(4095)
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-128)
	st Z,r24
	subi r22,lo8(-(1))
	sbci r23,hi8(-(1))
	movw r24,r30
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(-48)
	sts hdr,r24
	ldi r24,lo8(hdr)
	ldi r25,hi8(hdr)
	ldi r22,lo8(1)
	ldi r23,hi8(1)
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(1)
	sts intr_valid,r24
.L34:
	sts intr_occured,__zero_reg__
	in r24,89-32
	ori r24,lo8(64)
	out 89-32,r24
/* epilogue start */
	ret
	.size	zg_process_isr, .-zg_process_isr
.global	zg_send
	.type	zg_send, @function
zg_send:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
	movw r16,r24
	movw r12,r22
	ldi r19,lo8(hdr)
	mov r14,r19
	ldi r19,hi8(hdr)
	mov r15,r19
	ldi r24,lo8(-96)
	sts hdr,r24
	ldi r24,lo8(1)
	sts hdr+1,r24
	sts hdr+2,r24
	sts hdr+3,__zero_reg__
	sts hdr+4,__zero_reg__
	movw r24,r14
	ldi r22,lo8(5)
	ldi r23,hi8(5)
	ldi r20,lo8(0)
	call spi_transfer
	ldi r24,lo8(-86)
	movw r30,r16
	std Z+6,r24
	std Z+7,r24
	ldi r24,lo8(3)
	std Z+8,r24
	std Z+11,__zero_reg__
	std Z+10,__zero_reg__
	std Z+9,__zero_reg__
	movw r24,r16
	movw r22,r12
	ldi r20,lo8(1)
	call spi_transfer
	ldi r24,lo8(-64)
	sts hdr,r24
	movw r24,r14
	ldi r22,lo8(1)
	ldi r23,hi8(1)
	ldi r20,lo8(1)
	call spi_transfer
/* epilogue start */
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	zg_send, .-zg_send
.global	zg_get_rx_status
	.type	zg_get_rx_status, @function
zg_get_rx_status:
/* prologue: function */
/* frame size = 0 */
	lds r24,rx_ready
	tst r24
	brne .L39
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	rjmp .L40
.L39:
	sts rx_ready,__zero_reg__
	lds r18,zg_buf_len
	lds r19,(zg_buf_len)+1
.L40:
	movw r24,r18
/* epilogue start */
	ret
	.size	zg_get_rx_status, .-zg_get_rx_status
.global	zg_clear_rx_status
	.type	zg_clear_rx_status, @function
zg_clear_rx_status:
/* prologue: function */
/* frame size = 0 */
	sts rx_ready,__zero_reg__
/* epilogue start */
	ret
	.size	zg_clear_rx_status, .-zg_clear_rx_status
.global	zg_set_tx_status
	.type	zg_set_tx_status, @function
zg_set_tx_status:
/* prologue: function */
/* frame size = 0 */
	sts tx_ready,r24
/* epilogue start */
	ret
	.size	zg_set_tx_status, .-zg_set_tx_status
.global	zg_get_conn_state
	.type	zg_get_conn_state, @function
zg_get_conn_state:
/* prologue: function */
/* frame size = 0 */
	lds r24,zg_conn_status
/* epilogue start */
	ret
	.size	zg_get_conn_state, .-zg_get_conn_state
.global	zg_set_buf
	.type	zg_set_buf, @function
zg_set_buf:
/* prologue: function */
/* frame size = 0 */
	sts (zg_buf)+1,r25
	sts zg_buf,r24
	sts (zg_buf_len)+1,r23
	sts zg_buf_len,r22
/* epilogue start */
	ret
	.size	zg_set_buf, .-zg_set_buf
.global	zg_get_mac
	.type	zg_get_mac, @function
zg_get_mac:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(mac)
	ldi r25,hi8(mac)
/* epilogue start */
	ret
	.size	zg_get_mac, .-zg_get_mac
.global	zg_recv
	.type	zg_recv, @function
zg_recv:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	movw r28,r22
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldd r25,Z+21
	ldd r24,Z+22
	st Y,r24
	std Y+1,r25
	movw r26,r30
	adiw r26,5
	ldi r24,lo8(6)
.L53:
	ld r0,X+
	st Z+,r0
	subi r24,lo8(-(-1))
	brne .L53
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	movw r26,r24
	adiw r26,6
	movw r30,r24
	adiw r30,11
	ldi r24,lo8(6)
.L54:
	ld r0,Z+
	st X+,r0
	subi r24,lo8(-(-1))
	brne .L54
	lds r18,zg_buf
	lds r19,(zg_buf)+1
	movw r22,r18
	subi r22,lo8(-(12))
	sbci r23,hi8(-(12))
	subi r18,lo8(-(29))
	sbci r19,hi8(-(29))
	ld r20,Y
	ldd r21,Y+1
	movw r24,r22
	movw r22,r18
	call memcpy
	ld r24,Y
	ldd r25,Y+1
	adiw r24,12
	std Y+1,r25
	st Y,r24
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	zg_recv, .-zg_recv
.global	zg_write_wep_key
	.type	zg_write_wep_key, @function
zg_write_wep_key:
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
	movw r16,r24
	ldi r24,lo8(3)
	movw r26,r16
	st X,r24
	ldi r24,lo8(13)
	adiw r26,1
	st X,r24
	sbiw r26,1
	adiw r26,2
	st X,__zero_reg__
	sbiw r26,2
	lds r24,ssid_len
	adiw r26,3
	st X,r24
	movw r30,r16
	adiw r30,4
	ldi r24,lo8(32)
	movw r26,r30
	st X+,__zero_reg__
        dec r24
	brne .-6
	lds r20,ssid_len
	movw r24,r30
	ldi r22,lo8(ssid)
	ldi r23,hi8(ssid)
	ldi r21,lo8(0)
	call memcpy_P
	movw r24,r16
	adiw r24,36
	ldi r22,lo8(wep_keys)
	ldi r23,hi8(wep_keys)
	ldi r20,lo8(52)
	ldi r21,hi8(52)
	call memcpy_P
/* epilogue start */
	pop r17
	pop r16
	ret
	.size	zg_write_wep_key, .-zg_write_wep_key
	.data
.LC0:
	.string	"MAC: %x,%x,%x,%x,%x,%x"
	.text
.global	zg_drv_process
	.type	zg_drv_process, @function
zg_drv_process:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	lds r24,tx_ready
	tst r24
	breq .L62
	lds r24,cnf_pending
	tst r24
	brne .L62
	lds r22,zg_buf_len
	lds r23,(zg_buf_len)+1
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	call zg_send
	sts tx_ready,__zero_reg__
	ldi r24,lo8(1)
	sts cnf_pending,r24
.L62:
	lds r24,intr_occured
	tst r24
	breq .L63
	call zg_process_isr
.L63:
	lds r24,intr_valid
	tst r24
	brne .+2
	rjmp .L64
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldd r24,Z+1
	cpi r24,lo8(2)
	breq .L67
	cpi r24,lo8(3)
	brsh .L70
	cpi r24,lo8(1)
	breq .+2
	rjmp .L65
	rjmp .L109
.L70:
	cpi r24,lo8(3)
	brne .+2
	rjmp .L68
	cpi r24,lo8(4)
	breq .+2
	rjmp .L65
	rjmp .L110
.L109:
	sts cnf_pending,__zero_reg__
	rjmp .L65
.L67:
	ldd r25,Z+3
	cpi r25,lo8(1)
	breq .+2
	rjmp .L65
	ldd r24,Z+2
	cpi r24,lo8(12)
	brne .+2
	rjmp .L73
	cpi r24,lo8(13)
	brsh .L77
	cpi r24,lo8(8)
	brne .+2
	rjmp .L103
	cpi r24,lo8(10)
	breq .+2
	rjmp .L65
	rjmp .L111
.L77:
	cpi r24,lo8(19)
	brne .+2
	rjmp .L75
	cpi r24,lo8(20)
	brne .+2
	rjmp .L107
	cpi r24,lo8(16)
	breq .+2
	rjmp .L65
	ldd r24,Z+7
	sts mac,r24
	ldd r24,Z+8
	sts mac+1,r24
	ldd r24,Z+9
	sts mac+2,r24
	ldd r24,Z+10
	sts mac+3,r24
	ldd r24,Z+11
	sts mac+4,r24
	ldd r24,Z+12
	sts mac+5,r24
	ldi r24,lo8(6)
	sts zg_drv_state,r24
	in r24,__SP_L__
	in r25,__SP_H__
	sbiw r24,14
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r25
	out __SREG__,__tmp_reg__
	out __SP_L__,r24
	in r30,__SP_L__
	in r31,__SP_H__
	adiw r30,1
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	in r26,__SP_L__
	in r27,__SP_H__
	adiw r26,1+1
	st X,r25
	st -X,r24
	sbiw r26,1
	lds r24,mac
	std Z+2,r24
	std Z+3,__zero_reg__
	lds r24,mac+1
	std Z+4,r24
	std Z+5,__zero_reg__
	lds r24,mac+2
	std Z+6,r24
	std Z+7,__zero_reg__
	lds r24,mac+3
	std Z+8,r24
	std Z+9,__zero_reg__
	lds r24,mac+4
	std Z+10,r24
	std Z+11,__zero_reg__
	lds r24,mac+5
	std Z+12,r24
	std Z+13,__zero_reg__
	call printf
	in r28,__SP_L__
	in r29,__SP_H__
	adiw r28,14
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	rjmp .L65
.L111:
	ldi r24,lo8(8)
	rjmp .L103
.L73:
	ldi r26,lo8(wpa_psk_key)
	ldi r27,hi8(wpa_psk_key)
	adiw r30,7
	ldi r24,lo8(32)
.L78:
	ld r0,Z+
	st X+,r0
	subi r24,lo8(-(-1))
	brne .L78
	ldi r24,lo8(7)
	rjmp .L103
.L75:
	sbi 56-32,6
	sts zg_conn_status,r25
	rjmp .L65
.L68:
	ldi r24,lo8(4)
	rjmp .L103
.L110:
	ldd r24,Z+2
	cpi r24,lo8(1)
	brlo .L65
	cpi r24,lo8(3)
	brlo .L79
	cpi r24,lo8(4)
	brne .L65
	rjmp .L112
.L79:
	cbi 56-32,6
	sts zg_conn_status,__zero_reg__
.L107:
	ldi r24,lo8(3)
.L103:
	sts zg_drv_state,r24
	rjmp .L65
.L112:
	ldd r25,Z+3
	ldi r24,lo8(0)
	ldd r18,Z+4
	ldi r19,lo8(0)
	or r18,r24
	or r19,r25
	cpi r18,1
	cpc r19,__zero_reg__
	breq .L81
	cpi r18,5
	cpc r19,__zero_reg__
	brne .L82
.L81:
	cbi 56-32,6
	sts zg_conn_status,__zero_reg__
	rjmp .L65
.L82:
	cpi r18,2
	cpc r19,__zero_reg__
	breq .L83
	cpi r18,6
	cpc r19,__zero_reg__
	brne .L65
.L83:
	sbi 56-32,6
	ldi r24,lo8(1)
	sts zg_conn_status,r24
.L65:
	sts intr_valid,__zero_reg__
.L64:
	lds r25,zg_drv_state
	cpi r25,lo8(4)
	brne .+2
	rjmp .L88
	cpi r25,lo8(5)
	brsh .L92
	cpi r25,lo8(2)
	breq .L86
	cpi r25,lo8(3)
	brlo .+2
	rjmp .L87
	tst r25
	breq .L85
	rjmp .L99
.L92:
	cpi r25,lo8(7)
	brne .+2
	rjmp .L90
	cpi r25,lo8(8)
	brne .+2
	rjmp .L91
	cpi r25,lo8(6)
	breq .+2
	rjmp .L99
	rjmp .L113
.L85:
	ldi r24,lo8(2)
	rjmp .L106
.L86:
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-80)
	st Z,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	std Z+1,r25
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(16)
	std Z+2,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	std Z+3,__zero_reg__
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(1)
	std Z+4,r24
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(5)
	ldi r23,hi8(5)
	rjmp .L108
.L113:
	lds r24,security_type
	cpi r24,lo8(1)
	breq .L94
	cpi r24,lo8(1)
	brlo .L93
	cpi r24,lo8(4)
	brlo .+2
	rjmp .L99
	rjmp .L114
.L93:
	ldi r24,lo8(8)
	rjmp .L106
.L94:
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-80)
	st Z,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(2)
	std Z+1,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(10)
	std Z+2,r24
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	adiw r24,3
	call zg_write_wep_key
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(91)
	ldi r23,hi8(91)
	rjmp .L108
.L114:
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-80)
	st Z,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(2)
	std Z+1,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(12)
	std Z+2,r24
	lds r16,zg_buf
	lds r17,(zg_buf)+1
	movw r30,r16
	adiw r30,3
	movw r26,r16
	adiw r26,3
	st X,__zero_reg__
	lds r24,security_passphrase_len
	std Z+1,r24
	lds r24,ssid_len
	std Z+2,r24
	std Z+3,__zero_reg__
	movw r30,r16
	adiw r30,7
	ldi r24,lo8(32)
	movw r28,r30
	st Y+,__zero_reg__
        dec r24
	brne .-6
	lds r20,ssid_len
	movw r24,r30
	ldi r22,lo8(ssid)
	ldi r23,hi8(ssid)
	ldi r21,lo8(0)
	call memcpy_P
	subi r16,lo8(-(39))
	sbci r17,hi8(-(39))
	ldi r24,lo8(64)
	movw r30,r16
	st Z+,__zero_reg__
        dec r24
	brne .-6
	lds r20,security_passphrase_len
	movw r24,r16
	ldi r22,lo8(security_passphrase)
	ldi r23,hi8(security_passphrase)
	ldi r21,lo8(0)
	call memcpy_P
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(103)
	ldi r23,hi8(103)
	rjmp .L108
.L90:
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-80)
	st Z,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(2)
	std Z+1,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(8)
	std Z+2,r24
	lds r16,zg_buf
	lds r17,(zg_buf)+1
	movw r26,r16
	adiw r26,3
	movw r28,r16
	std Y+3,__zero_reg__
	lds r24,ssid_len
	adiw r26,1
	st X,r24
	sbiw r26,1
	movw r30,r16
	adiw r30,5
	ldi r24,lo8(32)
	movw r28,r30
	st Y+,__zero_reg__
        dec r24
	brne .-6
	adiw r26,1
	ld r20,X
	movw r24,r30
	ldi r22,lo8(ssid)
	ldi r23,hi8(ssid)
	ldi r21,lo8(0)
	call memcpy_P
	movw r26,r16
	adiw r26,37
	ldi r30,lo8(wpa_psk_key)
	ldi r31,hi8(wpa_psk_key)
	ldi r24,lo8(32)
.L96:
	ld r0,Z+
	st X+,r0
	subi r24,lo8(-(-1))
	brne .L96
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(69)
	ldi r23,hi8(69)
	rjmp .L108
.L91:
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-80)
	st Z,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(2)
	std Z+1,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(20)
	std Z+2,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(1)
	std Z+3,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(10)
	std Z+4,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(19)
	std Z+5,r24
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	std Z+6,__zero_reg__
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(7)
	ldi r23,hi8(7)
	rjmp .L108
.L87:
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	movw r28,r30
	adiw r28,3
	ldi r24,lo8(-80)
	st Z,r24
	lds r26,zg_buf
	lds r27,(zg_buf)+1
	ldi r24,lo8(2)
	adiw r26,1
	st X,r24
	lds r26,zg_buf
	lds r27,(zg_buf)+1
	ldi r24,lo8(19)
	adiw r26,2
	st X,r24
	lds r24,security_type
	std Z+3,r24
	lds r24,ssid_len
	std Y+1,r24
	adiw r30,5
	ldi r24,lo8(32)
	movw r26,r30
	st X+,__zero_reg__
        dec r24
	brne .-6
	lds r20,ssid_len
	movw r24,r30
	ldi r22,lo8(ssid)
	ldi r23,hi8(ssid)
	ldi r21,lo8(0)
	call memcpy_P
	std Y+35,__zero_reg__
	std Y+34,__zero_reg__
	lds r24,wireless_mode
	cpi r24,lo8(1)
	breq .L104
.L97:
	cpi r24,lo8(2)
	brne .L98
.L104:
	std Y+36,r24
.L98:
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(41)
	ldi r23,hi8(41)
.L108:
	ldi r20,lo8(1)
	call spi_transfer
	lds r30,zg_buf
	lds r31,(zg_buf)+1
	ldi r24,lo8(-64)
	st Z,r24
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(1)
	ldi r23,hi8(1)
	ldi r20,lo8(1)
	call spi_transfer
	rjmp .L105
.L88:
	lds r24,zg_buf
	lds r25,(zg_buf)+1
	ldi r22,lo8(zg_buf_len)
	ldi r23,hi8(zg_buf_len)
	call zg_recv
	ldi r24,lo8(1)
	sts rx_ready,r24
.L105:
	ldi r24,lo8(5)
.L106:
	sts zg_drv_state,r24
.L99:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	zg_drv_process, .-zg_drv_process
.global	zg_init
	.type	zg_init, @function
zg_init:
/* prologue: function */
/* frame size = 0 */
	in r24,55-32
	ori r24,lo8(71)
	out 55-32,r24
	cbi 55-32,3
	ldi r25,lo8(1)
	out 56-32,r25
	ldi r24,lo8(80)
	out 45-32,r24
	out 46-32,r25
	in r24,46-32
	in r24,47-32
	sts intr_occured,__zero_reg__
	sts intr_valid,__zero_reg__
	sts zg_drv_state,__zero_reg__
	sts zg_conn_status,__zero_reg__
	sts tx_ready,__zero_reg__
	sts rx_ready,__zero_reg__
	sts cnf_pending,__zero_reg__
	ldi r24,lo8(uip_buf)
	ldi r25,hi8(uip_buf)
	sts (zg_buf)+1,r25
	sts zg_buf,r24
	ldi r24,lo8(400)
	ldi r25,hi8(400)
	sts (zg_buf_len)+1,r25
	sts zg_buf_len,r24
	call zg_chip_reset
	call zg_interrupt2_reg
	ldi r24,lo8(-1)
	ldi r22,lo8(0)
	call zg_interrupt_reg
	ldi r24,lo8(-64)
	ldi r22,lo8(1)
	call zg_interrupt_reg
	ldi r24,lo8(ssid)
	ldi r25,hi8(ssid)
	call strlen_P
	sts ssid_len,r24
	ldi r24,lo8(security_passphrase)
	ldi r25,hi8(security_passphrase)
	call strlen_P
	sts security_passphrase_len,r24
/* epilogue start */
	ret
	.size	zg_init, .-zg_init
	.lcomm mac,6
	.lcomm zg_conn_status,1
	.lcomm hdr,5
	.lcomm intr_occured,1
	.lcomm intr_valid,1
	.lcomm zg_drv_state,1
	.lcomm tx_ready,1
	.lcomm rx_ready,1
	.lcomm cnf_pending,1
	.lcomm zg_buf,2
	.lcomm zg_buf_len,2
	.lcomm wpa_psk_key,32
	.comm uip_buf,402,1
.global __do_copy_data
.global __do_clear_bss
