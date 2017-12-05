// Set the connections for the keypad
char keypadPort at PORTD;
// set the connections for the LCD
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
int cnt;
char kp,oldstate;
char txt[30];

void main() {
    cnt = 0; // reset the counter that counts the number of successivelyc licked keys
    Keypad_Init(); // initialize the keypad
    ANSEL = 0; // AN pins are configured as digital
    ANSELH = 0;
    Lcd_Init(); // initialize the LCD
    Lcd_Cmd(_LCD_CLEAR); // clear the screen
    Lcd_Cmd(_LCD_CURSOR_OFF); // turn off the courser
    Lcd_Out(1, 1, "Key :"); // print a message on the LCD
    Lcd_Out(2, 1, "Times:");
    do // always wait for one key click
    {
        kp = 0; // reset kp that stores the numerical value of the key clicked
// wait for a key to be clicked
        do
            kp = Keypad_Key_Click(); // store the numerical value of the clicked key in kp
        while (!kp); //kp will be 0, it a key is not clicked
// transform kp in the ASCII code of the key (as shown on the table above)
        switch (kp) {
            case 1:
                kp = 49;
                break; // 1
            case 2:
                kp = 50;
                break; // 2
            case 3:
                kp = 51;
                break; // 3
            case 4:
                kp = 65;
                break; // A
            case 5:
                kp = 52;
                break; // 4
            case 6:
                kp = 53;
                break; // 5
            case 7:
                kp = 54;
                break; // 6
            case 8:
                kp = 66;
                break; // B
            case 9:
                kp = 55;
                break; // 7
            case 10:
                kp = 56;
                break; // 8
            case 11:
                kp = 57;
                break; // 9
            case 12:
                kp = 67;
                break; // C
            case 13:
                kp = 42;
                break; // *
            case 14:
                kp = 48;
                break; // 0
            case 15:
                kp = 35;
                break; // #
            case 16:
                kp = 68;
                break; // D
        }
        if (kp != oldstate) {
// if the key clicked is different from the key previously clicked
            cnt = 1;
            oldstate = kp;
        } else {
// if the key clicked is the same as the key previously clicked
            cnt++;
        }
        Lcd_Chr(1, 10, kp); // print the ASCII code on LCD
        if (cnt == 255) {
// if an overflow on cnt happens it is reset
            cnt = 0;
            Lcd_Out(2, 10, " ");
        }
        WordToStr(cnt, txt); // transform the value of the counter to string
        Lcd_Out(2, 10, txt); // show the value of the counter on LCD
    } while (1);
}