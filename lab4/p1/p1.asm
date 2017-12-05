
_main:

;p1.c,1 :: 		void main() {
;p1.c,2 :: 		int c = 0;
	CLRF       main_c_L0+0
	CLRF       main_c_L0+1
;p1.c,4 :: 		int s = 0B10000000;
	MOVLW      128
	MOVWF      main_s_L0+0
	MOVLW      0
	MOVWF      main_s_L0+1
;p1.c,6 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;p1.c,7 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;p1.c,10 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;p1.c,11 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;p1.c,15 :: 		while(1) {
L_main0:
;p1.c,16 :: 		if (PORTB.B0 == 1) {
	BTFSS      PORTB+0, 0
	GOTO       L_main2
;p1.c,17 :: 		s=0B10000000;
	MOVLW      128
	MOVWF      main_s_L0+0
	CLRF       main_s_L0+1
;p1.c,18 :: 		PORTB=s;
	MOVLW      128
	MOVWF      PORTB+0
;p1.c,19 :: 		}else {
	GOTO       L_main3
L_main2:
;p1.c,20 :: 		if(c == 2) {
	MOVLW      0
	XORWF      main_c_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVLW      2
	XORWF      main_c_L0+0, 0
L__main7:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;p1.c,21 :: 		s = s << 1;
	RLF        main_s_L0+0, 1
	RLF        main_s_L0+1, 1
	BCF        main_s_L0+0, 0
;p1.c,22 :: 		c = 0;
	CLRF       main_c_L0+0
	CLRF       main_c_L0+1
;p1.c,23 :: 		} else {
	GOTO       L_main5
L_main4:
;p1.c,25 :: 		s = s >> 1;
	RRF        main_s_L0+1, 1
	RRF        main_s_L0+0, 1
	BCF        main_s_L0+1, 7
	BTFSC      main_s_L0+1, 6
	BSF        main_s_L0+1, 7
;p1.c,26 :: 		c = c + 1;
	INCF       main_c_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_c_L0+1, 1
;p1.c,27 :: 		}
L_main5:
;p1.c,28 :: 		PORTB=s;
	MOVF       main_s_L0+0, 0
	MOVWF      PORTB+0
;p1.c,30 :: 		}
L_main3:
;p1.c,31 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
	NOP
;p1.c,32 :: 		}
	GOTO       L_main0
;p1.c,33 :: 		}
	GOTO       $+0
; end of _main
