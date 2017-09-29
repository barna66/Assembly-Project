	TITLE	PGM16_3A: BEEP
;sound generating procedure
	EXTRN	TIMER_FLAG:BYTE
	PUBLIC	BEEP
.MODEL	SMALL
.CODE
BEEP	PROC
;generate beeping sound
	PUSH	CX		;save CX
;initialize timer
	MOV	AL,0B6H		;specify mode of operation
	OUT	43H,AL		;write to port 43h
;load count
	MOV	AX,1193		;count for 1000 Hz
	OUT	42H,AL		;low byte
	MOV	AL,AH		;high byte
	OUT	42H,AL
;activate speaker
	IN	AL,61H		;read control port
	MOV	AH,AL		;save value in AH
	OR	AL,11B		;set control bits
	OUT	61H,AL		;activate speaker
;500 ms delay loop
	MOV	CX,9		;do 9 times
B_1:	CMP	TIMER_FLAG,1	;check timer flag
	JNE	B_1		;not set, loop back
	MOV	TIMER_FLAG,0	;flag set, clear it
	LOOP	B_1		;repeat for next tick
;turn off tone
	MOV	AL,AH		;return old control value to AL
	OUT	61H,AL		;restore control value
;
	POP	CX		;restore CX
	RET
BEEP	ENDP
	END
