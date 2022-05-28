assume  cs:codesg
data    segment
    db  "Welcome to masm!"
    db  00000010B,01000010,
data    ends
codesg  segment
        start:mov ax,0B800h
                mov ds,ax
                mov bx,0
                mov cx,320
            s:  mov word ptr [bx],0ca41h
                add bx,2
                loop    s
                mov ax,4c00H
                int 21H
codesg  ends
end start