name 'calculator'

org 100h

jmp start


msg0 db 'enter the digit: $'
msg1 db 0dh, 0ah,'enter first number: $'
msg3 db 0dh, 0ah, 'enter the operator: $'
msg2 db 0dh, 0ah, 'enter second number: $'
msg4 db 0dh, 0ah, 'result: $'
len equ 17
num1 db len dup(0)
num2 db len dup(0)
sum db len dup(0)
carry db ?
digit db ?

start:  call input1 

        
        
        
Operator:   mov dx, offset msg3
            mov ah, 9
            int 21h
            mov ah,01h
            int 21h
            cmp al,2Bh
            je nemeh
            cmp al,2Dh
            je hasah
            cmp al,2Ah
            je vrjih


nemeh:  mov dx, offset msg4
        mov ah, 9
        int 21h
        xor bx,bx
        mov cx,len 
        mov bx,len-1     
        next_digit: mov al,num1[bx]
                    adc al,num2[bx]
                    aaa
                    mov sum[bx],al
                    dec bx
                    loop next_digit 
call print                    
                    


                    
hasah:  mov dx, offset msg4
        mov ah, 9
        int 21h
        xor bx,bx
        mov cx,len 
        mov bx,len-1     
        next1_digit:mov al,num1[bx]
                    sbb al,num2[bx]
                    aaa
                    mov sum[bx],al
                    dec bx
                    loop next1_digit
call print



vrjih:  mov dx, offset msg4
        mov ah, 9
        int 21h
        xor bx,bx
        mov cx,len-1               
        next2_digit: mov dx,cx
                     mov cx,len-1
                     next2_digit2: mov bx,cx
                                   mov al,num1[bx]
                                   mov bx,dx
                                   mul num2[bx]
                                   add bx,cx
                                   sub bx,17
                                   add al,sum[bx]
                                   add al,carry
                                   aam
                                   mov carry,ah                                                                     
                                   mov sum[bx],al
                                   dec bx
                                   loop next2_digit2
                     mov cx,dx
                     loop next2_digit
call print

  
input1: mov dx, offset msg1
        mov ah, 9
        int 21h
        xor bx,bx
        mov cx,len
        mov bx,9 
        number1: mov ah,01h
              int 21h 
              cmp al,0Dh
              je input2
              mov num1[bx],al
              inc bx
              loop number1  



input2: mov dx, offset msg2
        mov ah, 9
        int 21h
        xor bx,bx
        mov cx,len
        mov bx,9 
        number2: mov ah,01h
              int 21h 
              cmp al,0Dh
              je Operator  
              mov num2[bx],al
              inc bx
              loop number2  
                  

print: adc sum[bx], 0
       mov cx,len
       mov bx,0
       printN: mov al,sum[bx]
               or al,30h
               mov ah,0eh
               int 10h
               inc bx
               loop printN
