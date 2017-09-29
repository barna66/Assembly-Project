.model small 
.stack 100h
.data
v_clm dw 2 dup(?)
v_rw dw 2 dup(?)
clm dw 2 dup(?)
count db 2 dup(0)  
v1 db 2 dup(?)
v2 db 2 dup(?)
p1 db 2 dup(?)
p2 db 2 dup(?)
array db 17 dup(0,4,3,8,14,13,14,13,6,6,3,8,1,1,13,4,13) 
.code 


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
        JE  INPUT 
        mov DX,80
        jmp lp3 
        
        
    INPUT: 
     mov cx,0
     mov dx,0 
    
    mov ax,0000h
    int 33h 
    
    INPUT1:
       
        mov ax,0001h
        int 33h 
        mov ax,0003h
        int 33h
        cmp bx,1
        jne input1
        
        CMP CX,160
        JG CHK_C1
         jl input1
    
    
    CHK_C1:
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
    mov al,array[si]
     BOXM 240d,240d  
        jmp INPUT1 
        
    B9:
mov si,9
    mov al,array[si]
       BOXM 240d,320d   
        jmp INPUT1
    B13:
mov si,13
    mov al,array[si]
       BOXM 240d,400d   
        jmp INPUT1
            
        
    B1: 
    mov si,1
    mov al,array[si]
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
mov si,2
    mov al,array[si]
        BOXM 320d,160d
        jmp INPUT1   
         
    B6:
mov si,6
    mov al,array[si]
       BOXM 320d,240d   
        jmp INPUT1 
        
    B10:
mov si,10
    mov al,array[si]
       BOXM 320d,320d   
        jmp INPUT1
    B14:
mov si,14
    mov al,array[si]
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
mov si,3
    mov al,array[si]
        BOXM 400d,160d
        jmp INPUT1
    
    B7:
    mov si,7
    mov al,array[si]
   BOXM 400d,240d   
        jmp INPUT1 
        
    B11:
mov si,11
    mov al,array[si]
       BOXM 400d,320d   
        jmp INPUT1
    B15:
mov si,15
    mov al,array[si]
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
mov si,4
    mov al,array[si]
        BOXM 480d,160d
        jmp INPUT1 
        
     B8:
mov si,8
    mov al,array[si]
       BOXM 480d,240d   
        jmp INPUT1 
        
    B12:
mov si,12
    mov al,array[si]
       BOXM 480d,320d   
        jmp INPUT1
    B16:
mov si,16
    mov al,array[si]
       BOXM 480d,400d   
        jmp INPUT1        
      
        
    EXIT:
        MOV AH,4CH
        INT 21H
        MAIN ENDP
END MAIN