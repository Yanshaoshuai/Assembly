;把字符串转大写
assume  cs:code

data    segment
    db  'conversation'
data    ends

code    segment
        start:  mov ax,data
                mov ds,ax
                mov si,0
                mov cx,12           ;cx保存字符串长度
                call    capital     ;调用capital
                mov ax,4c00H
                int 21H
    capital:    and byte    ptr [si],11011111B  ;循环cx次把字母转成大写
                inc si                          ;指向下一字符
                loop    capital
                ret
code    ends
end start