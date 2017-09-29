	TITLE	PGM16_2A:  
.MODEL SMALL
.DATA
.STACK
.CODE
DRAW_ROW	MACRO	X
	LOCAL	L1
;draws a line in row X from column 10 to column  300
	MOV	AH,0CH	;draw pixel
	MOV	AL,1	;cyan
	MOV	CX,10	;column 10
	MOV	DX,X	;row X
L1:	INT	10H
	INC	CX	;next column
	CMP	CX,301	;beyond column 300?
	JL	L1	;no, repeat
	ENDM
;
DRAW_COLUMN	MACRO	Y
	LOCAL	L2
;draws a line in column Y from row 10 to row 189
	MOV	AH,0CH	;draw pixel
	MOV	AL,1	;cyan
	MOV	CX,Y	;column Y
	MOV	DX,10	;row 10
L2:	INT	10H	
	INC	DX	;next row
	CMP	DX,190	;beyond row 189?
	JL	L2	;no, repeat
	ENDM
;
SET_DISPLAY_MODE	PROC
;sets display mode and draws boundary
	MOV  AH,0	;set mode
	MOV  AX,13H	;modå 4¬ 32°x20° ´ color
	INT  10H
	;MOV  AH,0BH	;selecô palettå 
	;MOV  BH,1
	;MOV  BL,1	;palettå 1
	;INT  10H	;
	;MOV  BH,0	;seô backgrounä coloò 
	;MOV  BL,2	;green
	;INT  10H
;draw boundary
	;DRAW_ROW	10	;drwaw row 10
	;DRAW_ROW	189	;draw row 189
	;DRAW_COLUMN	10	;draw column 10
	;DRAW_COLUMN	300	;draw column 300
	RET
SET_DISPLAY_MODE    ENDP
;
DISPLAY_BALL	PROC
;displays ball at column CX and row DX with color given in AL
;inputº AÌ ½ coloò oæ ball
;	CØ ½ column
;	DØ ½ row
	MOV  AH,0CH	;writå pixel
	INT  10H
	INC  CX		;pixeì  oî nexô column
	INT  10H
	INC  DX		;dowî ± row
	INT  10H
	DEC  CX		;previouó column
	INT  10H
	DEC  DX		;restorå DX
	RET
DISPLAY_BALL	ENDP

main proc
 
    MOV	AX,@DATA
	MOV	DS,AX		;initialize DS
;
    ;call SET_DISPLAY_MODE
    mov AH, 0   ; graphics mode
    mov AX, 13h
    int 10h
    
    
    MOV	CX,298
	MOV	DX,100
	MOV	AL,3          ;whitå ball
    call DISPLAY_BALL
     
;return to DOS
	MOV	AH,4CH		;return
	INT	21H		;to DOS    
       
main endp    
END main
