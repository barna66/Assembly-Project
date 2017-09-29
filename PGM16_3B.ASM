	TITLE	PGM16_3B: BALL MOVEMENT
;contains MOVE_BALL_A and  CHECK_BOUNDARY_A
	EXTRN	DISPLAY_BALL:NEAR, BEEP:NEAR
	EXTRN	TIMER_FLAG:BYTE, VEL_X:WORD, VEL_Y:WORD
	PUBLIC	MOVE_BALL_A
.MODEL SMALL
.CODE
MOVE_BALL_A PROC
;erase ball at current position and display ball at new position
;inputº  CX = column
;        DX = row
;output: CX = column
;	DX = row
	MOV	AL,0	           ;color 0 is background color
	CALL	DISPLAY_BALL       ;erase ball
;get new position
      	ADD	CX,VEL_X
	ADD	DX,VEL_Y
;check boundary
        CALL    CHECK_BOUNDARY_A
;wait for 1 timer tick
TEST_TIMER_1:
	CMP	TIMER_FLAG,1	;timer ticked?
	JNE	TEST_TIMER_1	;no¬ keep testing
	MOV	TIMER_FLAG,0	;yes, clear flag
	MOV	AL,3		;white color
	CALL	DISPLAY_BALL	;show ball
        RET
MOVE_BALL_A ENDP
;
CHECK_BOUNDARY_A PROC
;determine if ball is outside screen, if so move it back in and 
;change the ball direction
;inputº  CX = column
;        DX = row
;outputº  CX = column
;        DX = row
;check column value
	CMP	CX,11	;left of 11?
	JG	L1	;no, go check right margin
	MOV	CX,11	;yes¬ set to 11
	NEG	VEL_X	;change direction
	CALL	BEEP	;sound beep
	JMP	L2	;go test row boundary
L1:	CMP	CX,299	;beyond right margin?
	JL	L2	;no, go test row boundary
	MOV	CX,298	;set column to 298
	NEG	VEL_X	;change direction
	CALL	BEEP	;sound beep
;check row value
L2:	CMP	DX,11	;above top margin?
	JG	L3	;no, check bottom margin
	MOV	DX,11	;set to 11
	NEG	VEL_Y	;change direction
	CALL	BEEP	;sound beep
	JMP	DONE	;done
L3:	CMP	DX,188	;below bottom margin?
	JL	DONE	;no, done
	MOV	DX,187	;yes¬ set to 187
	NEG	VEL_Y	;change direction
	CALL	BEEP	;sound beep
DONE:
	RET
CHECK_BOUNDARY_A	ENDP
;
	END
