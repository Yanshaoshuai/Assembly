;debug  查看ax  bx  cx内容变化
assume  cs:codesg
codesg  segment
    start:  mov ax,2000h
            mov ds,ax
            mov bx,1000h
            mov si,0
            mov ax,[bx+2+si]
            inc si
            mov cx,[bx][si][2]
            inc si
            mov di,si
            add cx,[bx+di][2]
        mov ax,4c00H
        int 21H
codesg  ends
end start