.MODEL small
.stack 100h
.data
	str db " We are electronics students","$"
len dw $-STR-1

.code
main proc 
	mov ax, @data
	mov ds, ax

	mov si, 0
	mov cx, len

l1: mov dl, [str+si]
	mov ah, 02h
	int 21h

	inc si
	loop l1

	mov ax, 4C00h
	int 21h

	main endp
	end main
