	TITLE	PGM16_2C:
;contains MOVE_BALL and CHECK_BOUNDARY procedures
	EXTRN	DISPLAY_BALL:NEAR
	EXTRN	TIMER_FLAG:BYTE, VEL_X:WORD, VEL_Y:WORD
	PUBLIC	MOVE_BALL
.MODEL SMALL
.CODE
MOVE_BALL	PROC
;eras� bal� a� curren� positio� an� displa� bal� a� ne� position
;input�  C� � column of ball position
;        D� � row of ball position
;erase ball
	MOV	AL,0		;colo� � i� backgroun� color
	CALL	DISPLAY_BALL	;erase ball
;get new position
      	ADD	CX,VEL_X
	ADD	DX,VEL_Y
;chec� boundary
        CALL    CHECK_BOUNDARY
;wai� fo� � time� tick to display ball
TEST_TIMER:
	CMP	TIMER_FLAG,1	;time� ticked?
	JNE	TEST_TIMER	;no� kee� testing
	MOV	TIMER_FLAG,0	;yes, reset flag
	MOV	AL,3		;white color
	CALL	DISPLAY_BALL	;show ball
        RET
MOVE_BALL	ENDP
;
CHECK_BOUNDARY	PROC
;determin� i� bal� i� outsid� screen� i� s� mov� i� bac� i� and 
;chang� th� bal� direction
;input�  C� � column of ball position
;        D� � row of ball position
;output: CX = column of ball position
;	 DX = row of ball position
;chec� colum� value
	CMP	CX,11	;lef� o� 11?
	JG	L1	;no� go check right margin
	MOV	CX,11	;yes� se� to 11
	NEG	VEL_X	;chang� direction
	JMP	L2	;g� tes� ro� boundary
L1:	CMP	CX,298	;beyon� righ� margin?
	JL	L2	;no, go test row boundary
	MOV	CX,298	;se� colum� t� 298
	NEG	VEL_X	;chang� direction
;chec� ro� value
L2:	CMP	DX,11	;abov� to� margin?
	JG	L3	;no, check bottom margin
	MOV	DX,11	;se� t� 11
	NEG	VEL_Y	;chang� direction
	JMP	DONE	;done
L3:	CMP	DX,187	;belo� botto� margin?
	JL	DONE	;no, done
	MOV	DX,187	;yes� se� t� 187
	NEG	VEL_Y	;chang� direction
DONE:
	RET
CHECK_BOUNDARY	ENDP
	END
