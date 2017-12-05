// Set the connections with the LCD
sbit LCD_RS at RA4_bit;
sbit LCD_EN at RA5_bit;
sbit LCD_D4 at RA0_bit;
sbit LCD_D5 at RA1_bit;
sbit LCD_D6 at RA2_bit;
sbit LCD_D7 at RA3_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
const int len = 16;
char ch;
int i;
char text[20], text2[20];
short ifinterupt=0; //this variable counts the interrupts. In the beginningt he number of interrupts is 0
short znak=0;
unsigned cnt;
unsigned flag = 0;
//the interrupt function definition
void interrupt(){
     //taster
    if (INTF_bit==1){ //if the interrupted is caused by RB0/INT
       ifinterupt++;
       INTF_bit = 0; //the bit that registered this interrupt is reset to 0, so that new interrupts could be registerd
     }
     //timer
    if (TMR0IF_bit) { // if an interrupt from the timer 0 occurred
       cnt++; // increment the counter
       TMR0IF_bit = 0; // reset TMR0IF
       TMR0 = 6; // set TMR0 to the initial value
}
}

void main(){
    ANSEL = 0; // set all pins as digital
    ANSELH = 0;
    PORTB=0x00; // set port B to 0
    TRISB=0x01; // set the pin RB0 as input. Change in the input will cause an interrupt and then the function interrupt() will be executed
    INTCON=0b10110000; //set the register to enable an interrupt from pin RB0

    OPTION_REG = 0b011; // set the prescaler of TMR0

    C1ON_bit = 0; // disable the comparators
    C2ON_bit = 0;
    TRISB = 0; // set PORTB as an output port
    TMR0 = 6; // initialize Timer0   ------ 256-250
    INTCON = 0xA0; // enable the interrupts from TMRO
    cnt = 0;
    
    Lcd_Init();
    Lcd_Cmd(_LCD_CURSOR_OFF);
    //all the time switch
    while(1) {

      while(ifinterupt==0){
      }
      //after the first interrupt the following instruction is executed

      Lcd_Cmd(_LCD_CLEAR);
      strcpy(text,"Slobodan    ");
      Lcd_Out(1,1,text); //print Demo text in the first row
      strcpy(text2,"151539          ");
      Lcd_Out(2,1,text2); //print Second line in the second row

      while(ifinterupt==1){

      }
      //after the second interrupt the following instruction is executed
      flag = 0;
      cnt = 0;
      Lcd_Cmd(_LCD_CLEAR);
      strcpy(text,"Slobodan    ");
      Lcd_Out(1,1,text); //print Demo text in the first row
      do {
        if (cnt >= 12) {     //250*500*16 = 2M cnt=500    23ms=12
            if (flag == 1) {
              Lcd_Cmd(_LCD_CLEAR);
              strcpy(text,"Slobodan    ");
              Lcd_Out(1,1,text); //print Demo text in the first row
              cnt = 0; // reset cnt

              flag = 1;
            } else {
              Lcd_Cmd(_LCD_CLEAR);
              strcpy(text2,"151539          ");
              Lcd_Out(2,1,text2); //print index line in the second row
              //something 1s
              cnt = 0; // reset cnt
              flag = 0;
            }
        }
      } while(1);

      while(ifinterupt==2){

      }
      //after the third interrupt the following instruction is executed
      Lcd_Cmd(_LCD_CLEAR);
      //reset to 0
      ifinterupt = 0;
    }
}
