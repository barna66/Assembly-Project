	TITLE	PGM16_²: BOUNCING BALL
	EXTRN	SET_DISPLAY_MODE:NEAR, DISPLAY_BALL:NEAR
	EXTRN	MOVE_BALL:NEAR
	EXTRN	SETUP_INT:NEAR, TIMER_TICK:NEAR
	PUBLIC	TIMER_FLAG, VEL_X, VEL_Y
.MODEL SMALL
.STACK 100HŠ;
.DATA
NEW_TIMER_VEC	DW	?,?
OLD_TIMER_VEC	DW      ?,?
TIMER_FLAG	DB	0
VEL_X 		DW	-6
VEL_Y		DW	-1
;
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX		;initialize DS
;
;set graphics mode and draw border
        CALL    SET_DISPLAY_MODE
;seô up timer interrupô vector
        MOV     NEW_TIMER_VEC, OFFSET TIMER_TICK ;offset
        MOV     NEW_TIMER_VEC+2,CS		 ;segment
        MOV     AL,1CH				 ;interrupô type
 	LEA	DI,OLD_TIMER_VEC	;DI points to vector buffer
	LEA	SI,NEW_TIMER_VEC	;SI points to new vector
	CALL	SETUP_INT
;start ball at column = 298, row = 100 
;foò thå resô oæ thå prograí CØ wilì bå columî position
;of ball anä DØ wilì bå row position
	MOV	CX,298
	MOV	DX,100
	MOV	AL,3          ;whitå ball
	CALL	DISPLAY_BALL
;waiô foò timeò ticë beforå movinç thå ball
TEST_TIMER:
	CMP	TIMER_FLAG,1	;timeò ticked?
	JNE	TEST_TIMER	;no¬ keeð testing
	MOV	TIMER_FLAG,0	;yes¬ cleaò flag
        CALL    MOVE_BALL	;move to new position
;delay 1 timer tick
TEST_TIMER_2:
	CMP	TIMER_FLAG,1	;timer ticked?
	JNE	TEST_TIMER_2	;no, keep testing
	MOV	TIMER_FLAG,0	;yes, clear flag
        JMP     TEST_TIMER	;gï geô nexô balì position
MAIN	ENDP
	END	MAIN
