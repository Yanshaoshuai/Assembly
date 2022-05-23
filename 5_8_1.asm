;将ffff:0~ffff:b单元中的数据复制到0:200~0:20b单元
;0:200~0:20b等同于0020:0~0020:b
assume cs:code
code    segment
    mov bx,0
    mov cx,12
s:  mov ax,0ffffh
    mov ds,ax
    mov dl,[bx] ;把ffff:[bx]数据取出到dl

    mov ax,0020h
    mov ds,ax
    mov [bx],dl;把dl中的数据放到0020:[bx]

    inc bx;地址+1指向下一个内存单元
    loop s

    mov ax,4c00H
    int 21H
code ends
end