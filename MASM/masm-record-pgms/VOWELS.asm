.model small
.stack 100h
.data
string db ?
msg db 10,13,"enter the string:$"
msg1 db 10,13, "no of vowels:$"
count db 0 
.code
main proc
mov ax,@data
mov ds,ax
mov es,ax
lea dx,msg
mov ah,09
int 21h
lea si,string
mov bl,0
input:mov ah,01
      int 21h
      mov [si],al
      inc si
      inc bl
      cmp al,13
      je t1
      jne input
t1:mov al,'$'
   mov [si],al
dec bl
lea si,string
mov cl,bl
find:mov al,[si]
     inc si
     cmp al,'a'
     je increase
     cmp al,'e'
     je increase
     cmp al,'i'
     je increase
     cmp al,'o'
     je increase
     cmp al,'u'
     je increase
     dec cl
     cmp cl,0
     jne find
     jmp toend
increase:
         inc count
         dec cl
         cmp cl,0
         jne find
toend:lea dx,msg1
      mov ah,09
      int 21h
      mov dl,count
      add dl,48
      mov ah,02
      int 21h
      mov ah,4ch
      int 21h
main endp
end main
