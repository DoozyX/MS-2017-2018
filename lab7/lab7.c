//lcd on B
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

char uart_rd;
int count$ = 0;
int countSpace = 0;
int countWords = 0;
char words[255][255];
int i = 0;
int j = 0;

void main() {
    ANSEL = 0;
    ANSELH = 0; // AN pins are configured as digital
    C1ON_bit = 0;
    C2ON_bit = 0; // comparators are disabled
    UART1_Init(9600); // Initialization of UART on 9600 bps

    Delay_ms(50); // Wait for the UART module to become stable

    Lcd_Init(); // initialize the LCD
    Lcd_Cmd(_LCD_CLEAR); // clear the screen
    Lcd_Cmd(_LCD_CURSOR_OFF); // turn off the courser


    //    UART1_Write_Text("Start"); // Transmit the text Start vie UART module
    //    UART1_Write(10); // Transmit a sign the represents a new line
    //    UART1_Write(13);

    while (1) { // Infinite loop
        if (UART1_Data_Ready()) { // If there is a data received,
            uart_rd = UART1_Read(); // read the data,
            if (uart_rd == '$') {
                ++count$;
            }
            if (count$ == 2) {
                break;
            } else if (count$ == 1) {
                if (uart_rd == '.') {
                    ++countWords;
                    break;
                } else if (uart_rd == ' ') {
                    ++countSpace;
                    ++countWords;
                    if (countSpace == 2) {
                        break;
                    }
                } else {
                    countSpace = 0;
                }
            }
        }
    }

    if (countSpace == 2) {
        Lcd_Cmd(_LCD_CLEAR); // clear the screen
        Lcd_Out(1, 1, "ERROR!");
    }
}
