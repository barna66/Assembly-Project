TITLE	PGM16_2A: 
public DISPLAY_BALL,var1,var2,clm
extern key:near ,screen:near,BOX:NEAR,var_p3_1:word

.MODEL SMALL
.DATA

var1 dw 1 dup(150)
var2 dw 1  dup(230) 

clm dw 10 dup(170)

.STACK
.CODE

DISPLAY_BALL	PROC
lp1:
	MOV  AH,0CH	;writ?pixel
	INT  10H
	inc cx
	cmp cx,var1
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
	 cmp cx,clm
	 je set
	 jmp lp3
set:
	dec dx
	cmp dx,var2
	je exit
	jmp lp1
	exit:
	  ret
	
DISPLAY_BALL	ENDP
main proc
 
    MOV	AX,@DATA
	MOV	DS,AX		;initialize DS
   mov AH, 0   ; graphics mode
    mov AX, 12h
    int 10h
    
    MOV  AH, 11  ;function  OBh 
    MOV  BH, 0  ;select  background  color 
    MOV  BL,1b ;background color 7,11,15 possibly
    INT	10H
CALL SCREEN
MOV AL,0100b
MOV	CX,130
    add cx,var_p3_1
    mov var_p3_1,cx
    mov cx,130
    
    MOV DX,230

 call BOX   
    MOV	CX,170
    add cx,var1
    mov var1,cx
    mov cx,170
    
    MOV DX,250
   ; sub dx,var2
    ;mov var2,dx
    mov dx,250
    
    
    MOV	AL,0101b   
    call DISPLAY_BALL

    call key
     
;return to DOS
	MOV	AH,4CH		;return
	INT	21H		;to DOS    
       
main endp    
END main