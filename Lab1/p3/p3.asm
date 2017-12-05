; multi-segment executable file template. 

;Problem 3: A two-digit number is inserted from the keyboard. Store that number in a variable
;num. Find the residual of the division of that number with 7 and store the result value in a
;variable residual.
;Check if the number is divisible by 7 and if yes, print three characters ("YES") on the display

data segment
    ; add your data here!
    enter db "enter number: $"
    digit1 db ?
    digit2 db ?
    num dw ?
    residual db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
	
    ;enter digits text
    lea dx, enter
    mov ah, 9
    int 21h
    
    ;read first digit
    mov ah ,01h
    int 21h
    
    ;save to digit1
    sub al, 30h
    mov digit1, al
    
    ;read second digit
    mov ah,01h
    int 21h
    
    ;store in digit2
    sub al, 30h
    mov digit2, al
    
   
    ;mul 10
    mov al, digit1
    mov bl, 10d
    mul bl
     
    ;add second digit
    add al, digit2
    
    ;save number
    mov num, ax
   
    ;devide(ax-must/reg)
    mov bl, 7d
    div bl 
    
    ;save residual
    mov residual, ah
    
    ;new line      
    mov DL, 10d
    mov AH, 02h  
    int 21h
    
    if: cmp residual, 0
    jne else
        ;print YES
        mov DL, 59h
        mov AH, 02h  
        int 21h
        
        mov DL, 45h
        mov AH, 02h  
        int 21h
        
        mov DL, 53h
        mov AH, 02h  
        int 21h
         
        ;new line      
        mov DL, 10d
        mov AH, 02h  
        int 21h
        
        jmp endif
    else:
        ;NO
        mov DL, 4Eh
        mov AH, 02h  
        int 21h
        
        mov DL, 4Fh
        mov AH, 02h  
        int 21h
         
        ;new line      
        mov DL, 10d
        mov AH, 02h  
        int 21h
    endif:
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
