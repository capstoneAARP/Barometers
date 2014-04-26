#line 1 "C:/Users/Prometheus/Documents/GitHub/Barometers/I2C_testing_1.c"






char msb_[1], lsb_[1], xlsb_[1];
char data_[2], holder_[22];
char oss, NewB_[12];
unsigned int AC4, AC5, AC6;
int AC1, AC2, AC3, B_1, B_2, MBx, MC, MD, i;

unsigned long MSB, LSB, B_4;
long UP, UT, X1, X2, X3, B_3, B_5, B_6, B_7, Temp, p, new_Barometer, new_Feet;
float millibar, feet;





typedef struct{
 double q;
 double r;
 double x;
 double e;
 double k;
} kalman_state;




kalman_state kalman_init(double q, double r, double e, double intial_value)
{
 kalman_state result;
 result.q = q;
 result.r = r;
 result.e = e;
 result.x = intial_value;

 return result;
}



void kalman_update(kalman_state* state, double measurement)
{

 state->e = state->e + state->q;


 state->k = state->e / (state->e + state->r);
 state->x = state->x + state->k * (measurement - state->x);
 state->e = (1 - state->k) * state->e;
}



void init_AltAdj(){
 UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
 delay_ms(500);




 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOF_BASE, _GPIO_PINMASK_2);

 I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB89);
 delay_ms(10);

 oss =  2 ;
}

void calibrate_BMP085(){

 I2C_Start();
 data_[0] = 0xAA;
 I2C1_Write(0x77, data_, 1, END_MODE_RESTART);
 I2C1_Read(0x77, holder_, 22, END_MODE_STOP);
 AC1 = holder_[0];
 AC1 <<= 8;
 AC1 += holder_[1];
 AC2 = holder_[2];
 AC2 <<= 8;
 AC2 += holder_[3];
 AC3 = holder_[4];
 AC3 <<= 8;
 AC3 += holder_[5];
 AC4 = holder_[6];
 AC4 <<= 8;
 AC4 += holder_[7];
 AC5 = holder_[8];
 AC5 <<= 8;
 AC5 += holder_[9];
 AC6 = holder_[10];
 AC6 <<= 8;
 AC6 += holder_[11];
 B_1 = holder_[12];
 B_1 <<= 8;
 B_1 += holder_[13];
 B_2 = holder_[14];
 B_2 <<= 8;
 B_2 += holder_[15];
 MBx = holder_[16];
 MBx <<= 8;
 MBx += holder_[17];
 MC = holder_[18];
 MC <<= 8;
 MC += holder_[19];
 MD = holder_[20];
 MD <<= 8;
 MD += holder_[21];
 delay_ms(5);

}

void read_Temp(){

 data_[0] = 0xF4;
 data_[1] = 0x2E;
 I2C_Start();
 I2C1_Write(0x77, data_, 2, END_MODE_STOP);
 Delay_ms(6);
 data_[0] = 0xF6;
 I2C1_Write(0x77, data_, 1, END_MODE_RESTART);
 delay_ms(5);
 I2C1_Read(0x77, msb_, 1, END_MODE_RESTART);
 I2C1_Read(0x77, lsb_, 1, END_MODE_STOP);

 LSB = lsb_[0];
 MSB = msb_[0];
 MSB <<= 8;
 UT = MSB + LSB;

}

void read_Press(){




 data_[0] = 0xF4;
 data_[1] = 0x34 + (oss<<6);
 I2C_Start();
 I2C1_Write(0x77, data_, 2, END_MODE_STOP);
 Delay_ms(5);

 data_[0] = 0xF6;
 I2C1_Write(0x77, data_, 1, END_MODE_RESTART);
 delay_ms(5);

 I2C1_Read(0x77, msb_, 1, END_MODE_RESTART);
 I2C1_Read(0x77, lsb_, 1, END_MODE_RESTART);
 I2C1_Read(0x77, xlsb_, 1, END_MODE_STOP);
 delay_ms(2);

 MSB = msb_[0];
 LSB = lsb_[0];
 MSB <<= 16;
 LSB <<= 8;
 UP = (MSB + LSB + xlsb_[0]) >> (8 - oss);
 delay_ms(100);

}

void calc_Temp(){
#line 170 "C:/Users/Prometheus/Documents/GitHub/Barometers/I2C_testing_1.c"
 X1 = (UT - AC6) * AC5/32768;
 X2 = ((long)MC * 2048)/(X1 + (long)MD);
 B_5 = X1 + X2;
 Temp = (B_5 + 8)/16;

}

void calc_Press(){
#line 181 "C:/Users/Prometheus/Documents/GitHub/Barometers/I2C_testing_1.c"
 B_6 = B_5 - 4000;
 X1 = ((long)B_2 * (B_6 * B_6 / 4096))/2048;
 X2 = (long)AC2 * B_6 / 2048;
 X3 = X1+X2;
 B_3 = ((((long)AC1 *4 + X3) << oss) + 2) / 4;
 X1 = AC3 * B_6 / 8192;
 X2 = ((long)B_1 * (B_6 * B_6 / 4096)) / 65536;
 X3 = (X1 + X2 + 2) / 4;
 B_4 = (long)AC4 * (X3 + 32768) / 32768;
 B_7 = (UP - B_3) * (50000 >> oss);
 if(B_7 < 0x80000000)
 p = (B_7 * 2) / B_4;
 else
 p = (B_7 / B_4) * 2;
 X1 = (p / 256) * (p / 256);
 X1 = (X1 * 3038) / 65536;
 X2 = (-7357 * p) / 65536;
 p = p + (X1 + X2 +3791) / 16;

}

void stabilize_BMP085(){
 for(i=0; i<=4; i++){
 read_Temp();
 read_Press();
 calc_Temp();
 calc_Press();
 delay_ms(100);
 }
}

void main() {
 kalman_state test;
 init_AltAdj();
 calibrate_BMP085();
 stabilize_BMP085();
 test = kalman_init(1/ 2.0 , 2.0 ,10,p);

while(1){
 read_Temp();
 read_Press();
 calc_Temp();
 calc_Press();

 kalman_update(&test,p);
 new_Barometer = test.x;


 millibar = new_Barometer * 0.01;
 feet = (1 - pow((millibar / 1013.25), 0.190284)) * 145366.45;




 i = ceil(feet);
 IntToStr(i, NewB_);
 UART1_Write_Text(NewB_);
 UART1_Write(13);
 UART1_Write(10);
 delay_ms(200);


 }
}
