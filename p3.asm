TITLE	PGM16_2A: 
public BOX,var_p3_1,clm2
.MODEL SMALL
.DATA

var_p3_1 dw 10 dup(30)
var2 dw 10 dup(200) 


clm2 dw 10 dup(130)

.STACK
.CODE

BOX	PROC
 
lp1:
	MOV  AH,0CH	;writ?pixel
	INT  10H
	inc cx
	cmp cx,var_p3_1
	je lp2
	jmp lp1
lp2:
	dec dx
	cmp dx,var2
	je exit
lp3:
	
	MOV  AH,0CH	
	 INT  10H
	 dec cx
	 cmp cx,clm2
	 je set
	 jmp lp3
set:
	dec dx
	cmp dx,var2
	je exit
	jmp lp1
	exit:
	mov cx,30
	mov var_p3_1,cx
	  ret
BOX	ENDP
END 
