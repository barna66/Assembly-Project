	TITLE	PGM16_3C: KEYBOARD INTERRUPT
	EXTRN	SCAN_CODE:BYTE, KEY_FLAG:BYTE
	PUBLIC	KEYBOARD_INT
.MODEL	SMALL
.CODE
KEYBOARD_INT	PROC
;keyboard interrupt routine
;save registers
	PUSH	DS
	PUSH	AX
;set up DS
	MOV	AX,SEG SCAN_CODE
	MOV	DS,AX
;input scan code
	IN	AL,60H		;read scan code
	PUSH	AX		;save it
	IN	AL,61H		;control port
	MOV	AH,AL		;save in AH
	OR	AL,80H		;set bit for keyboard
	OUT	61H,AL		;write back
	XCHG	AH,AL		;get back control value
	OUT	61H,AL		;reset control port
	POP	AX		;recover scan code
	MOV	AH,AL		;save scan code in AH
	TEST	AL,80H		;test for break code
	JNE	KEY_0		;yes, clear flags, goto KEY_0
;make code
	MOV	SCAN_CODE,AL	;save in variable
	MOV	KEY_FLAG,1	;set key flag
KEY_0:	MOV	AL,20H		;reset interrupt
	OUT	20H,AL
;restore registers
	POP	AX
	POP	DS
	IRET
KEYBOARD_INT	ENDP		;end KEYBOARD routine
;
	END
