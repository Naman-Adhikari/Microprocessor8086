.model small
.stack 100h
.data
	str db 50, ?, 50 DUP("$")
.code
	main proc far
mov ax, @data
mov ds, ax

lea dx, str
mov ah, 0ah
int 21h

mov dl, 0ah
mov ah, 02h
int 21h

lea bx, str
add bx, 2
mov dx, bx

xor ax, ax	
mov cx, [bx-1]
dec cx

l1: mov al, [bx]
	cmp al, 'a'
	jb next
	sub al, 32
next: mov [bx], al
	inc bx
	loop l1

	mov byte ptr [bx], "$"
	mov ah, 09h
	int 21h

	mov ah, 4ch
	int 21h

	main endp
	end main
