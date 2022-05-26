;使用[bx+idata] 把datasg段第一个字符串转大写 第二个字符串转小写
assume  cs:codesg,ds:datasg
datasg  segment
    db  'BaSiC'
    db  'MinIX'
datasg  ends
codesg  segment
    start:  mov ax,datasg
            mov ds,ax
            mov bx,0
            mov cx,5
        s:  mov al,[bx]
            and al,11011111B
            mov [bx],al
            mov al,[bx+5]
            or  al,00100000B
            mov [bx+5],al
            inc bx
            loop    s

            mov ax,4c00H
            int 21H
codesg  ends
end start