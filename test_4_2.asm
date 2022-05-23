;向内存0:200~0:23F依次写入0~63(3FH) 只用9条指令
assume cs:code
code    segment
    mov ax,0020h
    mov ds,ax

    mov bx,0
    mov cx,64


s:  mov [bx],bx

    inc bx
    loop s

    mov ax,4c00H
    int 21H
code ends
end
