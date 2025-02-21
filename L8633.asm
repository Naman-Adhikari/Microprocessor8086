;LAB 10 PROGRAM 3
;Write a program that reads a string from the keyboard and count the no of vowels in the
;string. Display the count in decimal format.

.MODEL SMALL
.STACK 100H 

.DATA
    PROMPT1 DB "Enter a string: $"
    PROMPT2 DB 10,"The number of vowels is: $"
    VOWEL   DB "aeiouAEIOU$"
    INPUT   DB 100,?,100 DUP('?')
    BCD     DB 5 DUP('?')

.CODE
    MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX

        ;DISPLAY INPUT MESSAGE (PROMPT 1)
        LEA DX,PROMPT1
        MOV AH,09H 
        INT 21H

        ;TAKE INPUT
        LEA DX,INPUT
        MOV AH,0AH
        INT 21H

        MOV BX,DX       ;MOVE ADDRESS OF INPUT TO BX FOR ADDRESSING
        XOR CX,CX
        MOV CL,[BX+1]   ;TAKE ACTUAL LENGTH OF STRING
        ADD BX,2        ;MOVE BX TO BYTE WHERE STRING STARTS
        XOR AX,AX       ;USE AX AS WORD COUNTER
        XOR DX,DX

        ;COUNT NUMBER OF VOWELS
L1:     LEA SI,VOWEL
        CALL VOW
        INC BX
        LOOP L1

        XOR CX,CX        
        LEA BX,BCD
        MOV DX,0AH

        ;CONVERT HEX TO BCD
L2:     XOR AH,AH
        DIV DL
        ADD AH,30H
        MOV [BX],AH
        INC BX
        INC CX
        CMP AL,00
        JNE L2

        DEC BX ;BX IS ONE MORE THAN REQUIRED

        ;DISPLAY OUTPUT MESSAGE (PROMPT 2)
        LEA DX,PROMPT2
        MOV AH,09H 
        INT 21H

        MOV AH,02H
        ;SHOW ASCII VALUE AS OUTPUT
L4:     MOV DL,[BX]
        DEC BX
        INT 21H
        LOOP L4

        MOV AX,4C00H
        INT 21H
    MAIN ENDP

    VOW PROC
LV1:    MOV DL,[SI]
        CMP [BX],DL
        JNE JV1
        INC AX
JV1:    INC SI
        CMP [SI],BYTE PTR '$'
        JNE LV1
        RET
    VOW ENDP


    END MAIN
