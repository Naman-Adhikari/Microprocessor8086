;lab 9 program 3
; take upto 24 character string and display each character at centre of line

.MODEL SMALL
.STACK 100H

.DATA
    STR DB 25,?, 25 DUP('?')
    PROMPT1 DB "Enter a string: $"

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        ;DISPLAY PROMPT 1
        LEA DX, PROMPT1
        MOV AH, 09H
        INT 21H

        ;STORE ENTERED STRING IN STR
        LEA DX,STR
        MOV AH,0AH
        INT 21H

        ;INITIALIZE DISPLAY
        MOV AX,0002H 
        INT 10H

        ;START AT CENTRE OF FIRST ROW
        MOV DH,00
        MOV DL,40
        
        LEA SI,STR+2
        XOR CX,CX
        MOV CL,[SI-1]

    L1: MOV AH,02H
        INT 10H
        MOV AL,[SI]
        MOV AH,0EH
        INC SI
        INC DH
        INT 10H 
        LOOP L1

        MOV AH,08H ;FREEZE SCREEN
        INT 21H

        MOV AX,4C00H
        INT 21H

    MAIN ENDP
    END MAIN