	.MODEL SMALL
.STACK 100H

.DATA
    prompt DB 'Enter a string: $'  ; Prompt message
    inputBuffer DB 100             ; Max length of input
                DB ?                ; Actual length of input
                DB 100 DUP('$')      ; Buffer to store user input
    newLine DB 13, 10, '$'          ; Newline sequence for output

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt message
    MOV DX, OFFSET prompt
    MOV AH, 09H
    INT 21H

    ; Read user input
    MOV DX, OFFSET inputBuffer
    MOV AH, 0AH
    INT 21H

    ; Process the input string and print words line by line
    LEA SI, inputBuffer + 2      ; Skip input buffer metadata
PRINT_LOOP:
    MOV DL, [SI]                ; Load character from input buffer
    CMP DL, ' '                 ; Check for space
    JE PRINT_NEWLINE             ; If space, go to newline handling
    CMP DL, 0DH                 ; Check for Enter (carriage return)
    JE DONE                      ; If Enter, exit loop
    MOV AH, 02H                 ; DOS function to print a character
    INT 21H
    INC SI
    JMP PRINT_LOOP

PRINT_NEWLINE:
    LEA DX, newLine
    MOV AH, 09H
    INT 21H
    INC SI
    JMP PRINT_LOOP

DONE:
    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN

