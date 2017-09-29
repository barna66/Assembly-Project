.model small 
.stack 100h
.data
v_clm dw 2 dup(?)
v_rw dw 2 dup(?)
clm dw 2 dup(?)
count db 1 dup(0)     
mark db 1 dup(0)  
clr_chk db 5 dup(?)
v1 db 1 dup(?)
v2 db 1 dup(?)
p1 dw 2 dup(5)
p2 dw 2 dup(5) 
array db 18 dup(0,4,1,8,14,13,14,13,6,6,1,8,2,2,13,4,13)        ;ekhane chnge korlam
.code 

 WRITE_TEXT_IN_COLOR proc
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
        MOV     AL,count 
       ;MOV     AL,mark            ;character is 'count'     
        add al,30h
        INT     10H  
        pop bx
        pop dx
        pop cx
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

 BOX	PROC 
    
    
    call WRITE_TEXT_IN_COLOR       ;ekhane chane
    cmp al,0
    jne c1 
    
    
    jmp lpp1
    c1:
    inc count
      
    lpp1:
    	MOV  AH,0CH	
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
    call grid
   
    	  ret 
    	 box endp 
 
 grid proc  
    push cx
    push dx
    push ax
    mov cx,160
    mov dx,80
    mov al,0001b ;blue
    
     
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
        JE  ex 
        mov DX,80
        jmp lp3
        ex: 
       pop ax
       pop dx
       pop cx
       
     ret   
     grid endp  

MAIN PROC 
    
    
    
    mov ax,@data
    mov ds,ax
    
    mov AH, 0   ; graphics mode
    mov AX, 12h
    int 10h
     
    inc count  
     call grid
    INPUT: 
     mov cx,0
     mov dx,0 
    
    mov ax,0000h
    int 33h 
    
    INPUT1:  
        cmp count,3
        jge do 
        cmp count ,2
        je o
        jmp boing
        o:
        cmp p1,cx
        je xx
        jmp boing
        xx:
        cmp p2,dx
        je yy
        jmp boing
        yy:
       mov count,3
        jmp boing 
        
        do:
        cmp p1,cx
        je x
        jmp p 
        x:
        cmp p2,dx
        je y
        jmp p
        y:
        
        mov count,2
        jmp boing
        p:        
        mov count,1
        mov bl,v1
        cmp v2,bl   
        jne mib
        
        inc mark
        jmp boing
        mib:
        mov count,1
        mov al,0
        BOXM cx,dx
        BOXM p1,p2 
        
        boing: 
        mov ax,0001h
        int 33h 
        mov ax,0003h
        int 33h
        cmp bx,1
        jne boing
         CMP CX,80
     JL EXIT
        CMP CX,160
        JG CHK_C1
         jl boing
    
    
    CHK_C1: 
   ; call WRITE_TEXT_IN_COLOR
                
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
    ;inc count
   
mov si,5
    mov al,array[si] 
    
    CMP count,1
    JE X5
    mov v2,al
    JMP Y5
    X5: 
        mov v1,al
        MOV bx,240d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y5:
     BOXM 240d,240d  
        jmp INPUT1 
        
    B9:
    ;inc count
mov si,9
    mov al,array[si] 
    
    CMP count,1
    JE X9
    mov v2,al
    JMP Y9
    X9: 
        mov v1,al
        MOV bx,240d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y9: 
        
       BOXM 240d,320d   
        jmp INPUT1
    B13:
     ;inc count
mov si,13
    mov al,array[si] 
   
    
    CMP count,1
    JE X13
    mov v2,al
    JMP Y13
    X13: 
    mov v1,al
        MOV bx,240d
        mov p1,bx
        mov bx,400d
        mov p2,bx
    Y13:
       BOXM 240d,400d   
        jmp INPUT1
            
        
    B1:
     ;inc count
    mov si,1 
    mov al,array[si] 
    CMP count,1
    JE X1
    mov v2,al
    JMP Y1
    X1: 
    mov v1,al
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
    ;inc count
mov si,2
    mov al,array[si] 
    CMP count,1
    JE X2
    mov v2,al
    JMP Y2
    X2: 
    mov v1,al
        MOV bx,320d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y2:
        BOXM 320d,160d
        jmp INPUT1   
         
    B6: 
     ;inc count
mov si,6
    mov al,array[si] 
    CMP count,1
    JE X6
    mov v2,al
    JMP Y6
    X6: 
    mov v1,al
        MOV bx,320d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y6:
       BOXM 320d,240d   
        jmp INPUT1 
        
    B10:
     ;inc count
mov si,10
    mov al,array[si] 
    CMP count,1
    JE X10
    mov v2,al
    JMP Y10
    X10: 
    mov v1,al
        MOV bx,320d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y10:
       BOXM 320d,320d   
        jmp INPUT1 
        
        
    B14: 
      ;inc count
mov si,14
    mov al,array[si] 
   CMP count,1
    JE X14
    mov v2,al
    JMP Y14
    X14: 
    mov v1,al
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
       ;        inc count
mov si,3
    mov al,array[si] 
    CMP count,1
    JE X3
    mov v2,al
    JMP Y3
    X3: 
    mov v1,al
        MOV bx,400d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y3:
        BOXM 400d,160d
        jmp INPUT1
    
    B7:
   ;inc count
    mov si,7
    mov al,array[si]
    CMP count,1
    JE X7
    mov v2,al
    JMP Y7
    X7: 
    mov v1,al
        MOV bx,400d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y7:
   BOXM 400d,240d   
        jmp INPUT1 
        
    B11:
;inc count 
mov si,11
    mov al,array[si] 
    CMP count,1
    JE X11
    mov v2,al
    JMP Y11
    X11: 
    mov v1,al
        MOV bx,400d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y11:
       BOXM 400d,320d   
        jmp INPUT1 
        
    B15:
 ;     inc count
mov si,15
    mov al,array[si] 
    CMP count,1
    JE X15
    mov v2,al
    JMP Y15
    X15: 
    mov v1,al
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
  ;  inc count
mov si,4
    mov al,array[si] 
   CMP count,1
    JE X4
    mov v2,al
    JMP Y4
    X4: 
    mov v1,al
        MOV bx,480d
        mov p1,bx
        mov bx,160d
        mov p2,bx
    Y4:
        BOXM 480d,160d
        jmp INPUT1 
        
     B8:
   ;    inc count
mov si,8
    mov al,array[si] 
    CMP count,1
    JE X8
    mov v2,al
    JMP Y8
    X8: 
    mov v1,al
        MOV bx,480d
        mov p1,bx
        mov bx,240d
        mov p2,bx
    Y8:
       BOXM 480d,240d   
        jmp INPUT1 
        
    B12: 
    ;  inc count
mov si,12
    mov al,array[si] 
    CMP count,1
    JE X12
    mov v2,al
    JMP Y12
    X12: 
    mov v1,al
        MOV bx,480d
        mov p1,bx
        mov bx,320d
        mov p2,bx
    Y12:
       BOXM 480d,320d   
        jmp INPUT1 
        
    B16:
     ;  inc count
mov si,16
    mov al,array[si] 
   CMP count,1
    JE X16
    mov v2,al
    JMP Y16
    X16: 
    mov v1,al
        MOV bx,480d
        mov p1,bx
        mov bx,400d
        mov p2,bx
    Y16:
       BOXM 480d,400d   
        jmp INPUT1        
       
      
        
    EXIT:
        MOV AH,4CH
        INT 21H
        MAIN ENDP
END MAIN