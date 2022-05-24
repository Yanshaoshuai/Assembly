;用0:0~15单元的数据改写程序中的数据
assume cs:codesg
codesg  segment
      ;dw define word 定义自数据 8086 1word=2byte
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
start:  mov ax,0
        mov ds,ax
        mov bx,0

        mov cx,8
    s:  mov ax,[bx]
        mov cs:[bx],ax
        add bx,2
        loop    s

        mov ax,4c00H
        int 21H
codesg  ends
end start