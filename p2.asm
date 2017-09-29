EXTERN DISPLAY_BALL:NEAR ,var1:word,var2:word,clm:word,BOX:NEAR,var_p3_1:word,clm2:word
PUBLIC KEY
.MODEL  SMALL
.data
check1 dw 2 dup(170)
check2 dw 2 dup(320)
flg_bt db 1 dup(0)
empt_bt db 1 dup(0)
flg_bx db 6 dup(0)

.STACK  100H
.CODE

key    PROC

;get keystroke
MOV     AH,0            ;keyboard input function
INT     16H             ;AH=scan code,AL=ascii code
                WHILE_:
                CMP     AH,1            ;ESC (exit character)?
JE      END_WHILE       ;yes, exit
;if function key
CMP     AL,0            ;AL = 0?
     JNE     ELSE_           ;no, character key

CALL    DO_FUNCTION     ;execute function
JMP     NEXT_KEY        ;get next keystroke
;then
NEXT_KEY:
MOV     AH,0            ;get keystroke function
INT     16H             ;AH=scan code,AL=ASCII code
                JMP     WHILE_
ELSE_:
                ;display character6
MOV     AH,2            ;display character func
MOV     DL,AL           ;GET CHARACTER
INT     21H             ;display character
sub dl,30h
mov dh,0
mov si,dx
mov bl,flg_bt
cmp flg_bx[si],bl
jne NEXT_KEY
lift_box:

MOV AL,0001b
MOV CX,130
mov clm2,cx
add var_p3_1,cx


MOV DX,230

CALL BOX
MOV AL,0100b
MOV CX,180
mov clm2,cx
add var_p3_1,cx
mov cx,180

MOV DX,230
CALL BOX
JMP     NEXT_KEY        ;get next keystroke
END_WHILE:
;dos exit
MOV     AH,4CH
INT     21H
key endp

DO_FUNCTION     PROC

CMP     AH,75           ;left arrow?
JE      CURSOR_LEFT     ;yes, execute
CMP     AH,77           ;right arrow?
JE      CURSOR_RIGHT    ;yes, execute
JMP     EXIT            ;other function key

CURSOR_LEFT:
cmp cx,check1
jg   EXECUTE1         ;go to execute
jmp NEXT_KEY
CURSOR_RIGHT:
cmp cx,check2
jl   EXECUTE2         ;go to execute
jmp NEXT_KEY
EXECUTE1:

add dx,20
MOV AL,1001b
CALL DISPLAY_BALL

MOV AL,0101b
sub cx,30

mov clm,cx
add cx,150
mov var1,cx
sub cx,150
;mov var2,dx
mov dx,230         ;;;row ke 10 ghor niche namalam ,tarpor var2 k 10 ghor upore
add dx,20
call DISPLAY_BALL

JMP EXIT
EXECUTE2:
mov si,0

;mov  var2[si],20
add dx,20
MOV AL,1001b
CALL DISPLAY_BALL

MOV AL,0101b
add cx,30
mov clm,cx

add cx,150
mov var1,cx
sub cx,150

;mov var2,dx
mov dx,230        ;;;row ke 10 ghor niche namalam ,tarpor var2 k 10 ghor upore
add dx,20
call DISPLAY_BALL

JMP EXIT

EXIT:
;POP     DX
;POP     CX
;POP     BX
RET
DO_FUNCTION     ENDP
END
