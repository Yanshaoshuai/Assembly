;依次把a段b段对应位置相加放到c段对应位置
assume  cs:code
a   segment
    db  1,2,3,4,5,6,7,8
a   ends
b   segment
    db  1,2,3,4,5,6,7,8
b   ends

c   segment
    db  0,0,0,0,0,0,0,0,0
c   ends

code    segment
start:  mov bx,0
        mov cx,8

    s:  mov ax,a
        mov ds,ax
        mov dl,0
        add dl,[bx]
        inc ax
        mov ds,ax
        add dl,[bx]
        inc ax
        mov ds,ax
        mov [bx],dl
        inc bx
        loop    s

        mov ax,4c00H
        int 21H
code    ends
end start