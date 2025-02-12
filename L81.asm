;Lab 8 Program 1
;display string
.MODEL SMALL
.STACK 100H

.DATA
   STR DB "THIS IS MICROPROCESSOR LAB",'$' 

.CODE 
   MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,STR
    MOV AH,09H
    INT 21H   
           
    MOV AX,4C00H
    INT 21H
    
    
MAIN ENDP
END MAIN