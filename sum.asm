.model small
.stack 100h
.data
	sum db 0

.code
	main proc far
	mov ax, @data
	mov ds, ax

	mov cx, 50
	mov ax, 0
	mov bx, 0

l1: add ax, cx
	mov bx, ax
	loop l1

	mov ax, 4c00h
	int 21h

	main endp
	end main
