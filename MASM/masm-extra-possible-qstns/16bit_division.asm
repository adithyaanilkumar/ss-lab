data segment
num1 dw 2020h
num2 dw 1011h
result dw ?
a dw ?
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov ax,num1
mov bx,num2
div bx
mov result,dx
mov a,ax
mov ah,4ch
int 21h
code ends
end start