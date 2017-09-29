.model small 
.stack 100h
.data
v_clm dw 2 dup(?)
v_rw dw 2 dup(?)
clm dw 2 dup(?)
count db 1 dup(0)  
clr_chk db 3 dup(?)
v db 2 dup(?)
p1 dw 2 dup(?)
p2 dw 2 dup(?) 
mark db 2 dup(0)
array db 17 dup(0,4,3,8,14,13,14,13,6,6,3,8,1,1,13,4,13) 
.code 
WRITE_TEXT_IN_COLOR proc
push ax
mov ah,0Eh 
    mov al,count ;ascii
    add al,30h
    mov bl,04  ;color
    int 10h
pop ax
ret
WRITE_TEXT_IN_COLOR endp

BOXM macro v1,v2
     mov cx,v1     
     MOV DX,v2
     MOV v_clm,cx
     MOV v_rw,dx
     sub cx,80 
     mov clm,cx
     sub dx,80
     
     call box  
endm

 BOX PROC
    lpp1:
        
    	MOV  AH,0CH	
    	INT  10H
    	
    	cmp cx,v_clm
    	je lpp2   '
    	inc cx
    	jmp lpp1
    lpp2:
    	inc dx
    	cmp dx,v_rw
    	je exitp
    	mov cx,clm
    	jmp lpp1
    exitp:
    	  ret 
    	 box endp 
 

MAIN PROC 
    
    
    
    mov ax,@data
    mov ds,ax
    
    mov AH, 0   ; graphics mode
    mov AX, 12h
    int 10h
    
      
    
    mov cx,160
    mov dx,80
    mov al,0001b ;bxue 
     
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
        JE  INPUT 
        mov DX,80
        jmp lp3 
        
        
 INPUT:
    mov cx,0
    mov dx,0
    
    mov ax,0000h
    int 33h
     mov ax,0001h
    int 33h
    mov ax,0003h
    int 33h
    cmp bx,1
    jne INPUT

INPUT1:
   
    mov bl,count
    cmp bl,2
    jge check_clr
    jmp inp
check_clr:
   ; MOV BL,0
    MOV count,0
    mov si,1  
    ;mov di,2
    mov bl,clr_chk[si]
    inc si
    cmp bl,clr_chk[si]
    je inc_mark
    ;mov bx,2 
    ;int 10h
    mov al,0
    BOXM CX,DX
    BOXM p1,p2
    jmp inp
inc_mark:
    cmp p1,cx
    je x
    jmp z
    x:
    cmp p2,dx
    je y
    jmp z
    y:
    dec count
    jmp imp
    z:
    inc mark
    inc mark


inp:
    mov ax,0001h
    int 33h
    mov ax,0003h
    int 33h
    cmp bx,1
    jne input1
    ;inc count
      CMP CX,80
     JL EXIT
     CMP CX,160
     JG CHK_C1

     jl input1     
          
  
    
    CHK_C1:
    

call WRITE_TEXT_IN_COLOR

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
    inc count
   
mov si,5
    mov al,array[si]
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X5
    JMP Y5
    X5:
        MOV bx,240d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y5:
     BOXM 240d,240d  
        jmp INPUT1 
        
    B9:
    inc count
mov si,9
    mov al,array[si] 
    mov bl,count
       mov bh,0 
        mov si,bx
    mov clr_chk[si],al
    CMP bl,1
    JE X9
    JMP Y9
    X9:
        MOV bx,240d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y9:
       BOXM 240d,320d   
        jmp INPUT1
    B13:
     inc count
mov si,13
    mov al,array[si] 
    mov bl,count 
      mov bh,0  
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X13
    JMP Y13
    X13:
        MOV bx,240d
        mov p1,bx
        mov bx,400d
        mov p2,bx
    Y13:
       BOXM 240d,400d   
        jmp INPUT1
            
        
    B1:
     inc count
    mov si,1
    mov al,array[si]
    mov bl,count 
      mov bh,0  
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X1
    JMP Y1
    X1:
        MOV bx,240d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y1:
;mov al,0010b
        BOXM 240d,160d   
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
    inc count
mov si,2
    mov al,array[si] 
    mov bl,count   
    mov bh,0 
     mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X2
    JMP Y2
    X2:
        MOV bx,320d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y2:
        BOXM 320d,160d
        jmp INPUT1   
         
    B6: 
     inc count
mov si,6
    mov al,array[si] 
    mov bl,count   
    mov bh,0 
     mov si,bx
    mov clr_chk[si],al 
    CMP BL,1
    JE X6
    JMP Y6
    X6:
        MOV bx,320d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y6:
       BOXM 320d,240d   
        jmp INPUT1 
        
    B10:
     inc count
mov si,10
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X10
    JMP Y10
    X10:
        MOV bx,320d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y10:
       BOXM 320d,320d   
        jmp INPUT1 
        
        
    B14: 
      inc count
mov si,14
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X14
    JMP Y14
    X14:
        MOV bx,320d
        mov p1,bx
        mov bx,400d
        mov p2,bx
    Y14:
       BOXM 320d,400d   
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
               inc count
mov si,3
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X3
    JMP Y3
    X3:
        MOV bx,400d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y3:
        BOXM 400d,160d
        jmp INPUT1
    
    B7:
   inc count
    mov si,7
    mov al,array[si]
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X7
    JMP Y7
    X7:
        MOV bx,400d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y7:
   BOXM 400d,240d   
        jmp INPUT1 
        
    B11:
inc count 
mov si,11
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X11
    JMP Y11
    X11:
        MOV bx,400d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y11:
       BOXM 400d,320d   
        jmp INPUT1 
        
    B15:
      inc count
mov si,15
    mov al,array[si] 
    mov bl,count   
    mov bh,0  
    mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X15
    JMP Y15
    X15:
        MOV bx,400d
        mov p1,bx
        mov bx,400d
        mov p2,bx
    Y15:
       BOXM 400d,400d   
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
    inc count
mov si,4
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X4
    JMP Y4
    X4:
        MOV bx,480d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y4:
        BOXM 480d,160d
        jmp INPUT1 
        
     B8:
       inc count
mov si,8
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X8
    JMP Y8
    X8:
        MOV bx,480d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y8:
       BOXM 480d,240d   
        jmp INPUT1 
        
    B12: 
      inc count
mov si,12
    mov al,array[si] 
    mov bl,count  
     mov bh,0 
      mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X12
    JMP Y12
    X12:
        MOV bx,480d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y12:
       BOXM 480d,320d   
        jmp INPUT1 
        
    B16:
       inc count
mov si,16
    mov al,array[si] 
    mov bl,count   
    mov bh,0 
     mov si,bx
    mov clr_chk[si],al
    CMP BL,1
    JE X16
    JMP Y16
    X16:
        MOV bx,480d
        mov p1,bx
        mov bx,400d
        mov p2,bx
    Y16:
       BOXM 480d,400d   
        jmp INPUT1        
      
        
    EXIT:
;mov ax,3
;int 10h
        MOV AH,4CH
        INT 21H
        MAIN ENDP
END MAIN