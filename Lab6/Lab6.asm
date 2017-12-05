
_main:

;Lab6.c,19 :: 		void main()
;Lab6.c,21 :: 		cnt = 0; // reset the counter that counts the number of successivelyc licked keys
	CLRF       _cnt+0
	CLRF       _cnt+1
;Lab6.c,22 :: 		Keypad_Init(); // initialize the keypad
	CALL       _Keypad_Init+0
;Lab6.c,23 :: 		ANSEL = 0; // AN pins are configured as digital
	CLRF       ANSEL+0
;Lab6.c,24 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Lab6.c,25 :: 		Lcd_Init(); // initialize the LCD
	CALL       _Lcd_Init+0
;Lab6.c,26 :: 		Lcd_Cmd(_LCD_CLEAR); // clear the screen
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab6.c,27 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // turn off the courser
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab6.c,28 :: 		Lcd_Out(1, 1, "Key :"); // print a message on the LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Lab6+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab6.c,29 :: 		Lcd_Out(2, 1, "Times:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Lab6+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab6.c,30 :: 		do // always wait for one key click
L_main0:
;Lab6.c,32 :: 		kp = 0; // reset kp that stores the numerical value of the key clicked
	CLRF       _kp+0
;Lab6.c,34 :: 		do
L_main3:
;Lab6.c,35 :: 		kp = Keypad_Key_Click(); // store the numerical value of the clicked key in kp
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Lab6.c,36 :: 		while (!kp); //kp will be 0, it a key is not clicked
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;Lab6.c,38 :: 		switch (kp)
	GOTO       L_main6
;Lab6.c,40 :: 		case 1: kp = 49; break; // 1
L_main8:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,41 :: 		case 2: kp = 50; break; // 2
L_main9:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,42 :: 		case 3: kp = 51; break; // 3
L_main10:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,43 :: 		case 4: kp = 65; break; // A
L_main11:
	MOVLW      65
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,44 :: 		case 5: kp = 52; break; // 4
L_main12:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,45 :: 		case 6: kp = 53; break; // 5
L_main13:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,46 :: 		case 7: kp = 54; break; // 6
L_main14:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,47 :: 		case 8: kp = 66; break; // B
L_main15:
	MOVLW      66
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,48 :: 		case 9: kp = 55; break; // 7
L_main16:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,49 :: 		case 10: kp = 56; break; // 8
L_main17:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,50 :: 		case 11: kp = 57; break; // 9
L_main18:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,51 :: 		case 12: kp = 67; break; // C
L_main19:
	MOVLW      67
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,52 :: 		case 13: kp = 42; break; // *
L_main20:
	MOVLW      42
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,53 :: 		case 14: kp = 48; break; // 0
L_main21:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,54 :: 		case 15: kp = 35; break; // #
L_main22:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,55 :: 		case 16: kp = 68; break; // D
L_main23:
	MOVLW      68
	MOVWF      _kp+0
	GOTO       L_main7
;Lab6.c,56 :: 		}
L_main6:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main23
L_main7:
;Lab6.c,57 :: 		if (kp != oldstate)
	MOVF       _kp+0, 0
	XORWF      _oldstate+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
;Lab6.c,60 :: 		cnt = 1;
	MOVLW      1
	MOVWF      _cnt+0
	MOVLW      0
	MOVWF      _cnt+1
;Lab6.c,61 :: 		oldstate = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldstate+0
;Lab6.c,62 :: 		}
	GOTO       L_main25
L_main24:
;Lab6.c,66 :: 		cnt++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;Lab6.c,67 :: 		}
L_main25:
;Lab6.c,68 :: 		Lcd_Chr(1, 10, kp); // print the ASCII code on LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Lab6.c,69 :: 		if (cnt == 255)
	MOVLW      0
	XORWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVLW      255
	XORWF      _cnt+0, 0
L__main28:
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;Lab6.c,72 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;Lab6.c,73 :: 		Lcd_Out(2, 10, " ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Lab6+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab6.c,74 :: 		}
L_main26:
;Lab6.c,75 :: 		WordToStr(cnt, txt); // transform the value of the counter to string
	MOVF       _cnt+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _cnt+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Lab6.c,76 :: 		Lcd_Out(2, 10, txt); // show the value of the counter on LCD
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab6.c,77 :: 		} while (1);
	GOTO       L_main0
;Lab6.c,78 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
