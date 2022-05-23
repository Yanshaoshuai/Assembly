;求0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h的和
assume cs:code
code segment
    ;dw define word 定义自数据 8086 1word=2byte
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
;使用start指定程序入口
start:  mov bx,0
        mov ax,0

        mov cx,8
s:      add ax,cs:[bx]
        add bx,2    ;每次+2
        loop s

        mov ax,4c00H
        int 21H
code ends
end start   ;end 标号 通知编译器入口在start处 并在此结束
