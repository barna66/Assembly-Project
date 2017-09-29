	TITLE	PGM16_3 :PADDLE_BALL
	EXTRN	SET_DISPLAY_MODE:NEAR, DISPLAY_BALL:NEAR
	EXTRN	MOVE_BALL_A:NEAR, DRAW_PADDLE:NEAR
	EXTRN	MOVE_PADDLE:NEAR
	EXTRN	KEYBOARD_INT:NEAR, TIMER_TICK:NEAR
	EXTRN	SETUP_INT:NEAR, KEYBOARD_INT:NEAR
	PUBLIC	TIMER_FLAG, KEY_FLAG, SCAN_CODE
	PUBLIC	PADDLE_TOP, PADDLE_BOTTOM, VEL_X, VEL_Y
;
.MODEL	SMALL
.STACK	100H
.DATA
;
NEW_TIMER_VEC	DW	?,?
OLD_TIMER_VEC	DW	?,?
NEW_KEY_VEC	DW	?,?
OLD_KEY_VEC	DW	?,?
SCAN_CODE	DB	0
KEY_FLAG	DB	0
TIMER_FLAG	DB	0
PADDLE_TOP	DW	45
PADDLE_BOTTOM	DW	54
VEL_X		DW	-6
VEL_Y		DW	-1
;scan codes
UP_ARROW = 72
DOWN_ARROW = 80
ESC_KEY = 1
;
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX		;initialize DS
;
;set graphics mode
	CALL	SET_DISPLAY_MODE
;draw paddle
	MOV	AL,2		;display red paddle
	CALL	DRAW_PADDLE
;set up timer interrupt vector
	MOV	NEW_TIMER_VEC,OFFSET TIMER_TICK  ;offset
	MOV	NEW_TIMER_VEC+2,CS		;segment
	MOV	AL,1CH		;interrupt number
	LEA	DI,OLD_TIMER_VEC
	LEA	SI,NEW_TIMER_VEC
	CALL	SETUP_INT
;set up keyboard interrupt vector
	MOV	NEW_KEY_VEC,OFFSET KEYBOARD_INT	;offset
	MOV	NEW_KEY_VEC+2,CS		;segment
	MOV	AL,9H		;interrupt number
	LEA	DI,OLD_KEY_VEC
	LEA	SI,NEW_KEY_VEC
	CALL	SETUP_INT
;start ball at column = 298, row = 100
	MOV	CX,298		;column
	MOV	DX,100		;row
	MOV	AL,3		;white
	CALL	DISPLAY_BALL
;check key flag
TEST_KEY:
	CMP	KEY_FLAG,1	;check key flag
	JNE	TEST_TIMER	;not set, go check timer flag
	MOV	KEY_FLAG,0	;flag set, clear it and check
	CMP	SCAN_CODE,ESC_KEY	;Esc key?
	JNE	TK_1		;no, check arrow keys
	JMP	DONE		;Esc, terminate
TK_1:	CMP	SCAN_CODE,UP_ARROW	;up arrow?
	JNE	TK_2		;no, check down arrow
	MOV	AX,-2		;yes, move up 2 pixels
	CALL	MOVE_PADDLE	;
	JMP	TEST_TIMER	;go check timer flag
TK_2:	CMP	SCAN_CODE,DOWN_ARROW	;down arrow?
	JNE	TEST_TIMER	;no, check timer flag
	MOV	AX,2		;yes, move down 2 pixels
	CALL	MOVE_PADDLE	;
;check timer flag
TEST_TIMER:
	CMP	TIMER_FLAG,1	;flag set?
	JNE	TEST_KEY	;no, check key flag
	MOV	TIMER_FLAG,0	;yes, clear it
	CALL	MOVE_BALL_A	;move ball to new position
;check if paddle missed ball
	CMP	CX,11		;at column 11?
	JNE	TEST_KEY	;no, check key flag
	CMP	DX,PADDLE_TOP	;yes, check paddle
	JL	CP_1		;missed, ball above
	CMP	DX,PADDLE_BOTTOM	
	JG	CP_1		;missed, ball below
;paddle hit the ball, delay one tick then
;move the ball and redraw paddle
DELAY:	CMP	TIMER_FLAG,1	;timer ticked?
	JNE	DELAY		;no, keep checking
	MOV	TIMER_FLAG,0	;yes, reset flag
	CALL	MOVE_BALL_A
	MOV	AL,2		;display red paddle
	CALL	DRAW_PADDLE
	JMP	TEST_KEY	;check key flag
;paddle missed the ball, erase the ball and terminate
CP_1:	MOV	AL,0		;erase ball
	CALL	DISPLAY_BALL
;--reset timer interrupt vector
DONE:	LEA	DI,NEW_TIMER_VEC
	LEA	SI,OLD_TIMER_VEC
	MOV	AL,1CH
	CALL	SETUP_INT
;--reset keyboard interrupt vector
	LEA	DI,NEW_KEY_VEC
	LEA	SI,OLD_KEY_VEC
	MOV	AL,9H
	CALL	SETUP_INT
;read key
	MOV	AH,0
	INT	16H
;reset to text mode
	MOV	AH,0
	MOV	AL,3
	INT	10H
;return to DOS
	MOV	AH,4CH
	INT	21H
MAIN	ENDP
	END	MAIN
