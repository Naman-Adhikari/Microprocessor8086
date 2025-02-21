;LAB 10 PROGRAM 7
;Write an assembly language program that reads a number from the user and displays the
;multiplication table of it on the screen.

.MODEL SMALL
.STACK 100H

.DATA
    INPUT DB 4,?,3 DUP ('?')
    PROMPT1 DB "Enter upto 3 digit number: $"
    PROMPT2 DB 10,"Multiplication table upto 10: $"
    HEXINPUT DW ?
    
    TEN DB 10
    TEMPBCD DB 5 DUP ('?')
    TEMPCOUNT DB ?

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        ;DISPLAY INPUT MESSAGE (PROMPT 1)
        LEA DX,PROMPT1
        MOV AH,09H 
        INT 21H

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
        
        MOV HEXINPUT,AX

        ;DISPLAY OUTPUT MESSAGE (PROMPT 2)
        LEA DX,PROMPT2
        MOV AH,09H 
        INT 21H
        
        MOV CX,10       ;DO 10 NUMBERS
        XOR BX,BX       
        MOV DI,0AH      ;FOR BCD DIVISON
        
        ;CALCULATE INPUTX2 THROUGH INPUTX9 AND STORE IN TEMPBCD AND DISPLAY
L2:     CALL NEWLINE
        LEA SI,TEMPBCD
        ADD BX,HEXINPUT ;MULTIPLY BY REPEATED ADDITION
        MOV AX,BX       ;MOVE TO AX TO BE CONVERTED TO BCD
        CALL CONVBCD
        LOOP L2

        MOV AX,4C00H
        INT 21H  
MAIN ENDP

CONVBCD PROC    
;CONVERTS DATA OF REGISTER AX TO BCD STORED IN VARIABLE BCDINPUT
;STORED IN REVERSE ORDER IN VARIABLE POINTED BY SI
;CX GIVES NUMBER OF DIGITS
        MOV TEMPCOUNT,00
L3:     XOR DX,DX       
        DIV DI                  ;GENERAL BCD CONVERSION FOR 16 BIT NUMBER
        ADD DL,30H              ;CONVERT BCD TO ASCII BY ADDING 30H FOR CONVENIENCE
        MOV [SI],DL             ;MOVE REMAINDER TO BCD VARIABLE
        INC BYTE PTR TEMPCOUNT
        INC SI                  ;MOVE TO NEXT BYTE OF BCD
        CMP AX,0000             ;LOOP UNTIL QUOTIENT IS 0
        JNE L3
        
        DEC SI

        ;DISPLAY THE BCD NUMBER
        MOV AH,02H
L4:     MOV DL,[SI]
        DEC SI
        INT 21H
        DEC BYTE PTR TEMPCOUNT
        JNZ L4
        RET
CONVBCD ENDP

NEWLINE PROC
        MOV AH,02H
        MOV DL,0AH ;GO TO NEW LINE
        INT 21H
        RET
NEWLINE ENDP

END MAIN