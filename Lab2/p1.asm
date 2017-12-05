; multi-segment executable file template.

data segment
	; add your data here!
	enter db "Enter number: $" 
	sum dw ?
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
	
	
	read:
	mov ah ,01h
	int 21h
		          
	cmp al, 23h
	je endloop
	
	    sub al, 30h

	    mov ah, 0
	    mov dx, ax
	    mov bl, 2d
	    div bl
	    cmp ah, 0
	    jne read
	        add sum, dx
	jmp read 
	endloop: 
	
	mov ax, 4c00h ; exit to operating system.
	int 21h	   
ends

end start ; set entry point and stop the assembler.
