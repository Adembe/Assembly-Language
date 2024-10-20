org 100h 
    mov dx, offset buffer
    mov ah, 0ah
    int 21h
    jmp print
    buffer db 20,?, 20 dup(' ')
    
    print:
    xor bx, bx
    mov bl, buffer[1]
    mov buffer[bx+2],'$'
    mov cl, buffer[1]
    mov di, 2
    mov ah, 2
    mov dl, 10
    int 21h
    mov ah, 2
    mov dl, 13
    int 21h
    
    mov dx, offset hex
    mov ah, 09h
    int 21h 
    
    hex_loop:mov bl,buffer[di]
             mov al,bl
             shr al,4
             add al,30h
             mov dl,al
             mov ah,02h
             int 21h
             mov al,bl
             shl al,4
             shr al,4
             add al,30h
             mov dl,al
             mov ah,02h
             int 21h
             mov ah,02h
             mov dl, " "
             int 21h
             inc di
             loop hex_loop
            
    xor cx,cx
    mov cl,buffer[1]          
    mov di,2
    mov dx, offset decimal
    mov ah, 09h
    int 21h 
     
    dec_loop: mov bl,buffer[di]
              mov al,bl
              call dec_print
              mov ah,02h
              mov dl, " "
              int 21h
              inc di
              loop dec_loop
              ret
              
                
    dec_print:  mov al,bl
                aam
                
                push ax
                mov bl,ah
                mov al,bl
                aam
                add ah,30h
                add al,30h
                
                mov dl,ah
                mov dh,al
                mov ah,02h
                int 21h
                mov dl,dh
                mov ah,02h
                int 21h
                pop ax
                add al,30h
                mov dl,al   
                mov ah,02h
                int 21h
               
    
    ret

    hexdigit db '0123456789ABCDEF'
    hex db 'heximal utga ni: $'
    decimal db 0dh, 0ah,'decimal utga ni: $'
    


