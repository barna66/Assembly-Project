	TITLE	PGM16_2B: TIMER_TICK
;timer interrupt procedure
	EXTRN	TIMER_FLAG:BYTE
	PUBLIC	TIMER_TICK
.MODEL SMALL
.CODE
;timer routine
TIMER_TICK	PROC
;save registers
	PUSH	DS		;save DS
	PUSH	AX		
;
	MOV	AX,SEG TIMER_FLAG	;get segment of flag
	MOV	DS,AX		;put in DS
	MOV	TIMER_FLAG,1	;set flag
;restore registers
	POP	AX
	POP	DS		;restore DS
	IRET
TIMER_TICK	ENDP		;end timer routine
          END
ç
