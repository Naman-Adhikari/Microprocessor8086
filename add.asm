.MODEL SMALL
.STACK 100H
.DATA
    SUM DW 0  ; Variable to store the final sum

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX  ; Initialize the Data Segment

    MOV CX, 255  ; Counter for numbers 1 to 255
    MOV AX, 0    ; Initialize sum to 0
    MOV DX, 1    ; Start with number 1

ADD_LOOP:
    ADD AX, DX   ; Add current number to AX
    INC DX       ; Increment number
    LOOP ADD_LOOP ; Loop until CX = 0

    MOV SUM, AX  ; Store result in memory

    MOV AX, 4C00H ; Terminate program
    INT 21H

MAIN ENDP
END MAIN

