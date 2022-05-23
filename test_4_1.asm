;向内存0:200~0:23F依次写入0~63(3FH)
assume cs:code
code    segment
    mov ax,0020h
    mov ds,ax

    mov bx,0
    mov cx,64

    mov dl,0

s:  mov [bx],dl

    inc bx
    inc dl
    loop s

    mov ax,4c00H
    int 21H
code ends
end
