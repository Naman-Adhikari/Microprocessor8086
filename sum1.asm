.model small
.stack 100h
.data
    sum dw 0   ; Changed to word for correct storage

.code
main proc far
    mov ax, @data
    mov ds, ax

    mov cx, 50
    mov ax, 0

l1: add ax, cx
    loop l1

    mov sum, ax  ; Store the result properly

    mov ax, 4c00h
    int 21h

main endp
end main

