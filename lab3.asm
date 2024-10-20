

org 100h

arr db 1,31,45,64,110,135,62,131,32,72, 00h

mov si,1
mov cx,10
mov al,arr[si]
hamgiin_ih: cmp al,arr[si]
            ja nemeh
            mov al,arr[si]
nemeh:   inc si
         loop hamgiin_ih

aam   
mov bx,ax 
mov al,bh
aam 
mov cx,ax
add cx,3030h
mov dl,ch
mov ah,02h
int 21h
mov dl,cl

mov ah,02h
int 21h                                                        
add bl,30h
mov dl,bl

mov ah,02h
int 21h

ret 


     