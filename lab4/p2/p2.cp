#line 1 "C:/Users/151539/Documents/lab4/p2/p2.c"
#line 1 "c:/working/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 3 "C:/Users/151539/Documents/lab4/p2/p2.c"
void main() {
 int s = 0B01101101;
 int o = 0B00111111;
 int c = 0;
 int i = 0;

 ANSEL = 0;
 ANSELH = 0;


 TRISB = 0x00;
 PORTB = 0x00;



 while(1) {
 if ( PORTE.B0 == 1 ) {
 PORTB = s; -
 c = c + 1;
 } else {
 i = i + 1;
 EEPROM_Write(0x80, i);
 EEPROM_Write(0x80 + i, c);
 c = 0;
 PORTB = o;
 }
 Delay_ms(25);
 }
}
