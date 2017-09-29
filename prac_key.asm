EXTERN SET_DISPLAY_MODE:NEAR,DISPLAY_BALL:NEAR ,var1:word,var2:word,clm:word,POS:WORD
PUBLIC KEY
.MODEL  SMALL
SET_RW MACRO X
    MOV SI,X
	MOV dx,POS[SI]
    ENDM
.STACK  100H  

.DATA
VAR DW 10 DUP(?)
V DW 10 DUP(?)

.CODE
    
    key    PROC
    ;get keystroke
            MOV     AH,0            ;keyboard input function
            INT     16H             ;AH=scan code,AL=ascii code
    WHILE_:
            ;MOV     AH,0            ;keyboard input function
            ;INT     16H             ;AH=scan code,AL=ascii code
            CMP     AH,1            ;ESC (exit character)?
            JE      END_WHILE       ;yes, exit
    ;if function key
            CMP     AL,0            ;AL = 0?
            JNE     ELSE_           ;no, character key
    
    ELSE_:			                ;display character
            MOV     AH,2            ;display character func
            MOV     DL,AL           ;GET CHARACTER
            INT     21H    
			MOV     AH,0            ;keyboard input function
            INT     16H  
			CALL    DO_FUNCTION     ;execute function
            JMP     NEXT_KEY        ;get next keystroke        ;display character
    NEXT_KEY:
            MOV     AH,0            ;get keystroke function
            INT     16H             ;AH=scan code,AL=ASCII code
            JMP     WHILE_
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
			CMP DL,'1'
			JE L1
			CMP DL,'2'
			JE L2
			CMP DL,'3'
			JE L3
			L1:
			MOV DX,POS[0]
			MOV VAR,0
			
			JMP     EXECUTE1

			L2:
			MOV VAR,1
			
			MOV DX,POS[1]
			JMP     EXECUTE1

			L3:
			MOV VAR,2
			
			MOV DX,POS[2]
            JMP     EXECUTE1
                    ;go to execute
    CURSOR_RIGHT:               
            
            CMP DL,'1'
			JE R1
			CMP DL,'2'
			JE R2
			CMP DL,'3'
			JE R3
			R1: 
			MOV VAR,0
			MOV DX,POS[0]
			JMP     EXECUTE2

			R2:
			MOV VAR,1
			MOV DX,POS[1]
			JMP     EXECUTE2

			R3:	         
			MOV VAR,2
			MOV DX,POS[2]
            JMP     EXECUTE2
    
    EXECUTE1:
        
        SET_RW VAR
        MOV AL,0 
        mov var1,10
        mov var2,10
    	
    	mov clm,cx
        add cx,var1
        mov var1,cx
        mov cx,clm
        
        
        sub dx,10
        mov var2,dx
        add dx,10
    
        CALL DISPLAY_BALL
	
        MOV AL,1
        sub cx,30  
		mov clm,cx           ;;colmn ke 30 ghor bame soralam ,tarpor var1 k 10 ghor dane
	
    	add cx,10
    	mov var1,cx
    	sub cx,10

	
		sub dx,10
    	mov var2,dx         ;;;row ke 10 ghor niche namalam ,tarpor var2 k 10 ghor upore
    	add dx,10
        call DISPLAY_BALL
	
        JMP EXIT   
    EXECUTE2:
	    SET_RW VAR
        MOV AL,0 
        mov var1,10
        mov var2,10
    	;MOV	CX,114 
    	mov clm,cx
        add cx,var1
        mov var1,cx
        mov cx,clm
        
        
        sub dx,10
        mov var2,dx
        add dx,10
        CALL DISPLAY_BALL

        MOV AL,1
        add cx,30
		mov clm,cx

        add cx,10
        mov var1,cx
        sub cx,10
        
        
       	mov var2,dx         ;;;row ke 10 ghor niche namalam ,tarpor var2 k 10 ghor upore
    	add dx,10
        call DISPLAY_BALL
	
        JMP EXIT   
           
    EXIT:
        
        RET             
    DO_FUNCTION     ENDP
 END 

