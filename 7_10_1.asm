;把每个字符串的头一个字母改成大写
assume  cs:codesg,ds:datasg

datasg  segment
    db  '1. file         '
    db  '2. edit         '
    db  '3. search       '
    db  '4. view         '
    db  '5. options      '
    db  '6. help         '
datasg  ends

codesg  segment
    start:  mov ax,datasg
            mov ds,ax
            mov bx,0

            mov cx,6

        s:  mov al,[bx+3]
            and al,11011111B
            mov [bx+3],al   ;定位到第一个字母
            add bx,16       ;定位到下一个字符串起始地址
            loop    s

            mov ax,4c00H
            int 21H
codesg  ends
end start