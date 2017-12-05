; multi-segment executable file template.

data segment
    ; add your data here!
    enter dw "enter char: $"
    array db 10 dup ? 
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
            
    lea dx, enter
    mov ah, 9
    int 21h
    
    mov cx, 10d
    mov bx, 0
   
    enterArray:
    ;read first digit
    mov ah, 01h
    int 21h
    
    ;save to digit1
    mov array[bx], al
    inc bx
    loop enterArray
             
    mov dx, 0; x
    mov bx, 0
    
    cmp array[bx], 41h
        jb endif
        cmp array[bx], 5Ah
            ja endif
            inc dx
    endif:
    
    mov cx, 9d
    
    for:
        ;if number below
        cmp array[bx], 30h
        jb endifn
            cmp array[bx], 39h
            ja endifn
                ;if next is letter
                inc bx
                cmp array[bx], 41h
                jb endifd
                    cmp array[bx], 5Ah
                    ja endifd
                        mov al, array[bx]
                        mov ah, bl
                        mov bl, dl
                     
                        mov array[bx], al
                        
                        mov bl, ah 
                        inc dx
                endifd:
                dec bx         
        
        endifn:
        inc bx
    loop for
    
    mov cx, 10d
    sub cx, dx
    mov bx, dx
    
    clear:
        mov array[bx], 0
        inc bx
    loop clear 
   
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
