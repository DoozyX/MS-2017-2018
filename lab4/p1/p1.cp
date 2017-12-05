#line 1 "C:/Users/151539/Documents/lab4/p1/p1.c"
void main() {
 int c = 0;
 int d = 0;
 int s = 0B10000000;

 ANSEL = 0;
 ANSELH = 0;


 TRISB = 0x00;
 PORTB = 0x00;



 while(1) {
 if (PORTB.B0 == 1) {
 s=0B10000000;
 PORTB=s;
 }else {
 if(c == 2) {
 s = s << 1;
 c = 0;
 } else {

 s = s >> 1;
 c = c + 1;
 }
 PORTB=s;

 }
 Delay_ms(5);
 }
}
