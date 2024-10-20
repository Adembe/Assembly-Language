name 'lab2'

org 100h

mov ah,01h
int 21h

mov ah,02h
mov bl,al
mov dl,'='
int 21h

mov al,bl
aam

mov ch,ah
mov cl,al
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

mov al,cl
add al,30h
mov dl,al   
mov ah,02h
int 21h
ret




