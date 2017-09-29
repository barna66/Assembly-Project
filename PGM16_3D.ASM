	TITLE	PGM16_3D: PADDLE CONTROL
;contains MOVE_PADDLE and DRAW_PADDLE
	EXTRN	PADDLE_TOP:WORD, PADDLE_BOTTOM:WORD
	PUBLIC	DRAW_PADDLE, MOVE_PADDLE
.MODEL	SMALL
.CODE
DRAW_PADDLE	PROC
;draw paddle in column 11
;input: AL contains pixel value
;	2 (red) for display and 0 (green) to erase
;save registers
	PUSH	CX
	PUSH	DX
;
	MOV	AH,0CH		;write pixel function
	MOV	CX,11		;column 11
	MOV	DX,PADDLE_TOP	;top row
DP1:	INT	10H
	INC	DX		;next row
	CMP	DX,PADDLE_BOTTOM ;done?
	JLE	DP1		;no, repeat
;restore registers
	POP	DX
	POP	CX
	RET
DRAW_PADDLE	ENDP
;
MOVE_PADDLE	PROC
;move paddle up or down
;input:	AX = 2 (to move paddle down 2 pixels)
;	   = -2 (to move paddle up 2 pixels)
	MOV	BX,AX		;copy to BX
;check direction
	CMP	AX,0	
	JL	UP		;neg, move up
;move down, check paddle position
	CMP	PADDLE_BOTTOM,188	;at bottom?
	JGE	DONE		;yes, cannot move
	JMP	UPDATE		;no, update paddle
;move up, check if at top
UP:	CMP	PADDLE_TOP,11	;at top?
	JLE	DONE		;yes, cannot move
;move paddle
UPDATE:	
;--erase paddle
	MOV	AL,0		;green color
	CALL	DRAW_PADDLE
;--change paddle position
	ADD	PADDLE_TOP,BX
	ADD	PADDLE_BOTTOM,BX
;--display paddle at new position
	MOV	AL,2		;red
	CALL	DRAW_PADDLE
DONE:	RET
MOVE_PADDLE	ENDP
	END
