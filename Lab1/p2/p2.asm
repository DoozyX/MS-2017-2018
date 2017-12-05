; multi-segment executable file template.

data segment
    ; add your data here!
    enter db "Enter char: $"
    char db ?
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

    ;enter char text
    lea dx, enter
    mov ah, 9
    int 21h 
    
  
    ;read char
    mov ah ,01h
    int 21h
    
    ;save the char  
    mov char, al
    
    ;if letter
    ;if smaller then z
    if: cmp char, 7Bh 
    ja else
        ;c              
        if2: cmp char, 60h 
            jb else2
                ;more then a 
                mov AH, char
                mov DS:[20h], AH
                
                inc char
                mov AH, char
                mov DS:[21h], AH
                
                dec char
                dec char
                mov AH, char
                mov DS:[1Fh], AH
                
                inc char
                ;if a
                if3: cmp char, 61h 
                    jne endif3
                    ;print YES
                    mov AH, 0
                    mov DS:[1Fh], AH
                endif3:
                
                ;if z
                if4: cmp char, 7Ah 
                    jne endif4
                    ;print YES
                    mov AH, 0
                    mov DS:[21h], AH
                endif4:
                
            jmp endif2
            else2:
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
        endif2:
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
