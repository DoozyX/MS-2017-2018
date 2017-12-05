
_main:

;p2.c,3 :: 		void main() {
;p2.c,4 :: 		int s = 0B01101101;
	MOVLW      109
	MOVWF      main_s_L0+0
	MOVLW      0
	MOVWF      main_s_L0+1
	MOVLW      63
	MOVWF      main_o_L0+0
	MOVLW      0
	MOVWF      main_o_L0+1
	CLRF       main_c_L0+0
	CLRF       main_c_L0+1
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;p2.c,9 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;p2.c,10 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;p2.c,13 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;p2.c,14 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;p2.c,18 :: 		while(1) {
L_main0:
;p2.c,19 :: 		if ( PORTE.B0 == 1 ) {
	BTFSS      PORTE+0, 0
	GOTO       L_main2
;p2.c,20 :: 		PORTB = s;           -
	MOVF       main_s_L0+0, 0
	MOVWF      PORTB+0
;p2.c,22 :: 		} else {
	GOTO       L_main3
L_main2:
;p2.c,23 :: 		i = i + 1;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;p2.c,24 :: 		EEPROM_Write(0x80, i);
	MOVLW      128
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;p2.c,25 :: 		EEPROM_Write(0x80 + i, c);
	MOVF       main_i_L0+0, 0
	ADDLW      128
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       main_c_L0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;p2.c,26 :: 		c = 0;
	CLRF       main_c_L0+0
	CLRF       main_c_L0+1
;p2.c,27 :: 		PORTB = o;
	MOVF       main_o_L0+0, 0
	MOVWF      PORTB+0
;p2.c,28 :: 		}
L_main3:
;p2.c,29 :: 		Delay_ms(25);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
;p2.c,30 :: 		}
	GOTO       L_main0
;p2.c,31 :: 		}
	GOTO       $+0
; end of _main
