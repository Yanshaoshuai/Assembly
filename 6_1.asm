;求0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h的和
assume cs:code
code segment
    ;dw define word 定义自数据 8086 1word=2byte
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
    ;程序开始处 需要设置ip为此处地址才能正确运行
    mov bx,0
    mov ax,0

    mov cx,8
s:  add ax,cs:[bx]
    add bx,2    ;每次+2
    loop s

    mov ax,4c00H
    int 21H
code ends
end
