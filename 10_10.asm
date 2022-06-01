;使用子程序计算N的三次方
;使用寄存器传递参数和结果
assume  cs:code
data    segment
    dw  1,2,3,4,5,6,7,8
    dd  0,0,0,0,0,0,0,0
data    ends
code    segment
    start:  mov ax,data
            mov ds,ax
            mov si,0
            mov di,16

            mov cx,8
        s:  mov bx,[si]     ;把参数放入bx中
            call    cube
            mov [di],ax
            mov [di].2,dx
            add si,2
            add di,4
            loop    s

            mov ax,4c00H
            int 21H

    cube:   mov ax,bx   ;取出bx中的参数计算
            mul bx      ;[ax]*bx=bx^2   最大64<2^16
            mul bx      ;       16位乘法结果放在ax(低16位)和dx(高16位)中
            ret         
code    ends
end start