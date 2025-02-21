;LAB 10 PROGRAM 9
;Write a program to read ten decimal numbers (up to 16-bits) and store them in memory
;and display the sum in decimal format.

.MODEL SMALL
.STACK 100H

.DATA
    INPUT DB 4,?,3 DUP ('?')
    PROMPT1 DB "Enter 10 3 digit decimal numbers: $"
    PROMPT2 DB 10,"Sum of given 10 numbers is: $"
    TEN DB 10
    INPUTARRAY DW 10 DUP ('?')
    INPCOUNT DB 10
    BCD DB 10 DUP (?)

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        ;DISPLAY INPUT MESSAGE (PROMPT 1)
        LEA DX,PROMPT1
        MOV AH,09H 
        INT 21H

        LEA SI,INPUTARRAY
INP:
        ;TAKE INPUT
        LEA DX,INPUT
        MOV AH,0AH
        INT 21H

        LEA BX,INPUT    ;SET BX AS INPUT ADDRESS 
        INC BX          ;MOVE TO LENGTH BYTE
        XOR CX,CX       ;CLEAR CX   
        MOV CL,[BX]     ;MOV LENGTH INTO CX
        INC BX          ;MOVE TO START OF STRING
        
        ;CLEAR REGISTERS
        XOR AX,AX       
        XOR DX,DX       

        ;CONVERT GIVEN NUMBER TO HEX EQUIVALENT
L1:     MOV DL,[BX]     ;MOV CURRENT BYTE TO DL 
        SUB DL,30H      ;SUB 30 TO TURN ASCII INTO NUMBER
        MUL TEN         ;MULTIPLY BY 10
        ADD AX,DX       ;ADD AX             (IE AX = AX * 10 + DX)
        INC BX          ;MOVE TO NEXT BYTE
        LOOP L1

        MOV [SI],AX
        ADD SI,2
        DEC BYTE PTR INPCOUNT

        MOV AH,02H
        MOV DL,0AH
        INT 21H
        JNZ INP

        LEA SI,INPUTARRAY
        ;CLEARING REGISTERS
        MOV CX,10
        XOR AX,AX
        XOR DX,DX

        ;GET SUM UPTO N
L2:     ADD AX,WORD PTR [SI]
        ADC DX,0
        ADD SI,2
        LOOP L2

        ;CLEARING REGISTERS
        XOR SI,SI
        LEA SI,BCD
        XOR CX,CX
        XOR BX,BX
        MOV BL,0AH

        ;CONVERT SUM TO BCD AND STORE IT IN VARIABLE BCD
        JMP J1
L3:     XOR DX,DX       ;SINCE OUR NUMBER IS TECHNICALLY 32 BIT (DX:AX) FOR THE FIRST OPERATION WE SKIP CLEARING IT ON FIRST LOOP
J1:     DIV BX          ;GENERAL BCD CONVERSION FOR 16 BIT NUMBER
        ADD DL,30H      ;CONVERT BCD TO ASCII BY ADDING 30H FOR CONVENIENCE
        MOV [SI],DL     ;MOVE REMAINDER TO BCD VARIABLE
        INC CX          ;COUNT NUMBER OF DIGITS STORED
        INC SI          ;MOVE TO NEXT BYTE OF BCD
        CMP AX,0000     ;LOOP UNTIL QUOTIENT IS 0
        JNE L3

        ;DISPLAY OUTPUT MESSAGE (PROMPT 2)
        LEA DX,PROMPT2
        MOV AH,09H 
        INT 21H

        MOV AH,02H ;CHARACTER CONSOLE OUTPUT
        DEC SI     ;VALUE OF SI IS ONE MORE THAN REQUIRED SO DECREASE IT

        ;SHOW ASCII VALUE AS OUTPUT
L4:     MOV DL,[SI]
        DEC SI
        INT 21H
        LOOP L4

        MOV AX,4C00H
        INT 21H  
MAIN ENDP
END MAIN