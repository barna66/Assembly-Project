.model small
.stack 100h
.data
v_clm dw 2 dup(?)
v_rw dw 2 dup(?)
clm dw 2 dup(?)

array db 17 dup(0,4,3,8,14,13,14,13,6,6,3,8,1,1,13,4,13) 
flag db 17 dup(0)
count db 1 dup(0)
v1 db 1 dup(0)
v2 db 1 dup(0)
p1 dw 1 dup(0)
p2 dw 1 dup(0) 
p3 dw 1 dup(0)
p4 dw 1 dup(0)
p db 1 dup(0)
mark db 1 dup(0)
.code

 WRITE_TEXT_IN_COLOR proc
    push si
    push ax
    push cx
    push dx   
    push bx
        MOV     AH,09             ;display character function   
        mov dx,0 
        mov bl,1111b
       ; MOV     BH,0              ;page 0
        ;MOV     BL,0C3H           ;blinking cyan char, red back
        MOV     CX,1              ;display one character
       ; MOV     AL,count 
       MOV     AL,mark            ;character is 'count'     
        add al,30h
        INT     10H  
        pop bx
        pop dx
        pop cx
        pop ax 
        pop si

ret
WRITE_TEXT_IN_COLOR endp

BOXM macro v1,v2,p
    local kk
    local nn
    
    
    
    mov al,p
    cmp al,0
    jne kk
    jmp nn
    kk:
    inc count
    nn:   
    mov cx,v1
    
    MOV DX,v2
    MOV v_clm,cx
    MOV v_rw,dx
    sub cx,80
    mov clm,cx
    sub dx,80
    ;mov al,0100b
    call box
endm

BOX	PROC
    
    push si
    push ax
    push cx
    push dx   
    push bx 
        ;color box
lpp1: 

    ;mov al,0100b
    MOV  AH,0CH	;
    INT  10H
    
    cmp cx,v_clm
    je lpp2
    inc cx
    jmp lpp1
lpp2:
    inc dx
    cmp dx,v_rw
    je exitp
    mov cx,clm
    jmp lpp1
exitp:

    pop bx
    pop dx
    pop cx
    pop ax 
    pop si
   
ret
box endp



grid proc
     
    push si
    push ax
    push cx
    push dx   
    push bx 
    mov cx,160
    mov dx,80
    mov al,0001b 
    
    ;;ROW CREATING LOOP
    
    lp1:
        MOV  AH,0CH
        INT  10H
        cmp cx,481
        je lp2
        inc cx
        jmp lp1
    
    lp2:
        add dx,80
        cmp dx,480
        JE NEXT
        mov cx,160
        jmp lp1
    
    ;;COLUMN CREATING LOOP
    NEXT:
        MOV CX,160
        MOV DX,80
    lp3:
        MOV  AH,0CH
        INT  10H
        cmp DX,401
        je lp4
        inc DX
        jmp lp3
    
    lp4:
        add CX,80
        cmp CX,560
        JE  retr
        mov DX,80
        jmp lp3

retr: 
    pop bx
    pop dx
    pop cx
    pop ax 
    pop si
    ret
    grid endp
MAIN PROC



mov ax,@data
mov ds,ax
mov AH, 0   
    mov AX, 12h
    int 10h
    
    
    
call grid

INPUT:
mov cx,0
mov dx,0

;mov ax,0000h
;int 33h

INPUT1:

call grid 
call WRITE_TEXT_IN_COLOR
    mov cl,count
    cmp cl,2
    je check_clr
    jmp inp
check_clr:
    mov count,0
    mov bl,v1
    cmp bl,v2
    je inc_mark
    ;mov bl,2 
    ;int 10h
    mov al,0
    BOXM p3,p4,al
    BOXM p1,p2,al
    jmp inp
inc_mark:
    inc mark
    inc mark


inp:  
    call grid
    mov ax,0001h
    int 33h
    mov ax,0003h
    int 33h
    cmp bx,1
    jne inp
    cmp cx,160
    jl EXIT
    
    CMP CX,160
    JG CHK_C1
    jl input1


CHK_C1:
    mov ax,0002h
    int 33h 
    
    CMP CX,240
    JLE CHK_B1
    jmp CHK_C2
CHK_B1:
    CMP DX,160
    JLE B1
    
    CMP DX,240
    JLE B5
    
    
    CMP DX,320
    JLE B9
    
    
    CMP DX,400
    JLE B13

B5:
    mov si,5
    mov bl,count
    cmp bl,0
    je mvv5
    
     mov p3,240
    mov p4,240
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex5
mvv5: 
    mov p1,240
    mov p2,240
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
    
    
ex5:

BOXM 240d,240d,al
jmp INPUT1 


B9: 

    mov si,9
    mov bl,count
    cmp bl,0
    je mvv9
    mov p3,240
    mov p4,320
    
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex9
  
mvv9: 
    mov p1,240
    mov p2,320
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
ex9:
    BOXM 240d,320d,al
    jmp INPUT1

B13:
    mov si,13
    mov bl,count
    cmp bl,0
    je mvv13
    
    mov p3,240
    mov p4,400
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex13
mvv13:
    mov p1,240
    mov p2,400
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl

ex13:
    BOXM 240d,400d,al
    jmp INPUT1
    
    
B1:

    mov si,1
    mov bl,count
    cmp bl,0
    je mvv1
    
    mov p3,240
    mov p4,160 
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex1
mvv1:
    mov p1,240
    mov p2,160
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
    
    
ex1:
    BOXM 240d,160d,al
    jmp INPUT1
    
    
    
CHK_C2:
    CMP CX,320
    JLE CHK_B2
    JMP CHK_C3

CHK_B2:
    CMP DX,160
    JLE B2
    
    CMP DX,240
    JLE B6
    
    
    CMP DX,320
    JLE B10
    
    
    CMP DX,400
    JLE B14

B2:
    mov si,2
    mov bl,count
    cmp bl,0
    je mvv2
    
    mov p3,320
    mov p4,160 
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex2
mvv2: 
    mov p1,320
    mov p2,160
    ;
    mov bl,array[si]
    mov v1,bl
     mov al,bl
    
    
ex2:
BOXM 320d,160d,al
jmp INPUT1

B6:
    mov si,6
    mov bl,count
    cmp bl,0
    je mvv6 
    
    mov p3,320
    mov p4,240
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex6
mvv6: 
    mov p1,320
    mov p2,240
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl

ex6:
    BOXM 320d,240d,al
    jmp INPUT1
    
B10:
    mov si,10
    mov bl,count
    cmp bl,0
    je mvv10 
    
    mov p3,320
    mov p4,320
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex10
mvv10:
    mov p1,320
    mov p2,320
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl

ex10:
    BOXM 320d,320d,al
    jmp INPUT1
B14:
    mov si,14
    mov bl,count
    cmp bl,0
    je mvv14
    
    mov p3,320
    mov p4,400
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex14
mvv14:
    mov p1,320
    mov p2,400
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
ex14:
    BOXM 320d,400d,al
    jmp INPUT1


CHK_C3:
    CMP CX,400
    JLE CHK_B3
    JMP CHK_C4

CHK_B3:
    CMP DX,160
    JLE B3
    CMP DX,240
    JLE B7
    
    
    CMP DX,320
    JLE B11
    
    
    CMP DX,400
    JLE B15

B3:
    mov si,3
    mov bl,count
    cmp bl,0
    je mvv3
    
    mov p3,400
    mov p4,160
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex3
mvv3:
    mov p1,400
    mov p2,160
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
    
ex3:
BOXM 400d,160d ,al
jmp INPUT1

B7:
    mov si,7
    mov bl,count
    cmp bl,0
    je mvv7
     mov p3,400
    mov p4,240
    
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex7
mvv7: 
    mov p1,400
    mov p2,240
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
ex7:
    BOXM 400d,240d,al
    jmp INPUT1

B11:
    mov si,11
    mov bl,count
    cmp bl,0
    je mvv11
    
    mov p3,400
    mov p4,320
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex11
mvv11: 
    mov p1,400
    mov p2,320
    ;
    mov bl,array[si]
    mov v1,bl
     mov al,bl
ex11:
    BOXM 400d,320d,al
    jmp INPUT1
B15:
    mov si,15
    mov bl,count
    cmp bl,0
    je mvv15
    
    
    mov p3,400
    mov p4,400
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex15
mvv15: 
    mov p1,400
    mov p2,400
    ;
    mov bl,array[si]
    mov v1,bl
     mov al,bl
ex15:
    BOXM 400d,400d,al
    jmp INPUT1
    
    

CHK_C4:
CMP CX,480
JLE CHK_B4

JMP INPUT1

CHK_B4:
CMP DX,160
JLE B4

CMP DX,240
JLE B8


CMP DX,320
JLE B12


CMP DX,400
JLE B16

B4:
    mov si,4
    mov bl,count
    cmp bl,0
    je mvv4 
    
    mov p3,480
    mov p4,160
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex4
    
    
mvv4:  
    mov p1,480
    mov p2,160
    ;
    mov bl,array[si]
    mov v1,bl
     mov al,bl
ex4:
BOXM 480d,160d,al
jmp INPUT1

B8:
    mov si,8
    mov bl,count
    cmp bl,0
    je mvv8
    
    mov p3,480
    mov p4,240
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex8
mvv8:   
    mov p1,480
    mov p2,240
    ;
    mov bl,array[si]
    mov v1,bl
     mov al,bl
ex8:
    BOXM 480d,240d,al
    jmp INPUT1

B12:
    mov si,12
    mov bl,count
    cmp bl,0
    je mvv12
     
     
     mov p3,480
    mov p4,320
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex12
mvv12:   
    mov p1,480
    mov p2,320
    ;
    mov bl,array[si]
    mov v1,bl
     mov al,bl
ex12:
    BOXM 480d,320d,al
    jmp INPUT1
B16:
    mov si,16
    mov bl,count
    cmp bl,0
    je mvv16 
    
    mov p3,480
    mov p4,400
    mov bl,array[si]
    mov v2,bl
    ;
    mov al,bl
    jmp ex16
mvv16:
    mov p1,480
    mov p2,400
    ;
    mov bl,array[si]
    mov v1,bl
    mov al,bl
ex16:
    BOXM 480d,400d,al
    jmp INPUT1


EXIT:
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN
