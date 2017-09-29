public screen
.MODEL SMALL
 .DATA
 VAR DW 2 DUP(470)
.STACK
.CODE
 SCREEN PROC
    
    MOV DX,0
    
    MOV AL,1001b
    LP1:
    MOV CX,170
    CMP DX,480
    JE EXIT
    INC DX
    LP2:
    CMP CX,VAR
    JE LP1
    MOV  AH,0CH	
	INT  10H 
	INC CX
	JMP LP2
	EXIT:
	RET
	SCREEN ENDP
 END