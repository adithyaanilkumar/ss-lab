.model small
.stack
print macro p
            lea dx,p
            mov ah,09h
            int 21h
endm
.data
            m1 db 0ah,0dh,"Enter the String:$"
            m2 db 0ah,0dh,"Enter the Substring:$"
            m3 db 0ah,0dh,"String Found$"
            m4 db 0ah,0dh,"String not Found$"
            a db 20h dup("$");
            b db 20h dup("$");
            k dw 0
            f db 0
.code
            mov ax,@data
            mov ds,ax
            mov es,ax
            mov si,0000h
            mov di,0000h
            print m1

loop1:  mov ah,01h
            int  21h
            mov a[si],al
            inc si
            inc k
            cmp al,0dh
            jne loop1
           
            print m2

loop2:  mov ah,01h
            int  21h
            mov b[di],al
            inc di
            inc cl
            cmp al,0dh
            jne loop2

            mov f,cl
            mov si,0000h
            mov di,0000h
            mov ax,0000h

loop3:  mov bh,a[si]
            mov bl,b[di]
            inc si
            inc di
            cmp bh,bl
            jne l1
            loop loop3
            jmp l2

l1:        inc ax
            mov si,ax
            mov cl,f
            mov di,0000h
            mov bx,k
            cmp ax,bx
            jl loop3
            jmp l3

l2:        print m3
            jmp l4

l3:        print m4

l4:        mov ah,4ch
            int 21h
end
