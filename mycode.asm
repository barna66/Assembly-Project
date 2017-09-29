.model small
.stack
.data
titlescreen db " __  __                       ", 10, 13
                db "|  \/  |                      ", 10, 13
                db "| \  / |  __ _  ____ ___  ___ ", 10, 13
                db "| |\/| | / _` ||_  // _ \/ __|", 10, 13
                db "| |  | || (_| | / /|  __/\__ \", 10, 13
                db "|_|  |_| \__,_|/___|\___||___/", 10, 13
                db "       _______________        ", 10, 13
                db "       |              |       ", 10, 13
                db "       |     play     |       ", 10, 13
                db "       |     game     |       ", 10, 13
                db "       |______________|       ", 10, 13
                db "                              $"
.code
main proc
    mov ax,@data
    mov ds,ax
    lea  dx, titlescreen            
    mov  ah, 9
    int  21h
      mov  ax,4C00h
    int  21h       
             main endp
end main
    
       