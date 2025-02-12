.MODEL SMALL
.STACK 100H

.DATA
    BUFFER_SIZE DB 30   ; Maximum characters to read (excluding Enter key)
    ACTUAL_LEN  DB ?    ; Actual length (stored by DOS, excluding Enter key)
    STR         DB 30 DUP('$')  ; Input buffer (30 bytes, initialized with '$')

    NEWLINE DB 0DH, 0AH, '$'   ; New line characters

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX          ; Initialize data segment

    ; Prompt user
    MOV DX, OFFSET NEWLINE
    MOV AH, 09H
    INT 21H             ; Print new line

    MOV DX, OFFSET STR  ; Load string buffer address into DX
    MOV AH, 0AH         ; DOS function to read string
    INT 21H             ; Call DOS interrupt

    ; Print new line
    MOV DX, OFFSET NEWLINE
    MOV AH, 09H
    INT 21H             ; Move to new line

    ; Display the string
    MOV SI, OFFSET STR+2  ; Skip first 2 bytes (max length & actual length)
    MOV CX, ACTUAL_LEN    ; Get actual string length
    MOV AH, 02H           ; DOS function to print character

PRINT_LOOP:
    MOV DL, [SI]          ; Load character
    INT 21H               ; Print character
    INC SI                ; Move to next character
    LOOP PRINT_LOOP       ; Repeat for all characters

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN

