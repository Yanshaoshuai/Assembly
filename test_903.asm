;利用loop指令找到2000H段中第一个值为0的字节
assume  cs:code
code    segment
        start:  mov ax,2000h
                mov ds,ax
                mov bx,0
            s:  mov cl,[bx]
                mov ch,0
                inc cx
                inc bx
                loop    s
            ok: dec bx
                mov dx,bx
                mov ax,4c00H
                int 21H
code    ends
end start