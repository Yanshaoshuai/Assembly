;计算ffff:0~ffff:b内存单元中数据的和
assume cs:code
code segment
    mov ax,0ffffh
    mov ds,ax 
    mov bx,0    ;初始化 ds:bx指向ffff:0

    mov dx,0    ;累加器置为0

    mov cx,12   ;设置计数器

s:  mov al,[bx] ;[寄存器]masm编译器中可以识别为ds:[寄存器]
    mov ah,0
    add dx,ax
    inc bx  ;偏移地址+1 ds:bx指向下一内存单元
    loop s  
    int 21H
code ends
end

