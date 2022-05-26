;把datasg第一个字符串转大写,第二个字符串转小写  
;不用判断   小写转大写==>从右往左第6位改为0
;          大写转小写==>从右往左第6位改为1
assume  cs:codesg,ds:datasg

datasg  segment
    db  'BaSiC'
    db  'iNfOrMaTiOn'
datasg  ends

codesg  segment
start:  mov ax,datasg
        mov ds,ax
        mov bx,0
        mov cx,5
    s:  mov al,[bx]
        and al,11011111B    ;使用and把该字节从右往左第6位置为0
        mov [bx],al
        inc bx
        loop    s

        mov bx,5    ;指向第二个字符串首地址
        mov cx,11
    s0: mov al,[bx]
        or  al,00100000B    ;使用or把把该字节从右往左第6位置为1
        mov [bx],al
        inc bx
        loop    s0

        mov ax,4c00H
        int 21H
codesg  ends
end start