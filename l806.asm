.model small
.stack 100h
.data
	str db 50, ?, 50 dup("$")
	prompt1 db "enter a string:", "$"
	prompt2 db 13,10, "The entered string: ", "$"
.code
	main proc far
	mov ax, @data
	mov ds, ax
	lea dx, prompt1
	mov ah, 09h
	int 21h
	lea dx, str
	mov ah, 09h
	int 21h
	lea dx, prompt2
	mov ah, 09h
	int 21h
	lea bx, str
	add bx, 2
	mov ah, 02h
	mov dl, 0ah
	int 21h
l1: mov dl, [bx]
	cmp dl, '$'
	je skip
	cmp dl, ' '
	jne next
	call newline
next: int 21h
	inc bx
	loop l1
skip: mov ax, 4c00h
	int 21h
	main endp 
	newline proc
	mov dl, 10
	ret
	newline endp
	end main
	
	
