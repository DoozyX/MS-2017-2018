// Set the connections for the keypad
char keypadPort at PORTD;
// set the connections for the LCD
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
char kp;
char txt[30];
int num = 0;
int isNUM = 0;
int isERROR;
int isMEASURE;
int isSHOW;
int isSHOW_ALL;
int isAVERAGE;
int array[20];
int isFULL = 0;
int i;
int j;
int sum;
unsigned int resultMesure;
unsigned int cnt;

void interrupt(){
     //timer
    if (TMR0IF_bit) { // if an interrupt from the timer 0 occurred
       cnt++; // increment the counter
       TMR0IF_bit = 0; // reset TMR0IF
       TMR0 = 6; // set TMR0 to the initial value
}
}

void main() {
    cnt = 0; // reset the counter that counts the number of successivelyc licked keys
    Keypad_Init(); // initialize the keypad
    ANSEL = 0; // AN pins are configured as digital
    ANSELH =  0b00000100; // b1 = an10 = 3d bit from right  == analog
    TRISA= 0;
    TRISB= 0b00000010;  //b1 is input pin
    Lcd_Init(); // initialize the LCD
    Lcd_Cmd(_LCD_CLEAR); // clear the screen
    Lcd_Cmd(_LCD_CURSOR_OFF); // turn off the courser
    i = 0;
    TMR0 = 6; // initialize Timer0   ------ 256-250
    INTCON = 0xA0; // enable the interrupts from TMRO
    cnt = 0;
    OPTION_REG = 0b011; // set the prescaler of TMR0
    C1ON_bit = 0; // disable the comparators
    C2ON_bit = 0;
    for ( i = 0; i < 20; ++i ) {
        array[i] = -1;
    }
    i = 0;
    do // always wait for one key click
    {
        isERROR = 0;
        isMEASURE = 0;
        isSHOW = 0;
        isSHOW_ALL = 0;
        isAVERAGE = 0;
        kp = 0; // reset kp that stores the numerical value of the key clicked
// wait for a key to be clicked
        do
            kp = Keypad_Key_Click(); // store the numerical value of the clicked key in kp
        while (!kp); //kp will be 0, it a key is not clicked
// transform kp in the ASCII code of the key (as shown on the table above)
        switch (kp) {
            case 1:
                num = (num * 10) + 1;
                isNUM = 1;
                break; // 1
            case 2:
                num = (num * 10) + 4;
                isNUM = 1;
                break; // 4
            case 3:
                num = (num * 10) + 7;
                isNUM = 1;
                break; // 7
            case 4:
                isERROR = 1;
                break; //Error
            case 5:
                num = (num * 10) + 2;
                isNUM = 1;
                break; // 2
            case 6:
                num = (num * 10) + 5;
                isNUM = 1;
                break; // 5
            case 7:
                num = (num * 10) + 8;
                isNUM = 1;
                break; // 8
            case 8:
                num = (num * 10) + 0;
                isNUM = 1;
                break; // 0
            case 9:
                num = (num * 10) + 3;
                isNUM = 1;
                break; // 3
            case 10:
                num = (num * 10) + 6;
                isNUM = 1;
                break; // 6
            case 11:
                num = (num * 10) + 9;
                isNUM = 1;
                break; // 9
            case 12:
                 isERROR = 1;
                break; // Error
            case 13:
                isMEASURE = 1;
                break; // MEASURE
            case 14:
                isSHOW = 1;
                break; // SHOW
            case 15:
                isSHOW_ALL = 1;
                break; // SHOW ALL
            case 16:
                isAVERAGE = 1;
                break; // AVERAGE
        }
        if (isERROR == 1) {
            num = 0;
            isNum = 0;
            Lcd_Cmd(_LCD_CLEAR); // clear the screen
            Lcd_Out(1, 1, "ERROR"); // print a message on the LCD
        } else if ( isMEASURE == 1) {
            num = 0;
            isNum = 0;
            //TODO mesure
            resultMesure = ADC_Read(10); //b1 is 10th analog pin;
            array[i] = resultMesure;
            i++;
            if (i == 20) {
                Lcd_Cmd(_LCD_CLEAR); // clear the screen
                Lcd_Out(1, 1, "List is full"); // print a message on the LCD
                Lcd_Out(2, 1, "starting from start"); // print a message on the LCD
                i = 0;
                isFULL = 20;
            }
        } else if ( isSHOW == 1) {
            if (num > 19 && num != -1 && array[num] != -1) {
                Lcd_Cmd(_LCD_CLEAR); // clear the screen
                Lcd_Out(1, 1, "ERROR"); // print a message on the LCD
            } else {
                Lcd_Cmd(_LCD_CLEAR); // clear the screen
                IntToStr(array[num-1], txt);
                Lcd_Out(1, 1, txt   ); // print a message on the LCD
            }
            num = 0;
            isNum = 0;
        } else if (isSHOW_ALL == 1) {
            num = 0;
            isNum = 0;
            for (j = 0; j < i || j < isFULL; ++j) {
                Lcd_Cmd(_LCD_CLEAR); // clear the screen
                IntToStr(array[j], txt);
                Lcd_Out(1, 1, txt ); // print a message on the LCD
                Delay_ms(15);
            }
            
            //with timer
            for (j = 0; j < i || j < isFULL; ++j) {
                cnt = 0;
                Lcd_Cmd(_LCD_CLEAR); // clear the screen
                IntToStr(array[j], txt);
                Lcd_Out(1, 1, txt ); // print a message on the LCD
                do {
                  if (cnt >= 8) {     //250*500*16 = 2M cnt=500    15ms=8
                      break;
                      cnt = 0; // reset cnt
                  }

                } while(1);
            }
            
            //end timer
        } else if (isAVERAGE) {
            num = 0;
            isNum = 0;
            sum = 0;
            for (j = 0; j < i || j < isFULL ; ++j) {
                sum += array[j];
            }
            Lcd_Cmd(_LCD_CLEAR); // clear the screen
            Lcd_Out(1, 1, "AVERAGE:"); // print a message on the LCD
            sum = sum/i;
            IntToStr(sum, txt);
            Lcd_Out(2, 1, txt ); // print a message on the LCD
        }
    } while (1);
}