
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

mov ah,01h
int 21h

mov ah,02h
mov bl,al
mov dl,'='
int 21h
mov al,bl


sub al,30h
mov cl,al  

loop_start: inc dh
            add bh,dh
            loop loop_start
mov al,bh
aam
add ax,3030h
mov dl,ah
mov dh,al
mov ah,02h
int 21h
mov dl,dh
mov ah,02h
int 21h
ret            