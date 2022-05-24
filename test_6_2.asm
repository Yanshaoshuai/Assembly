;用0:0~15单元的数据改写程序中的数据 用栈传送
assume  cs:codesg

codesg  segment
      ;dw define word 定义自数据 8086 1word=2byte
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
    dw 0,0,0,0,0,0,0,0,0,0

start:  mov ax,cs
        mov ss,ax
        mov sp,24H

        mov ax,0
        mov ds,ax
        mov bx,0
        mov cx,8

    s:  push    [bx]
        pop cs:[bx]
        add bx,2
        loop    s

        mov ax,4c00H
        int 21H
codesg  ends
end start