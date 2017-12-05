data segment
    ; add your data here!
    enter db "enter number: $"
    digit1 db ?
    digit2 db ?
    sum dw 0
    num db ?
    divisor db 3d
ends

stack segment
    dw   128  dup(0)
ends

code segment
sumndivproc proc
    cmp bx, 1
    je endproc
        push bx
        dec bx
        call sumndivproc
        pop bx
        
        mov ax, bx
        div divisor
        
        cmp ah, 0
        jne continue                
            add sum, bx
        continue:
    endproc:   ret
sumndivproc endp
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
    mov num, al
    
    MOV AX, 1
    MOV BL, num
    MOV BH, 0
    
    call sumndivproc
    

    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
