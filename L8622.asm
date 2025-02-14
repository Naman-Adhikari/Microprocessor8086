.model small
.stack 100h
.data
str db "Programming in Assembly is Fun", "$"
	len db $-str
.code
	main proc far
	mov ax, @data
	mov ds, ax

	mov ax, 0002h
	int 10h

	mov ch, 05
	mov cl, 20
	mov dh, 20
	mov dl, 60
    mov bh, 70h
	mov ah, 07h
	mov al, 00
	int 10h

	mov bh, 00
	mov dh, 12
	mov dl, 30
	mov ah, 02h
	int 10h
	lea si, str
	xor cx, cx
	mov cl, len
	dec cx
	mov ah, 0eh
l1: mov al, [si]
	inc si
	int 10h
	loop l1

	mov ah, 08h
	int 21h

	mov ah, 4ch
	int 21h

	main endp
	end main



