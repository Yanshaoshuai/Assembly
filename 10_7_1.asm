;ret和call配合使用
assume  cs:code

code    segment
        start:  mov ax,1
                mov cx,3
                call    s   ;push   ip
                            ;jmp    s
                mov bx,ax
                mov ax,4c00H
                int 21H
            s:  add ax,ax
                loop    s
                ret         ;pop    ip
code    ends
end start