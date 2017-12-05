; multi-segment executable file template.
data segment
    ; add your data here!
    false db "False condition$"
    true db "True condition$"
    inputString db 50 dup(?)
    outputString db 50 dup(?)    
    inputString2 db 50 dup(?)
    outputString2 db 50 dup(?)
    transformations db 0
    count db 0   
ends

stack segment
    dw   128  dup(0)
ends

code segment
toLower proc
    transformString:
        lodsb
        cmp al, 24h
        je endtransformString
        
        cmp al, 40h
        jb transformContinue
            cmp al, 5Bh
            ja transformContinue
                add al, 20h
                inc transformations
        
        transformContinue:
        stosb
          
        jmp transformString
    endtransformString:
    stosb    
    ret
toLower endp    

start:                     
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    lea di, inputString
    
    readString:
        cmp count, 49d
        je endReadString
        inc count
        
        mov ah, 1
        int 21h
        cmp al, 24h
        je endReadString
        
        stosb        
        jmp readString
    endReadString:
    mov al, 24h
    stosb
    
    lea di, inputString2
    mov count, 0d
    
    readString2:
        cmp count, 49d
        je endReadString2
        inc count
        
        mov ah, 1
        int 21h
        cmp al, 24h
        je endReadString2
        
        stosb
        jmp readString2
    endReadString2:
    mov al, 24h
    stosb
    
    lea si, inputString
    lea di, outputString
    call toLower
    
    lea si, inputString2
    lea di, outputString2
    call toLower
    
    lea si, outputString
    lea di, outputString2
    
    MOV CX, 50
    REPE CMPSB 
    JB fail
    JA fail
    
    lea dx, true
    mov ah, 9
    int 21h
    jmp endPF 
    fail:
    lea dx, false
    mov ah, 9
    int 21h
             
    endPF:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
