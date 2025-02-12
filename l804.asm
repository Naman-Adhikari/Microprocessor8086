.Model small
.stack 100h
.data
	str db 50, ?, 50 DUP("$")
	newline db 0Dh, 0ah, "$"
	prompt db "Enter a string:", "$"
.code

main proc far
	mov ax, @data
	mov ds, ax

	lea dx, prompt
	mov ah, 09h
	int 21h
	lea di, str

l1: mov ah, 01h
	int 21h
	cmp al, 0dh
	je end
	mov [di], al
	inc di
	jmp l1

end: mov byte ptr [di], "$"

	mov ah, 09h
	lea dx, str
	int 21h

	mov ax, 4c00h
	int 21h
	main endp
	end main

