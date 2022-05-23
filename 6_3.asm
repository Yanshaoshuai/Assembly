;0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h 逆序存放
assume cs:codesg
codesg segment
    ;dw define word 定义自数据 8086 1word=2byte
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
    ;定义栈空间
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
start:  mov ax,cs
        mov ss,ax
        mov sp,30h  ;设置栈顶ss:sp 指向 cs:30h

        mov bx,0
        mov cx,8
    s:  push cs:[bx]    ;依次将cs:0开头的的前8个字地址中的数据放入栈中
        add bx,2
        loop s

        mov bx,0
        mov cx,8
    s0: pop cs:[bx]     ;数据依次出栈到cs:0开头的8个字地址中
        add bx,2
        loop s0

        mov ax,4c00H
        int 21H
codesg ends
end start
