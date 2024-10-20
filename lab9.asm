include 'emu8086.inc'
Convert_2 MACRO bp
LOCAL start_loop3, print_zero, exit
mov al, buffer[bp]



mov cx, 08h
start_loop3: shl al, 1
jnc print_zero
mov bin[si], 31h
inc si
loop start_loop3
jmp exit
print_zero: mov bin[si], 30h
inc si
loop start_loop3
exit:
mov bin[si], 20h
inc si
ENDM



Convert_10 MACRO buffer[]
LOCAL label1, label2, startloop1, a,return,exit
mov bp, 0
mov bin[si], 0Ah
inc si
start_loop1:
mov bh,buffer[bp]

label1:
mov AX, 0
mov AL, bh
mov BL, 10
DIV BL
CMP al, 0Ah
JB label2
mov bh,ah
mov ah, 0
MOV BL,10
DIV BL
mov ch,ah
add al, 30h

;mov ah, 2
; mov dl, al
;int 21h
mov bin[si], al
inc si

add ch, 30h

; mov ah, 2
; mov dl, ch
; int 21h
mov bin[si], ch
inc si

add bh ,30h

; mov ah, 2
; mov dl, bh
; int 21h
mov bin[si], bh
inc si

jmp return
label2:
add al, 30h
mov bh, ah

; mov ah, 2
; mov dl, al
; int 21h
mov bin[si], al
inc si

add bh, 30h

; mov ah, 2
; mov dl, bh
; int 21h
mov bin[si], bh
inc si



return:



;mov ah, 2
;mov dl, 20h
;int 21h
mov bin[si], 20h
inc si

inc bp
CMP buffer[bp], 0
jne start_loop1


exit:
ENDM



Convert_16 MACRO buffer[]

LOCAL label1, add_zero, startloop, a,return,exit,add_one,print,prm, add_0,add_1,l2,print1,prm1,label2
mov bp, 0
mov bin[si], 0Ah
inc si



start_loop:
mov bl,buffer[bp]
mov count, cl
mov bh,0
MOV CX, 4
label1:
SHL bl, 1
JNC add_zero
jmp add_one

add_zero:
SHL bh, 1
add bh, 0b
LOOP label1
jmp print
add_one:
SHL bh, 1
add bh, 1b
Loop label1
jmp print

print:
CMP bh, 0Ah
JB prm
add bh, 37h

;mov ah, 2
;mov dl, bh
;int 21h
mov bin[si], bh
inc si

mov bh, 00h
jmp l2

prm:
add bh, 30h

; mov ah, 2
; mov dl, bh
; int 21h
mov bin[si], bh
inc si

mov bh, 00h


l2:
mov cx, 4
label2:
SHL bl, 1
JNC add_0
jmp add_1

add_0:
SHL bh, 1
add bh, 0b
LOOP label2
jmp print1
add_1:
SHL bh, 1
add bh, 1b
Loop label2
jmp print1

print1:
cmp bh, 0Ah
JB prm1
add bh, 37h

; mov ah, 2
; mov dl, bh
; int 21h
mov bin[si], bh
inc si

jmp return
prm1:
add bh, 30h

; mov ah, 2
; mov dl, bh
; int 21h
mov bin[si], bh
inc si




return:
;mov ah, 2
;mov dl, 20h
;int 21h
mov bin[si], 20h
inc si

inc bp
CMP buffer[bp], 0
jne start_loop


exit:
ENDM



Convert MACRO
LOCAL loop0
;2t convert
mov si, 0
mov bp, 0
loop0:
Convert_2 bp
inc bp
CMP buffer[bp], 0
jne loop0
;10t con
Convert_10 buffer
Convert_16 buffer
ENDM



Read MACRO
;file neeh
mov dx, offset file
mov al,0
mov ah,3dh
int 21h
jc terminate
mov bx,ax



;file aas unshih
mov cx, 99
mov dx, offset buffer
mov ah, 3fh
int 21h
JZ terminate
;file haah
mov bx, handle
mov ah, 3eh
int 21h

ENDM



Create MACRO
;file uusgeh
mov ah, 3ch
mov cx, 0
mov dx, offset filename1
mov ah, 3ch
int 21h
jc err
mov handle, ax
err:
ENDM



Write MACRO

;filed bichih
mov bx, handle
mov dx, offset bin
mov cx, 100
mov ah, 40h
int 21h



;file haah
mov bx, handle
mov ah, 3eh
int 21h

ENDM





org 100h
mov ah, 00
mov al, 03h
int 10h
;mov ax, 1
;int 33h


PRINT "1.Read from file 2.Convertert 3.New file 4.Write to file"

mov ax, 0
int 33h
check_mouse_button:
mov ax, 3
int 33h
cmp bx, 1
jne xor_cursor:
jmp draw_pixel
xor_cursor:




check_esc_key:
mov dl, 255
mov ah, 6
int 21h
cmp al, 27 
jne check_mouse_button
jmp terminate

draw_pixel:
cmp cx, 7Ch
jb readf



cmp cx, 235d
jb Convertf



cmp cx, 332d
jb Createf
ja Writef
jmp terminate





readf:
Read
jmp check_mouse_button



Convertf:
Convert
jmp check_mouse_button



Createf:
Create
jmp check_mouse_button



Writef:
Write
jmp terminate




terminate:



mov ah, 0
int 16h



ret




file db "input.txt",0
buffer db 99 dup(0)
counter db 0
bin db 1000 dup(09h)
decimal db ?
hex db ?
count db ?
filename1 db "output.txt", 0
handle dw ?