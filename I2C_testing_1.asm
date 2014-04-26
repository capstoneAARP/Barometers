_kalman_init:
;I2C_testing_1.c,32 :: 		kalman_state kalman_init(double q, double r, double e, double intial_value)
; intial_value start address is: 12 (R3)
; e start address is: 8 (R2)
; r start address is: 4 (R1)
; q start address is: 0 (R0)
SUB	SP, SP, #20
MOV	R4, R3
MOV	R3, R2
MOV	R2, R1
MOV	R1, R0
; intial_value end address is: 12 (R3)
; e end address is: 8 (R2)
; r end address is: 4 (R1)
; q end address is: 0 (R0)
; q start address is: 4 (R1)
; r start address is: 8 (R2)
; e start address is: 12 (R3)
; intial_value start address is: 16 (R4)
; su_addr start address is: 0 (R0)
MOV	R0, R12
;I2C_testing_1.c,35 :: 		result.q = q;
STR	R1, [SP, #0]
; q end address is: 4 (R1)
;I2C_testing_1.c,36 :: 		result.r = r;
STR	R2, [SP, #4]
; r end address is: 8 (R2)
;I2C_testing_1.c,37 :: 		result.e = e;
STR	R3, [SP, #12]
; e end address is: 12 (R3)
;I2C_testing_1.c,38 :: 		result.x = intial_value;
STR	R4, [SP, #8]
; intial_value end address is: 16 (R4)
;I2C_testing_1.c,40 :: 		return result;
MOVS	R7, #20
MOV	R6, R0
; su_addr end address is: 0 (R0)
ADD	R5, SP, #0
L_kalman_init0:
LDRB	R4, [R5, #0]
STRB	R4, [R6, #0]
SUBS	R7, R7, #1
UXTB	R7, R7
ADDS	R5, R5, #1
ADDS	R6, R6, #1
CMP	R7, #0
IT	NE
BNE	L_kalman_init0
;I2C_testing_1.c,41 :: 		}
L_end_kalman_init:
ADD	SP, SP, #20
BX	LR
; end of _kalman_init
_kalman_update:
;I2C_testing_1.c,45 :: 		void kalman_update(kalman_state* state, double measurement)
; measurement start address is: 4 (R1)
; state start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
MOV	R9, R0
MOV	R10, R1
; measurement end address is: 4 (R1)
; state end address is: 0 (R0)
; state start address is: 36 (R9)
; measurement start address is: 40 (R10)
;I2C_testing_1.c,48 :: 		state->e = state->e + state->q;
ADD	R2, R9, #12
STR	R2, [SP, #8]
LDR	R2, [R2, #0]
LDR	R0, [R9, #0]
BL	__Add_FP+0
LDR	R2, [SP, #8]
STR	R0, [R2, #0]
;I2C_testing_1.c,51 :: 		state->k = state->e / (state->e + state->r);
ADD	R2, R9, #16
STR	R2, [SP, #16]
ADD	R2, R9, #12
LDR	R3, [R2, #0]
STR	R3, [SP, #12]
ADD	R2, R9, #4
LDR	R0, [R2, #0]
MOV	R2, R3
BL	__Add_FP+0
STR	R0, [SP, #8]
LDR	R0, [SP, #12]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
BL	__Div_FP+0
LDR	R1, [SP, #4]
LDR	R2, [SP, #16]
STR	R0, [R2, #0]
;I2C_testing_1.c,52 :: 		state->x = state->x + state->k * (measurement - state->x);
ADD	R2, R9, #8
STR	R2, [SP, #16]
LDR	R3, [R2, #0]
STR	R3, [SP, #12]
ADD	R2, R9, #16
STR	R2, [SP, #8]
MOV	R2, R3
MOV	R0, R10
BL	__Sub_FP+0
; measurement end address is: 40 (R10)
LDR	R2, [SP, #8]
LDR	R2, [R2, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #12]
BL	__Add_FP+0
LDR	R2, [SP, #16]
STR	R0, [R2, #0]
;I2C_testing_1.c,53 :: 		state->e = (1 - state->k) * state->e;
ADD	R2, R9, #12
STR	R2, [SP, #8]
ADD	R2, R9, #16
; state end address is: 36 (R9)
LDR	R2, [R2, #0]
MOV	R0, #1065353216
BL	__Sub_FP+0
LDR	R2, [SP, #8]
LDR	R2, [R2, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #8]
STR	R0, [R2, #0]
;I2C_testing_1.c,54 :: 		}
L_end_kalman_update:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _kalman_update
_init_AltAdj:
;I2C_testing_1.c,58 :: 		void init_AltAdj(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;I2C_testing_1.c,59 :: 		UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;I2C_testing_1.c,60 :: 		delay_ms(500);
MOVW	R7, #22611
MOVT	R7, #20
NOP
NOP
L_init_AltAdj1:
SUBS	R7, R7, #1
BNE	L_init_AltAdj1
NOP
NOP
NOP
NOP
;I2C_testing_1.c,65 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;I2C_testing_1.c,66 :: 		GPIO_Digital_Output(&GPIOF_BASE, _GPIO_PINMASK_2);
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOF_BASE+0)
MOVT	R0, #hi_addr(GPIOF_BASE+0)
BL	_GPIO_Digital_Output+0
;I2C_testing_1.c,68 :: 		I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB89);               // performs I2C initialization
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C1_PB89+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C1_PB89+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C1_Init_Advanced+0
;I2C_testing_1.c,69 :: 		delay_ms(10);
MOVW	R7, #26665
MOVT	R7, #0
NOP
NOP
L_init_AltAdj3:
SUBS	R7, R7, #1
BNE	L_init_AltAdj3
NOP
NOP
;I2C_testing_1.c,71 :: 		oss = BMP085_HIGHRES;
MOVS	R1, #2
MOVW	R0, #lo_addr(_oss+0)
MOVT	R0, #hi_addr(_oss+0)
STRB	R1, [R0, #0]
;I2C_testing_1.c,72 :: 		}
L_end_init_AltAdj:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_AltAdj
_calibrate_BMP085:
;I2C_testing_1.c,74 :: 		void calibrate_BMP085(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;I2C_testing_1.c,76 :: 		I2C_Start();
BL	_I2C_Start+0
;I2C_testing_1.c,77 :: 		data_[0] = 0xAA;
MOVS	R1, #170
MOVW	R0, #lo_addr(_data_+0)
MOVT	R0, #hi_addr(_data_+0)
STRB	R1, [R0, #0]
;I2C_testing_1.c,78 :: 		I2C1_Write(0x77, data_, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #119
BL	_I2C1_Write+0
;I2C_testing_1.c,79 :: 		I2C1_Read(0x77, holder_, 22, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #22
MOVW	R1, #lo_addr(_holder_+0)
MOVT	R1, #hi_addr(_holder_+0)
MOVS	R0, #119
BL	_I2C1_Read+0
;I2C_testing_1.c,80 :: 		AC1 = holder_[0];
MOVW	R0, #lo_addr(_holder_+0)
MOVT	R0, #hi_addr(_holder_+0)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_AC1+0)
MOVT	R2, #hi_addr(_AC1+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,81 :: 		AC1 <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,82 :: 		AC1 += holder_[1];
MOVW	R0, #lo_addr(_holder_+1)
MOVT	R0, #hi_addr(_holder_+1)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,83 :: 		AC2 = holder_[2];
MOVW	R0, #lo_addr(_holder_+2)
MOVT	R0, #hi_addr(_holder_+2)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_AC2+0)
MOVT	R2, #hi_addr(_AC2+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,84 :: 		AC2 <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,85 :: 		AC2 += holder_[3];
MOVW	R0, #lo_addr(_holder_+3)
MOVT	R0, #hi_addr(_holder_+3)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,86 :: 		AC3 = holder_[4];
MOVW	R0, #lo_addr(_holder_+4)
MOVT	R0, #hi_addr(_holder_+4)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_AC3+0)
MOVT	R2, #hi_addr(_AC3+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,87 :: 		AC3 <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,88 :: 		AC3 += holder_[5];
MOVW	R0, #lo_addr(_holder_+5)
MOVT	R0, #hi_addr(_holder_+5)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,89 :: 		AC4 = holder_[6];
MOVW	R0, #lo_addr(_holder_+6)
MOVT	R0, #hi_addr(_holder_+6)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_AC4+0)
MOVT	R2, #hi_addr(_AC4+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,90 :: 		AC4 <<= 8;
MOV	R0, R2
LDRH	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,91 :: 		AC4 += holder_[7];
MOVW	R0, #lo_addr(_holder_+7)
MOVT	R0, #hi_addr(_holder_+7)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,92 :: 		AC5 = holder_[8];
MOVW	R0, #lo_addr(_holder_+8)
MOVT	R0, #hi_addr(_holder_+8)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_AC5+0)
MOVT	R2, #hi_addr(_AC5+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,93 :: 		AC5 <<= 8;
MOV	R0, R2
LDRH	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,94 :: 		AC5 += holder_[9];
MOVW	R0, #lo_addr(_holder_+9)
MOVT	R0, #hi_addr(_holder_+9)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,95 :: 		AC6 = holder_[10];
MOVW	R0, #lo_addr(_holder_+10)
MOVT	R0, #hi_addr(_holder_+10)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_AC6+0)
MOVT	R2, #hi_addr(_AC6+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,96 :: 		AC6 <<= 8;
MOV	R0, R2
LDRH	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,97 :: 		AC6 += holder_[11];
MOVW	R0, #lo_addr(_holder_+11)
MOVT	R0, #hi_addr(_holder_+11)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,98 :: 		B_1 = holder_[12];
MOVW	R0, #lo_addr(_holder_+12)
MOVT	R0, #hi_addr(_holder_+12)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_B_1+0)
MOVT	R2, #hi_addr(_B_1+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,99 :: 		B_1 <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,100 :: 		B_1 += holder_[13];
MOVW	R0, #lo_addr(_holder_+13)
MOVT	R0, #hi_addr(_holder_+13)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,101 :: 		B_2 = holder_[14];
MOVW	R0, #lo_addr(_holder_+14)
MOVT	R0, #hi_addr(_holder_+14)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_B_2+0)
MOVT	R2, #hi_addr(_B_2+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,102 :: 		B_2 <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,103 :: 		B_2 += holder_[15];
MOVW	R0, #lo_addr(_holder_+15)
MOVT	R0, #hi_addr(_holder_+15)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,104 :: 		MBx = holder_[16];
MOVW	R0, #lo_addr(_holder_+16)
MOVT	R0, #hi_addr(_holder_+16)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_MBx+0)
MOVT	R2, #hi_addr(_MBx+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,105 :: 		MBx <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,106 :: 		MBx += holder_[17];
MOVW	R0, #lo_addr(_holder_+17)
MOVT	R0, #hi_addr(_holder_+17)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,107 :: 		MC = holder_[18];
MOVW	R0, #lo_addr(_holder_+18)
MOVT	R0, #hi_addr(_holder_+18)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_MC+0)
MOVT	R2, #hi_addr(_MC+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,108 :: 		MC <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,109 :: 		MC += holder_[19];
MOVW	R0, #lo_addr(_holder_+19)
MOVT	R0, #hi_addr(_holder_+19)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,110 :: 		MD = holder_[20];
MOVW	R0, #lo_addr(_holder_+20)
MOVT	R0, #hi_addr(_holder_+20)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_MD+0)
MOVT	R2, #hi_addr(_MD+0)
STRH	R0, [R2, #0]
;I2C_testing_1.c,111 :: 		MD <<= 8;
MOV	R0, R2
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
STRH	R1, [R2, #0]
;I2C_testing_1.c,112 :: 		MD += holder_[21];
MOVW	R0, #lo_addr(_holder_+21)
MOVT	R0, #hi_addr(_holder_+21)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
STRH	R0, [R2, #0]
;I2C_testing_1.c,113 :: 		delay_ms(5);
MOVW	R7, #13331
MOVT	R7, #0
NOP
NOP
L_calibrate_BMP0855:
SUBS	R7, R7, #1
BNE	L_calibrate_BMP0855
NOP
NOP
NOP
NOP
;I2C_testing_1.c,115 :: 		}
L_end_calibrate_BMP085:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _calibrate_BMP085
_read_Temp:
;I2C_testing_1.c,117 :: 		void read_Temp(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;I2C_testing_1.c,119 :: 		data_[0] = 0xF4;
MOVS	R1, #244
MOVW	R0, #lo_addr(_data_+0)
MOVT	R0, #hi_addr(_data_+0)
STRB	R1, [R0, #0]
;I2C_testing_1.c,120 :: 		data_[1] = 0x2E;
MOVS	R1, #46
MOVW	R0, #lo_addr(_data_+1)
MOVT	R0, #hi_addr(_data_+1)
STRB	R1, [R0, #0]
;I2C_testing_1.c,121 :: 		I2C_Start();
BL	_I2C_Start+0
;I2C_testing_1.c,122 :: 		I2C1_Write(0x77, data_, 2, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #2
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #119
BL	_I2C1_Write+0
;I2C_testing_1.c,123 :: 		Delay_ms(6);
MOVW	R7, #15998
MOVT	R7, #0
NOP
NOP
L_read_Temp7:
SUBS	R7, R7, #1
BNE	L_read_Temp7
NOP
NOP
NOP
;I2C_testing_1.c,124 :: 		data_[0] = 0xF6;
MOVS	R1, #246
MOVW	R0, #lo_addr(_data_+0)
MOVT	R0, #hi_addr(_data_+0)
STRB	R1, [R0, #0]
;I2C_testing_1.c,125 :: 		I2C1_Write(0x77, data_, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #119
BL	_I2C1_Write+0
;I2C_testing_1.c,126 :: 		delay_ms(5);
MOVW	R7, #13331
MOVT	R7, #0
NOP
NOP
L_read_Temp9:
SUBS	R7, R7, #1
BNE	L_read_Temp9
NOP
NOP
NOP
NOP
;I2C_testing_1.c,127 :: 		I2C1_Read(0x77, msb_, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_msb_+0)
MOVT	R1, #hi_addr(_msb_+0)
MOVS	R0, #119
BL	_I2C1_Read+0
;I2C_testing_1.c,128 :: 		I2C1_Read(0x77, lsb_, 1, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #1
MOVW	R1, #lo_addr(_lsb_+0)
MOVT	R1, #hi_addr(_lsb_+0)
MOVS	R0, #119
BL	_I2C1_Read+0
;I2C_testing_1.c,130 :: 		LSB = lsb_[0];
MOVW	R0, #lo_addr(_lsb_+0)
MOVT	R0, #hi_addr(_lsb_+0)
LDRB	R0, [R0, #0]
MOVW	R3, #lo_addr(_LSB+0)
MOVT	R3, #hi_addr(_LSB+0)
STR	R0, [R3, #0]
;I2C_testing_1.c,131 :: 		MSB = msb_[0];
MOVW	R0, #lo_addr(_msb_+0)
MOVT	R0, #hi_addr(_msb_+0)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_MSB+0)
MOVT	R2, #hi_addr(_MSB+0)
STR	R0, [R2, #0]
;I2C_testing_1.c,132 :: 		MSB <<= 8;
MOV	R0, R2
LDR	R0, [R0, #0]
LSLS	R1, R0, #8
STR	R1, [R2, #0]
;I2C_testing_1.c,133 :: 		UT = MSB + LSB;
MOV	R0, R3
LDR	R0, [R0, #0]
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_UT+0)
MOVT	R0, #hi_addr(_UT+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,135 :: 		}
L_end_read_Temp:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_Temp
_read_Press:
;I2C_testing_1.c,137 :: 		void read_Press(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;I2C_testing_1.c,142 :: 		data_[0] = 0xF4;
MOVS	R1, #244
MOVW	R0, #lo_addr(_data_+0)
MOVT	R0, #hi_addr(_data_+0)
STRB	R1, [R0, #0]
;I2C_testing_1.c,143 :: 		data_[1] = 0x34 + (oss<<6);
MOVW	R0, #lo_addr(_oss+0)
MOVT	R0, #hi_addr(_oss+0)
STR	R0, [SP, #4]
LDRB	R0, [R0, #0]
LSLS	R0, R0, #6
UXTH	R0, R0
ADDW	R1, R0, #52
MOVW	R0, #lo_addr(_data_+1)
MOVT	R0, #hi_addr(_data_+1)
STRB	R1, [R0, #0]
;I2C_testing_1.c,144 :: 		I2C_Start();
BL	_I2C_Start+0
;I2C_testing_1.c,145 :: 		I2C1_Write(0x77, data_, 2, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #2
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #119
BL	_I2C1_Write+0
;I2C_testing_1.c,146 :: 		Delay_ms(5);
MOVW	R7, #13331
MOVT	R7, #0
NOP
NOP
L_read_Press11:
SUBS	R7, R7, #1
BNE	L_read_Press11
NOP
NOP
NOP
NOP
;I2C_testing_1.c,148 :: 		data_[0] = 0xF6;
MOVS	R1, #246
MOVW	R0, #lo_addr(_data_+0)
MOVT	R0, #hi_addr(_data_+0)
STRB	R1, [R0, #0]
;I2C_testing_1.c,149 :: 		I2C1_Write(0x77, data_, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #119
BL	_I2C1_Write+0
;I2C_testing_1.c,150 :: 		delay_ms(5);
MOVW	R7, #13331
MOVT	R7, #0
NOP
NOP
L_read_Press13:
SUBS	R7, R7, #1
BNE	L_read_Press13
NOP
NOP
NOP
NOP
;I2C_testing_1.c,152 :: 		I2C1_Read(0x77, msb_, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_msb_+0)
MOVT	R1, #hi_addr(_msb_+0)
MOVS	R0, #119
BL	_I2C1_Read+0
;I2C_testing_1.c,153 :: 		I2C1_Read(0x77, lsb_, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_lsb_+0)
MOVT	R1, #hi_addr(_lsb_+0)
MOVS	R0, #119
BL	_I2C1_Read+0
;I2C_testing_1.c,154 :: 		I2C1_Read(0x77, xlsb_, 1, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #1
MOVW	R1, #lo_addr(_xlsb_+0)
MOVT	R1, #hi_addr(_xlsb_+0)
MOVS	R0, #119
BL	_I2C1_Read+0
;I2C_testing_1.c,155 :: 		delay_ms(2);
MOVW	R7, #5331
MOVT	R7, #0
NOP
NOP
L_read_Press15:
SUBS	R7, R7, #1
BNE	L_read_Press15
NOP
NOP
NOP
NOP
;I2C_testing_1.c,157 :: 		MSB = msb_[0];
MOVW	R0, #lo_addr(_msb_+0)
MOVT	R0, #hi_addr(_msb_+0)
LDRB	R0, [R0, #0]
MOVW	R3, #lo_addr(_MSB+0)
MOVT	R3, #hi_addr(_MSB+0)
STR	R0, [R3, #0]
;I2C_testing_1.c,158 :: 		LSB = lsb_[0];
MOVW	R0, #lo_addr(_lsb_+0)
MOVT	R0, #hi_addr(_lsb_+0)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_LSB+0)
MOVT	R2, #hi_addr(_LSB+0)
STR	R0, [R2, #0]
;I2C_testing_1.c,159 :: 		MSB <<= 16;
MOV	R0, R3
LDR	R0, [R0, #0]
LSLS	R1, R0, #16
STR	R1, [R3, #0]
;I2C_testing_1.c,160 :: 		LSB <<= 8;
MOV	R0, R2
LDR	R0, [R0, #0]
LSLS	R0, R0, #8
STR	R0, [R2, #0]
;I2C_testing_1.c,161 :: 		UP = (MSB + LSB + xlsb_[0]) >> (8 - oss);
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_xlsb_+0)
MOVT	R0, #hi_addr(_xlsb_+0)
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
LDR	R0, [SP, #4]
LDRB	R0, [R0, #0]
RSB	R0, R0, #8
SXTH	R0, R0
LSRS	R1, R0
MOVW	R0, #lo_addr(_UP+0)
MOVT	R0, #hi_addr(_UP+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,162 :: 		delay_ms(100);
MOVW	R7, #4521
MOVT	R7, #4
NOP
NOP
L_read_Press17:
SUBS	R7, R7, #1
BNE	L_read_Press17
NOP
NOP
;I2C_testing_1.c,164 :: 		}
L_end_read_Press:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _read_Press
_calc_Temp:
;I2C_testing_1.c,166 :: 		void calc_Temp(){
;I2C_testing_1.c,170 :: 		X1 = (UT - AC6) * AC5/32768;
MOVW	R0, #lo_addr(_AC6+0)
MOVT	R0, #hi_addr(_AC6+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_UT+0)
MOVT	R0, #hi_addr(_UT+0)
LDR	R0, [R0, #0]
SUB	R1, R0, R1
MOVW	R0, #lo_addr(_AC5+0)
MOVT	R0, #hi_addr(_AC5+0)
LDRH	R0, [R0, #0]
MULS	R0, R1, R0
ASRS	R3, R0, #15
MOVW	R2, #lo_addr(_X1+0)
MOVT	R2, #hi_addr(_X1+0)
STR	R3, [R2, #0]
;I2C_testing_1.c,171 :: 		X2 = ((long)MC * 2048)/(X1 + (long)MD);
MOVW	R0, #lo_addr(_MC+0)
MOVT	R0, #hi_addr(_MC+0)
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #11
MOVW	R0, #lo_addr(_MD+0)
MOVT	R0, #hi_addr(_MD+0)
LDRSH	R0, [R0, #0]
ADDS	R0, R3, R0
SDIV	R1, R1, R0
MOVW	R0, #lo_addr(_X2+0)
MOVT	R0, #hi_addr(_X2+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,172 :: 		B_5 = X1 + X2;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_B_5+0)
MOVT	R0, #hi_addr(_B_5+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,173 :: 		Temp = (B_5 + 8)/16;
ADDW	R0, R1, #8
ASRS	R1, R0, #4
MOVW	R0, #lo_addr(_Temp+0)
MOVT	R0, #hi_addr(_Temp+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,175 :: 		}
L_end_calc_Temp:
BX	LR
; end of _calc_Temp
_calc_Press:
;I2C_testing_1.c,177 :: 		void calc_Press(){
;I2C_testing_1.c,181 :: 		B_6 = B_5 - 4000;
MOVW	R0, #lo_addr(_B_5+0)
MOVT	R0, #hi_addr(_B_5+0)
LDR	R0, [R0, #0]
SUB	R2, R0, #4000
MOVW	R8, #lo_addr(_B_6+0)
MOVT	R8, #hi_addr(_B_6+0)
STR	R2, [R8, #0]
;I2C_testing_1.c,182 :: 		X1 = ((long)B_2 * (B_6 * B_6 / 4096))/2048;
MOVW	R0, #lo_addr(_B_2+0)
MOVT	R0, #hi_addr(_B_2+0)
LDRSH	R1, [R0, #0]
MUL	R0, R2, R2
ASRS	R0, R0, #12
MULS	R0, R1, R0
ASRS	R0, R0, #11
MOVW	R7, #lo_addr(_X1+0)
MOVT	R7, #hi_addr(_X1+0)
STR	R0, [R7, #0]
;I2C_testing_1.c,183 :: 		X2 = (long)AC2 * B_6 / 2048;
MOVW	R0, #lo_addr(_AC2+0)
MOVT	R0, #hi_addr(_AC2+0)
LDRSH	R1, [R0, #0]
MOV	R0, R8
LDR	R0, [R0, #0]
MULS	R0, R1, R0
ASRS	R1, R0, #11
MOVW	R6, #lo_addr(_X2+0)
MOVT	R6, #hi_addr(_X2+0)
STR	R1, [R6, #0]
;I2C_testing_1.c,184 :: 		X3 = X1+X2;
MOV	R0, R7
LDR	R0, [R0, #0]
ADDS	R1, R0, R1
MOVW	R5, #lo_addr(_X3+0)
MOVT	R5, #hi_addr(_X3+0)
STR	R1, [R5, #0]
;I2C_testing_1.c,185 :: 		B_3 = ((((long)AC1 *4 + X3) << oss) + 2) / 4;
MOVW	R0, #lo_addr(_AC1+0)
MOVT	R0, #hi_addr(_AC1+0)
LDRSH	R0, [R0, #0]
LSLS	R0, R0, #2
ADDS	R1, R0, R1
MOVW	R4, #lo_addr(_oss+0)
MOVT	R4, #hi_addr(_oss+0)
LDRB	R0, [R4, #0]
LSL	R0, R1, R0
ADDS	R0, R0, #2
ASRS	R0, R0, #2
MOVW	R3, #lo_addr(_B_3+0)
MOVT	R3, #hi_addr(_B_3+0)
STR	R0, [R3, #0]
;I2C_testing_1.c,186 :: 		X1 = AC3 * B_6 / 8192;
MOV	R0, R8
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_AC3+0)
MOVT	R0, #hi_addr(_AC3+0)
LDRSH	R0, [R0, #0]
MULS	R0, R1, R0
ASRS	R0, R0, #13
STR	R0, [R7, #0]
;I2C_testing_1.c,187 :: 		X2 = ((long)B_1 * (B_6 * B_6 / 4096)) / 65536;
MOVW	R0, #lo_addr(_B_1+0)
MOVT	R0, #hi_addr(_B_1+0)
LDRSH	R2, [R0, #0]
MOV	R0, R8
LDR	R1, [R0, #0]
MOV	R0, R8
LDR	R0, [R0, #0]
MULS	R0, R1, R0
ASRS	R0, R0, #12
MULS	R0, R2, R0
ASRS	R1, R0, #16
STR	R1, [R6, #0]
;I2C_testing_1.c,188 :: 		X3 = (X1 + X2 + 2) / 4;
MOV	R0, R7
LDR	R0, [R0, #0]
ADDS	R0, R0, R1
ADDS	R0, R0, #2
ASRS	R2, R0, #2
STR	R2, [R5, #0]
;I2C_testing_1.c,189 :: 		B_4 = (long)AC4 * (X3 + 32768) / 32768;
MOVW	R0, #lo_addr(_AC4+0)
MOVT	R0, #hi_addr(_AC4+0)
LDRH	R1, [R0, #0]
ADD	R0, R2, #32768
MULS	R0, R1, R0
ASRS	R1, R0, #15
MOVW	R0, #lo_addr(_B_4+0)
MOVT	R0, #hi_addr(_B_4+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,190 :: 		B_7 = (UP - B_3) * (50000 >> oss);
MOV	R0, R3
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_UP+0)
MOVT	R0, #hi_addr(_UP+0)
LDR	R0, [R0, #0]
SUB	R2, R0, R1
MOV	R0, R4
LDRB	R1, [R0, #0]
MOVW	R0, #50000
LSRS	R0, R1
UXTH	R0, R0
MUL	R1, R2, R0
MOVW	R0, #lo_addr(_B_7+0)
MOVT	R0, #hi_addr(_B_7+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,191 :: 		if(B_7 < 0x80000000)
CMP	R1, #-2147483648
IT	CS
BCS	L_calc_Press19
;I2C_testing_1.c,192 :: 		p = (B_7 * 2) / B_4;
MOVW	R0, #lo_addr(_B_7+0)
MOVT	R0, #hi_addr(_B_7+0)
LDR	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_B_4+0)
MOVT	R0, #hi_addr(_B_4+0)
LDR	R0, [R0, #0]
UDIV	R1, R1, R0
MOVW	R0, #lo_addr(_p+0)
MOVT	R0, #hi_addr(_p+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_calc_Press20
L_calc_Press19:
;I2C_testing_1.c,194 :: 		p = (B_7 / B_4) * 2;
MOVW	R0, #lo_addr(_B_4+0)
MOVT	R0, #hi_addr(_B_4+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_B_7+0)
MOVT	R0, #hi_addr(_B_7+0)
LDR	R0, [R0, #0]
UDIV	R0, R0, R1
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_p+0)
MOVT	R0, #hi_addr(_p+0)
STR	R1, [R0, #0]
L_calc_Press20:
;I2C_testing_1.c,195 :: 		X1 = (p / 256) * (p / 256);
MOVW	R3, #lo_addr(_p+0)
MOVT	R3, #hi_addr(_p+0)
LDR	R0, [R3, #0]
ASRS	R0, R0, #8
MUL	R1, R0, R0
MOVW	R2, #lo_addr(_X1+0)
MOVT	R2, #hi_addr(_X1+0)
STR	R1, [R2, #0]
;I2C_testing_1.c,196 :: 		X1 = (X1 * 3038) / 65536;
MOVW	R0, #3038
MULS	R0, R1, R0
ASRS	R0, R0, #16
STR	R0, [R2, #0]
;I2C_testing_1.c,197 :: 		X2 = (-7357 * p) / 65536;
MOV	R0, R3
LDR	R1, [R0, #0]
MOVW	R0, #58179
MOVT	R0, #65535
MULS	R0, R1, R0
ASRS	R1, R0, #16
MOVW	R0, #lo_addr(_X2+0)
MOVT	R0, #hi_addr(_X2+0)
STR	R1, [R0, #0]
;I2C_testing_1.c,198 :: 		p = p + (X1 + X2 +3791) / 16;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, R1
ADDW	R0, R0, #3791
ASRS	R1, R0, #4
MOV	R0, R3
LDR	R0, [R0, #0]
ADDS	R0, R0, R1
STR	R0, [R3, #0]
;I2C_testing_1.c,200 :: 		}
L_end_calc_Press:
BX	LR
; end of _calc_Press
_stabilize_BMP085:
;I2C_testing_1.c,202 :: 		void stabilize_BMP085(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;I2C_testing_1.c,203 :: 		for(i=0; i<=4; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_stabilize_BMP08521:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #4
IT	GT
BGT	L_stabilize_BMP08522
;I2C_testing_1.c,204 :: 		read_Temp();
BL	_read_Temp+0
;I2C_testing_1.c,205 :: 		read_Press();
BL	_read_Press+0
;I2C_testing_1.c,206 :: 		calc_Temp();
BL	_calc_Temp+0
;I2C_testing_1.c,207 :: 		calc_Press();
BL	_calc_Press+0
;I2C_testing_1.c,208 :: 		delay_ms(100);
MOVW	R7, #4521
MOVT	R7, #4
NOP
NOP
L_stabilize_BMP08524:
SUBS	R7, R7, #1
BNE	L_stabilize_BMP08524
NOP
NOP
;I2C_testing_1.c,203 :: 		for(i=0; i<=4; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;I2C_testing_1.c,209 :: 		}
IT	AL
BAL	L_stabilize_BMP08521
L_stabilize_BMP08522:
;I2C_testing_1.c,210 :: 		}
L_end_stabilize_BMP085:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _stabilize_BMP085
_main:
;I2C_testing_1.c,212 :: 		void main() {
SUB	SP, SP, #40
;I2C_testing_1.c,214 :: 		init_AltAdj();
BL	_init_AltAdj+0
;I2C_testing_1.c,215 :: 		calibrate_BMP085();
BL	_calibrate_BMP085+0
;I2C_testing_1.c,216 :: 		stabilize_BMP085();
BL	_stabilize_BMP085+0
;I2C_testing_1.c,217 :: 		test = kalman_init(1/K_GAIN,K_GAIN,10,p);            // q, r, e, initial values for kalman filter
MOVW	R0, #lo_addr(_p+0)
MOVT	R0, #hi_addr(_p+0)
LDR	R0, [R0, #0]
BL	__SignedIntegralToFloat+0
MOV	R3, R0
MOVW	R2, #0
MOVT	R2, #16672
MOV	R1, #1073741824
MOV	R0, #1056964608
ADD	R12, SP, #20
BL	_kalman_init+0
MOVS	R3, #20
ADD	R2, SP, #0
ADD	R1, SP, #20
L_main26:
LDRB	R0, [R1, #0]
STRB	R0, [R2, #0]
SUBS	R3, R3, #1
UXTB	R3, R3
ADDS	R1, R1, #1
ADDS	R2, R2, #1
CMP	R3, #0
IT	NE
BNE	L_main26
;I2C_testing_1.c,219 :: 		while(1){
L_main27:
;I2C_testing_1.c,220 :: 		read_Temp();
BL	_read_Temp+0
;I2C_testing_1.c,221 :: 		read_Press();
BL	_read_Press+0
;I2C_testing_1.c,222 :: 		calc_Temp();
BL	_calc_Temp+0
;I2C_testing_1.c,223 :: 		calc_Press();
BL	_calc_Press+0
;I2C_testing_1.c,225 :: 		kalman_update(&test,p);
MOVW	R0, #lo_addr(_p+0)
MOVT	R0, #hi_addr(_p+0)
LDR	R0, [R0, #0]
BL	__SignedIntegralToFloat+0
MOV	R1, R0
ADD	R0, SP, #0
BL	_kalman_update+0
;I2C_testing_1.c,226 :: 		new_Barometer = test.x;
LDR	R0, [SP, #8]
BL	__FloatToSignedIntegral+0
MOVW	R1, #lo_addr(_new_Barometer+0)
MOVT	R1, #hi_addr(_new_Barometer+0)
STR	R0, [R1, #0]
;I2C_testing_1.c,229 :: 		millibar = new_Barometer * 0.01;
BL	__SignedIntegralToFloat+0
MOVW	R2, #55050
MOVT	R2, #15395
BL	__Mul_FP+0
MOVW	R1, #lo_addr(_millibar+0)
MOVT	R1, #hi_addr(_millibar+0)
STR	R0, [R1, #0]
;I2C_testing_1.c,230 :: 		feet = (1 - pow((millibar / 1013.25), 0.190284)) * 145366.45;
MOVW	R2, #20480
MOVT	R2, #17533
BL	__Div_FP+0
MOVW	R1, #55759
MOVT	R1, #15938
BL	_pow+0
MOV	R2, R0
MOV	R0, #1065353216
BL	__Sub_FP+0
MOVW	R2, #62877
MOVT	R2, #18445
BL	__Mul_FP+0
MOVW	R1, #lo_addr(_feet+0)
MOVT	R1, #hi_addr(_feet+0)
STR	R0, [R1, #0]
;I2C_testing_1.c,235 :: 		i = ceil(feet);  // round the fractional feet to whole feet
MOV	R0, R0
BL	_ceil+0
BL	__FloatToSignedIntegral+0
SXTH	R0, R0
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
STRH	R0, [R1, #0]
;I2C_testing_1.c,236 :: 		IntToStr(i, NewB_);
MOVW	R1, #lo_addr(_NewB_+0)
MOVT	R1, #hi_addr(_NewB_+0)
BL	_IntToStr+0
;I2C_testing_1.c,237 :: 		UART1_Write_Text(NewB_);
MOVW	R0, #lo_addr(_NewB_+0)
MOVT	R0, #hi_addr(_NewB_+0)
BL	_UART1_Write_Text+0
;I2C_testing_1.c,238 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;I2C_testing_1.c,239 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;I2C_testing_1.c,240 :: 		delay_ms(200);
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main29:
SUBS	R7, R7, #1
BNE	L_main29
NOP
NOP
NOP
NOP
;I2C_testing_1.c,243 :: 		}
IT	AL
BAL	L_main27
;I2C_testing_1.c,244 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
