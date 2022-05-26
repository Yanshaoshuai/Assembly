;把字符串中的字母全改成大写
;此程序不可行   内循环给cx复制覆盖了外循环
assume  cs:codesg,ds:datasg

datasg  segment
    db  'ibm             '
    db  'dec             '
    db  'dos             '
    db  'vax             '
datasg  ends
codesg  segment
    start:  mov ax,datasg
            mov ds,ax
            mov bx,0

            mov cx,4    ;外循环 4行
        s0: mov si,0
            mov cx,3        ;每行3列    
        s:  mov al,[bx+si]  ;内循环 每一行变大写
            and al,11011111B
            mov [bx+si],al
            inc si
            loop    s
            add bx,16
            loop    s0
codesg  ends

end start
