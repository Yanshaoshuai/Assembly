;把字符串中的字母全改成大写
;使用dx暂存外部循环cx
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

        s0: mov dx,cx   ;用dx保存外循环
            mov si,0
            mov cx,3        ;每行3列    
        s:  mov al,[bx+si]  ;内循环 每一行变大写
            and al,11011111B
            mov [bx+si],al
            inc si
            loop    s

            add bx,16
            mov cx,dx   ;恢复外层循环cx
            loop    s0

            mov ax,4c00H
            int 21H
codesg  ends

end start
