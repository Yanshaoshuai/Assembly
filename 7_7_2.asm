;把datasg段中第一个字符串复制到第二个字符串中
;使用[si+idata]的方式
assume  cs:codesg,ds:datasg
datasg  segment
    db  "welcome to masm!"
    db  "..............."
datasg  ends
codesg  segment
    start:  mov ax,datasg
            mov ds,ax
            mov si,0

            mov cx,8
        s:  mov ax,0[si]
            mov 16[si],ax
            add si,2
            loop    s

            mov ax,4c00H
            int 21H
codesg  ends
end start