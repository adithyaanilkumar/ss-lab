.MODEL SMALL
.DATA
inp db 0ah,0dh,'enter the string: ','$'
msg db 0ah,0dh,'the number of vowels: ','$'
vowel db 'a','A','e','E','i','I','o','O','u','U','$'
databuf db 100,0,100 dup('$')
.code
START:
 mov ax,@data
 mov ds,ax
 
 lea dx,inp
 mov ah,09h
 int 21h
 
 lea dx,databuf
 mov ah,0ah
 int 21h
 mov si,dx
 
 lea dx,msg
 mov ah,09h
 int 21h
       
 mov bl,00h
check:  lea di,vowel
 mov cx,000ah
 mov al,[si]
cont:
 cmp al,[di]
 je found
 inc di
 loop cont
 jmp next
found:  inc bl
next:   inc si
 cmp databuf[si],0ah
 jne check
 mov dl,bl
 add dl,30h
 mov ah,02h
 int 21h
 

.EXIT
END START
