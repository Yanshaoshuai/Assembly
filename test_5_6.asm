;把a段中前8个字逆序放到b段中
assume  cs:code
a   segment
    dw  1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh
a   ends
b   segment
    dw  0,0,0,0,0,0,0,0
b   ends

code    segment
start:  mov ax,c
        mov ss,ax
        mov sp,16h

        mov ax,a
        mov ds,ax


        mov bx,0
        mov cx,8

    s:  push [bx]  
        add bx,2
        loop    s

        mov cx,8
        mov bx,0
        
        mov ax,b
        mov ds,ax

    s0: pop [bx]
        add bx,2
        loop    s0

        mov ax,4c00H
        int 21H
c segment
    dw  0,0,0,0,0,0,0,0
c   ends
code    ends
end start