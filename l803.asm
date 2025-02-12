.Model small
.stack 100h
.data

	str DB 50, ?, 50 DUP("$")
	newline  db 0DH, 0AH, , "$"
	ask db "Enter a string:" , "$"

.code
main proc far
	mov ax, @data
	mov ds, ax

	lea Dx, ask
	mov ah, 09h
	int 21h

	lea dx, str
	mov ah, 0ah
	int 21h

	lea dx , newline
	mov ah, 09h
	int 21h

	lea dx, str+2
	mov ah, 09h
	int 21h

	mov ah, 4ch
	int 21h

	main endp
	end main
