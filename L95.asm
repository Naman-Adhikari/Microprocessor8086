;lab 9 program 3
; take upto 24 character string and display each character at centre of line

.MODEL SMALL
.STACK 100H

.DATA
    STR DB "Programming In Assembly Language is Fun$"
    LEN DB $-STR
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        ;INITIALIZE DISPLAY
        MOV AX,0002H 
        INT 10H

        ;START AT CENTRE OF FIRST ROW
        MOV DH,00
        MOV DL,00
        MOV AH,02H 
        INT 10H
        
        LEA SI,STR
        XOR CX,CX
        MOV CL,LEN
        DEC CL

    L1: MOV AL,[SI]
        CMP AL,' '
        JNE J1
        CALL NEWLINE
    J1: MOV AH,0EH
        INC SI
        INC DL
        INT 10H 
        LOOP L1

        MOV AH,08H ;FREEZE SCREEN
        INT 21H

        MOV AX,4C00H
        INT 21H

    MAIN ENDP

    NEWLINE PROC
        INC DH
        MOV AH,02H
        INT 10H
        RET
    NEWLINE ENDP

    END MAIN