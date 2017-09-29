     EXTERN SET_DISPLAY_MODE:NEAR,DISPLAY_BALL:NEAR 
     PUBLIC KEY
     
    .MODEL  SMALL
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
    ;then
            CALL    DO_FUNCTION     ;execute function
            JMP     NEXT_KEY        ;get next keystroke
    ELSE_:			       ;display character
            MOV     AH,2            ;display character func
            MOV     DL,AL           ;GET CHARACTER
            INT     21H             ;display character
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
    ; operates the arrow keys
    ; input: AH scan code
    ; output: none
            PUSH    BX
            PUSH    CX
            PUSH    DX
            PUSH    AX              ;save scan code
   
    ;case scan code of
            
            CMP     AH,75           ;left arrow?
            JE      CURSOR_LEFT     ;yes, execute
            CMP     AH,77           ;right arrow?
            JE      CURSOR_RIGHT    ;yes, execute
            JMP     EXIT            ;other function key
    
    CURSOR_LEFT:
            
            JMP     EXECUTE1         ;go to execute
    CURSOR_RIGHT:               
            
            JMP     EXECUTE2         ;go to execute
    
    EXECUTE1:
        MOV AL,0
        CALL DISPLAY_BALL
        MOV AL,3
        SUB CX,30
        call DISPLAY_BALL   
    EXECUTE2:
    MOV AL,0
    call DISPLAY_BALL
    MOV AL,3
    add CX,30
    call DISPLAY_BALL
           
    EXIT:
            POP     DX
            POP     CX
            POP     BX
            RET             
    DO_FUNCTION     ENDP
            END 

