	.file	"ina219.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	calibration_32V_3A
	.type	calibration_32V_3A, @function
calibration_32V_3A:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(10)
	ldi r25,hi8(10)
	sts (current_div)+1,r25
	sts current_div,r24
	ldi r24,lo8(2)
	ldi r25,hi8(2)
	sts (power_div)+1,r25
	sts power_div,r24
	ldi r24,lo8(64)
	ldi r22,lo8(5)
	ldi r20,lo8(4096)
	ldi r21,hi8(4096)
	call writeI2C
	or r24,r25
	brne .L2
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	rjmp .L3
.L2:
	ldi r18,lo8(-1)
	ldi r19,hi8(-1)
.L3:
	movw r24,r18
/* epilogue start */
	ret
	.size	calibration_32V_3A, .-calibration_32V_3A
.global	configINA219
	.type	configINA219, @function
configINA219:
	push r29
	push r28
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
	ldi r24,lo8(64)
	ldi r22,lo8(0)
	ldi r20,lo8(14751)
	ldi r21,hi8(14751)
	call writeI2C
	or r24,r25
	breq .L6
	ldi r18,lo8(-1)
	ldi r19,hi8(-1)
	rjmp .L7
.L6:
	ldi r24,lo8(64)
	ldi r22,lo8(0)
	movw r20,r28
	subi r20,lo8(-(1))
	sbci r21,hi8(-(1))
	call readI2C
	or r24,r25
	breq .L8
	ldi r18,lo8(-2)
	ldi r19,hi8(-2)
	rjmp .L7
.L8:
	ldd r24,Y+1
	ldd r25,Y+2
	subi r24,lo8(14751)
	sbci r25,hi8(14751)
	brne .L9
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	rjmp .L7
.L9:
	ldi r18,lo8(-3)
	ldi r19,hi8(-3)
.L7:
	movw r24,r18
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r28
	pop r29
	ret
	.size	configINA219, .-configINA219
	.data
.LC0:
	.string	"Error while Reading Shunt Voltage (0x01)."
.LC1:
	.string	"Readed Shunt is: %x\n"
.LC2:
	.string	"Computed Voltage is: %.2fmV\n"
.LC3:
	.string	"Error while Reading Current (0x04)."
.LC4:
	.string	"Computed I (0x04) is: %.2fmA\n"
	.text
.global	getAmpINA219
	.type	getAmpINA219, @function
getAmpINA219:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r29
	push r28
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
	ldi r24,lo8(64)
	ldi r22,lo8(1)
	movw r20,r28
	subi r20,lo8(-(1))
	sbci r21,hi8(-(1))
	call readI2C
	or r24,r25
	breq .L12
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	rjmp .L17
.L12:
	rcall .
	rcall .
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	in r30,__SP_L__
	in r31,__SP_H__
	std Z+2,r25
	std Z+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	std Z+4,r25
	std Z+3,r24
	call printf
	rcall .
	in r16,__SP_L__
	in r17,__SP_H__
	subi r16,lo8(-(1))
	sbci r17,hi8(-(1))
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	in r30,__SP_L__
	in r31,__SP_H__
	std Z+2,r25
	std Z+1,r24
	ldd r18,Y+1
	ldd r19,Y+2
	sbrs r19,7
	rjmp .L14
	com r19
	neg r18
	sbci r19,lo8(-1)
.L14:
	movw r22,r18
	clr r24
	sbrc r23,7
	com r24
	mov r25,r24
	call __floatsisf
	ldi r18,lo8(0x46fa0000)
	ldi r19,hi8(0x46fa0000)
	ldi r20,hlo8(0x46fa0000)
	ldi r21,hhi8(0x46fa0000)
	call __divsf3
	ldi r18,lo8(0x43a00000)
	ldi r19,hi8(0x43a00000)
	ldi r20,hlo8(0x43a00000)
	ldi r21,hhi8(0x43a00000)
	call __mulsf3
	movw r30,r16
	std Z+2,r22
	std Z+3,r23
	std Z+4,r24
	std Z+5,r25
	call printf
	in r24,__SP_L__
	in r25,__SP_H__
	adiw r24,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r25
	out __SREG__,__tmp_reg__
	out __SP_L__,r24
	call calibration_32V_3A
	ldi r24,lo8(64)
	ldi r22,lo8(4)
	movw r20,r28
	subi r20,lo8(-(3))
	sbci r21,hi8(-(3))
	call readI2C
	or r24,r25
	breq .L15
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
.L17:
	call puts
	ldi r18,lo8(-1)
	ldi r19,hi8(-1)
	rjmp .L13
.L15:
	rcall .
	rcall .
	rcall .
	in r12,__SP_L__
	in r13,__SP_H__
	sec
	adc r12,__zero_reg__
	adc r13,__zero_reg__
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	in r30,__SP_L__
	in r31,__SP_H__
	std Z+2,r25
	std Z+1,r24
	ldd r22,Y+3
	ldd r23,Y+4
	clr r24
	sbrc r23,7
	com r24
	mov r25,r24
	call __floatsisf
	movw r14,r22
	movw r16,r24
	lds r22,current_div
	lds r23,(current_div)+1
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	call __floatunsisf
	movw r18,r22
	movw r20,r24
	movw r24,r16
	movw r22,r14
	call __divsf3
	movw r30,r12
	std Z+2,r22
	std Z+3,r23
	std Z+4,r24
	std Z+5,r25
	call printf
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	in r24,__SP_L__
	in r25,__SP_H__
	adiw r24,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r25
	out __SREG__,__tmp_reg__
	out __SP_L__,r24
.L13:
	movw r24,r18
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r28
	pop r29
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	getAmpINA219, .-getAmpINA219
	.lcomm current_div,2
	.lcomm power_div,2
.global __do_copy_data
.global __do_clear_bss
