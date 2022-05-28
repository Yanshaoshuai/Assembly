;找出2000H段第一个值为0的字节
assume  cs:code

code    segment
        start:  mov ax,2000h
                mov ds,ax
                mov bx,0
            s:  mov cl,[bx]
                mov ch,0
                jcxz    ok
                inc bx
                jmp short   s
            ok: mov dx,bx
                mov ax,4c00H
                int 21H
code    ends
end start