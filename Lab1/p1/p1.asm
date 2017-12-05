; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    x db 5d
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

    ; add your code here   
    ;1.
    mov CX, 51539d  
    
    ;2.
    mov AL, 00000111b
    and AL, CL
    if: cmp AL, 00000111b
    jne else
        ;CF:0, ZF:1, SF:0, OF:0, PF:1, AF:0, IF:1, DF:0
        ;print Y if index matches 111 last 3 bits
        mov DL, 59h
        mov AH, 02h  
        int 21h
         
        ;new line      
        mov DL, 10d
        mov AH, 02h  
        int 21h
        
        jmp endif
    else:
        ;CF:1, ZF:0, SF:1, OF:0, PF:1, AF:1, IF:1, DF:0
        mov DL, 4Eh
        mov AH, 02h  
        int 21h
         
        ;new line      
        mov DL, 10d
        mov AH, 02h  
        int 21h
    endif:
     
    ;3.
    mov AL, 5d
    mov BL, x
    mul BL
    mov DH, AL
    sub DH, 21d
    
    ;4.
    mov DL, DH
    add DL, 30h
    mov AH, 02h  
    int 21h
    
    ;new line      
    mov DL, 10d
    mov AH, 02h  
    int 21h
        
         
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
