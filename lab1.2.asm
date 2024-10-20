name 'lab1.2'

org 100h

MOV ah,01h
int 21h     

mov ah,02h
mov dl,3Dh
mov bl,al
int 21h
mov al,bl


shr al,4
mov dl,al
cmp dl,9
JG ADD7
JLE ADD30
ADD7:
    add dl, 7h
ADD30:
    add dl, 30h
       
mov ah,02h          
int 21h

    mov al,bl    
    shl al,4
    shr al,4
    mov dl,al
    cmp dl,9
    JG ADD71
    JLE ADD301 

ADD71:
    add dl, 7h
ADD301:
    add dl, 30h  
mov ah,02h          
int 21h   
ret 
 