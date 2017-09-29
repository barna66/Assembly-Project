	TITLE	PGM16_2C:
;contains MOVE_BALL and CHECK_BOUNDARY procedures
	EXTRN	DISPLAY_BALL:NEAR
	EXTRN	TIMER_FLAG:BYTE, VEL_X:WORD, VEL_Y:WORD
	PUBLIC	MOVE_BALL
.MODEL SMALL
.CODE
MOVE_BALL	PROC
;eraså balì aô currenô positioî anä displaù balì aô ne÷ position
;inputº  CØ ½ column of ball position
;        DØ ½ row of ball position
;erase ball
	MOV	AL,0		;coloò ° ió backgrounä color
	CALL	DISPLAY_BALL	;erase ball
;get new position
      	ADD	CX,VEL_X
	ADD	DX,VEL_Y
;checë boundary
        CALL    CHECK_BOUNDARY
;waiô foò ± timeò tick to display ball
TEST_TIMER:
	CMP	TIMER_FLAG,1	;timeò ticked?
	JNE	TEST_TIMER	;no¬ keeð testing
	MOV	TIMER_FLAG,0	;yes, reset flag
	MOV	AL,3		;white color
	CALL	DISPLAY_BALL	;show ball
        RET
MOVE_BALL	ENDP
;
CHECK_BOUNDARY	PROC
;determinå iæ balì ió outsidå screen¬ iæ sï movå iô bacë iî and 
;changå thå balì direction
;inputº  CØ ½ column of ball position
;        DØ ½ row of ball position
;output: CX = column of ball position
;	 DX = row of ball position
;checë columî value
	CMP	CX,11	;lefô oæ 11?
	JG	L1	;no¬ go check right margin
	MOV	CX,11	;yes¬ seô to 11
	NEG	VEL_X	;changå direction
	JMP	L2	;gï tesô ro÷ boundary
L1:	CMP	CX,298	;beyonä righô margin?
	JL	L2	;no, go test row boundary
	MOV	CX,298	;seô columî tï 298
	NEG	VEL_X	;changå direction
;checë ro÷ value
L2:	CMP	DX,11	;abovå toð margin?
	JG	L3	;no, check bottom margin
	MOV	DX,11	;seô tï 11
	NEG	VEL_Y	;changå direction
	JMP	DONE	;done
L3:	CMP	DX,187	;belo÷ bottoí margin?
	JL	DONE	;no, done
	MOV	DX,187	;yes¬ seô tï 187
	NEG	VEL_Y	;changå direction
DONE:
	RET
CHECK_BOUNDARY	ENDP
	END
