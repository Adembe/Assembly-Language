
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

org 100h
         
         
 max db 19 ;
 temdegt db 0
 string db 19 DUP (0)
 shineMur db 13,10,13,10,'$'
 hex1 db ?    
 hex2 db '  $'   
 space db ' $'        

MacroDecimal Macro p1     
    mov bl,bh               
   
    mov ah,02                
    mov al,bl               
    
    mov al,bl               
    aam                     
                            
    push ax                
    mov bl,ah               
    mov al,bl               
    aam                     
    
    add ax,3030h            
    push ax                 
    mov dl,ah               
    mov ah,02
    int 21h                 
    pop dx                  
    mov ah,02h              
    int 21h                 
    
    pop ax                  
    add ax,3030h            
    mov dl,al               
    mov ah,02h              
    int 21h
                    
ENDM

MacroBinary Macro p2

    mov al,bh    
    mov bl,al
    
    mov ah,02h
    mov al,bh
    
    mov cx,08h
    
    start_loop: shl al,1
                jnc print_zero
                mov dl,31h
                mov bl,al
                int 21h
                mov al,bl
                loop start_loop
                jmp leave         
                            
    print_zero: mov dl,30h
                mov bl,al
                int 21h
                mov al,bl
                loop start_loop 
                
    leave: 
ENDM

MacroHex Macro p3
    mov al, bh    
    mov cl,al

    mov al,bh
    shr al,4
    mov dl,al
    cmp dl,9
    jg add7
    jle add30
    
    add7: add dl, 7h
    add30: add dl, 30h
           
    mov ah,02h          
    int 21h
    
    mov al,bh    
    shl al,4
    shr al,4
    mov dl,al
    cmp dl,9
    jg add0
    jle add1 

    add0: add dl, 7h
    add1: add dl, 30h  
    
    mov ah,02h          
    int 21h    
ENDM
  

.code
  mov  ax, @data
  mov  ds, ax
  mov dx, offset msg1     
  mov ah, 9
  int 21h
  mov  AH, 0Ah
  lea  DX, max
  int  21h
           
; Hex start
  mov dx, offset msg2     
  mov ah, 9
  int 21h        
  mov ah, 01h
  mov ah, 2        
  mov dl, 3Dh        
  int 21h  

  mov  cl, temdegt
  mov  ch, 0  
  mov  SI, offset string

loopHex:  mov di,cx
          mov bh, [si] 
          
          MacroHex bh
                    
          mov cx, di
          mov ah, 9
          mov dx, offset space
          int 21h  
        
          inc si 
          loop loopHex
        ; Hext end
          
; Binary start
  mov dx, offset msg3     
  mov ah, 9
  int 21h        
  mov ah, 01h
  mov ah, 2        
  mov dl, 3Dh        
  int 21h  

  mov  CL, temdegt
  mov  ch, 0  
  mov  SI, offset string

loopBinary:   mov DI, CX
              mov BH, [SI] 
              
              MacroBinary bh
                        
              mov CX, DI
              mov ah, 9
              mov dx, offset space
              int 21h  
            
              inc si 
              loop loopBinary
; Binary end 

; Decimal start
  mov dx, offset msg4     
  mov ah, 9
  int 21h        
  mov ah, 01h
  mov ah, 2        
  mov dl, 3Dh        
  int 21h  

  mov  CL, temdegt
  mov  ch, 0  
  mov  SI, offset string

loopDecimal:  mov BH, [SI] 
              
              MacroDecimal BH
            
              mov ah, 9
              mov dx, offset space
              int 21h  
            
              inc si 
              loop loopDecimal
            ; Decimal end   
                         
mov AH,4Ch
int 21h   

msg1: db "Garaas unshsan temdegt=$"
newline db 10, 13, "$"
msg2: db 0ah, 0dh, "Hex utga ni$"
msg3: db 0ah, 0dh, "Binary utga ni$"
msg4: db 0ah, 0dh, "Decimal utga ni$"


ret




