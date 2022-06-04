;编写子程序 计算128位数字的和
assume  cs:code
data    segment
       dw   0ffffh,0ffffh,0ffffh,0ffffh,0ffffh,0ffffh,0ffffh,0ffffh     ;存放128位数    高位存在高地址  低位存在低地址
       dw   1h,0h,0h,0h,0h,0h,0h,0h
data    ends
code    segment
            start:  mov ax,data
                    mov ds,ax
                    mov si,0
                    mov di,16
                    call   add128

                    mov ax,4c00h
                    int 21h

            add128: push    ax
                    push    cx
                    push    si
                    push    di  

                    sub ax,ax       ;将CF设置为0

                    mov cx,8
                s:  mov ax,[si]
                    adc ax,[di]     ;adc ax,di  ==>(ax)=(ax)+([di])+CF
                    mov [si],ax
                    inc si          ;inc不会影响CF 此处不能用add
                    inc si
                    inc di
                    inc di
                    loop    s

                    pop di
                    pop si
                    pop cx
                    pop ax
                    ret
code    ends
end start