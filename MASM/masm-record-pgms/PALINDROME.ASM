.model small
.stack 100h
.data
string db ?
msg1 db 10,13,"enter the string:$"
msg2 db 10,13,"string is a palindrome$"
msg3 db 10,13,"string is not a palindrome$"
.code
main proc
mov ax,@data
mov ds,ax
lea dx,msg1
mov ah,09
int 21h
lea si,string
input:mov ah,01
      int 21h
      mov [si],al
      cmp al,13
      je send
      inc si
      jne input

send:mov al,'$'
     mov [si],al
dec si
lea di,string
find:cmp si,di
     jl istrue
     mov al,[si]
     mov bl,[di]
     cmp al,bl
     jne isfalse
     inc di
     dec si
     jmp find
istrue:lea dx,msg2
       jmp toend
isfalse:lea dx,msg3
toend:mov ah,09
      int 21h
      mov ah,4ch
      int 21h

main endp
end main
