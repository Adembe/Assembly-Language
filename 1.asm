name '1'

org 100h

mov ah,01h
int 21h
          
mov bl,al 
mov ah,02h
mov dl,'='
int 21h          
          
mov ah,0h
mov al,bl
                
       
mov bl,10h
div bl
add al,33h
add ah,36h   
   
mov dh,ah

mov ah,02h
mov dl,al 
int 21h

mov ah,02h
mov dl,dh
int 21h


ret