data segment
num1 db 03h
num2 db 02h
result db ?
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov al,num1
mov bl,num2
sub al,bl
mov result,al
mov ah,4ch
int 21h
code ends
end start