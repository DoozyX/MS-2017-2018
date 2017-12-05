; multi-segment executable file template.

data segment
	; add your data here!
	print db "The values of the matrix are:$"
	matrix dw 300, 231, 333, 23, 24, 56, 6, 5, 4
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
	
	;text
	lea dx, print
	mov ah, 9
	int 21h
	
	for:	
	mov ah, 01h
	int 21h

	cmp al, 23h
	je end:
		mov ch, al;save i
		sub ch, 30h
		
		mov ah, 01h
		int 21h
		
		mov cl, al; save j
		sub cl, 30h
		
		mov al, 3d
		mul ch
		
		add al, cl
		
		mov bx, ax
		add bx, bx
		
		mov ax, matrix[bx]
		
		;check 3 digits
		mov dl, 100d
		div dl
		
		cmp al, 0
		ja its3:
			mov ax, matrix[bx]
		
			;check digits
			mov dl, 10d
			div dl
			cmp al, 0
			ja its2
				mov ax, 1
				mov matrix[bx], ax
				jmp for
			its2:
				mov ax, 2
				mov matrix[bx], ax
				jmp for			   
		its3:
			mov ax, 3
			mov matrix[bx], ax			   
		jmp for			 
	end:
	mov ax, 4c00h ; exit to operating system.
	int 21h	   
ends

end start ; set entry point and stop the assembler.
