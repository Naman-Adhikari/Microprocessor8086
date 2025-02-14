;Lab 9 Program 1
; read a string as input from user and display the string at centre of clear screnen

.MODEL SMALL
.STACK 100H

.DATA
    STR DB 60,?, 60 DUP('?')
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

        ;CENTERING LOGIC
        MOV AL,STR+1
        MOV BL,2
        DIV BL
        MOV CX,AX
        MOV DH,12
        MOV DL,40
        SUB DL,CL

        ;MOVE CURSOR
        MOV AH,02H 
        INT 10H

        LEA SI,STR     ; START OF STR
        ADD SI,2
        XOR CX,CX
        MOV CL,[SI-1]  ; LENGTH OF STRING
        MOV AH,0EH
        
    L1: MOV AL,[SI]
        INT 10H
        INC SI
        LOOP L1

        MOV AH,08H ;FREEZE SCREEN
        INT 21H

        MOV AX,4C00H
        INT 21H

    MAIN ENDP
    END MAIN