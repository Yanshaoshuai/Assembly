assume  cs:code

code    segment
    start:  mov ax,0
            call    far ptr s   ;push   cs
                                ;push   ip  （下一条指令）
            inc ax
        s:  pop ax
            add ax,ax
            pop bx
            add ax,bx
code    ends
end start
