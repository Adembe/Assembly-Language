name 'lab1.1'

org 100h

mov ah,01h
int 21h

mov ah,02h
mov dl,3Dh
mov bl,al
int 21h
mov al,bl

mov cx,08h
start: shl al,1
       jnc print
       mov dl, 31h
       mov bl, al
       int 21h
       mov al, bl
       loop start
       ret
print: mov dl, 30h
       mov bl, al
       int 21h
       mov al, bl
       loop start
       ret  
       
