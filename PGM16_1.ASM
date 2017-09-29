	TITLE	PGM16_1: CGA LINE DRAWING
;draws horizontal line in high res 
;in row 100 from col 301 to col 600
.MODEL	SMALL
.STACK	100H
;
.CODE
MAIN	PROC
;set graphics mode
	;MOV	AX,6		;select mode 6, hi res
	;INT	10H
	mov AH, 0   ; graphics mode
    mov AX, 13h
    int 10h
    
    MOV  AH, 11  ;function  OBh 
    MOV  BH, 0  ;select  background  color 
    MOV  BL,3  ;blue
    INT	10H
    
;draw line
	MOV	AH,0CH		;write pixel
	MOV	AL,2		;fg color
	MOV Bl,5        ; vua, not bg
	MOV	CX,20		;beginning col
	MOV	DX,20		;row

L1:	INT	10H		
	INC	CX		    ;next col
	CMP	CX,100		;more columns?
	JLE	L1		    ;yes, repeat

;read keyboard
	MOV	AH,0
	INT	16H
;set to text mode
	MOV	AX,3		;select mode 3, text mode
	INT	10H
;return to DOS
	MOV	AH,4CH		;return
	INT	21H		;to DOS
MAIN	ENDP
	END	MAIN
