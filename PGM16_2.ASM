	TITLE	PGM16_�: BOUNCING BALL
	EXTRN	SET_DISPLAY_MODE:NEAR, DISPLAY_BALL:NEAR
	EXTRN	MOVE_BALL:NEAR
	EXTRN	SETUP_INT:NEAR, TIMER_TICK:NEAR
	PUBLIC	TIMER_FLAG, VEL_X, VEL_Y
.MODEL SMALL
.STACK 100H�;
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
;se� up timer interrup� vector
        MOV     NEW_TIMER_VEC, OFFSET TIMER_TICK ;offset
        MOV     NEW_TIMER_VEC+2,CS		 ;segment
        MOV     AL,1CH				 ;interrup� type
 	LEA	DI,OLD_TIMER_VEC	;DI points to vector buffer
	LEA	SI,NEW_TIMER_VEC	;SI points to new vector
	CALL	SETUP_INT
;start ball at column = 298, row = 100 
;fo� th� res� o� th� progra� C� wil� b� colum� position
;of ball an� D� wil� b� row position
	MOV	CX,298
	MOV	DX,100
	MOV	AL,3          ;whit� ball
	CALL	DISPLAY_BALL
;wai� fo� time� tic� befor� movin� th� ball
TEST_TIMER:
	CMP	TIMER_FLAG,1	;time� ticked?
	JNE	TEST_TIMER	;no� kee� testing
	MOV	TIMER_FLAG,0	;yes� clea� flag
        CALL    MOVE_BALL	;move to new position
;delay 1 timer tick
TEST_TIMER_2:
	CMP	TIMER_FLAG,1	;timer ticked?
	JNE	TEST_TIMER_2	;no, keep testing
	MOV	TIMER_FLAG,0	;yes, clear flag
        JMP     TEST_TIMER	;g� ge� nex� bal� position
MAIN	ENDP
	END	MAIN
