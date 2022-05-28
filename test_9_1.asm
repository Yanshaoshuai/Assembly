;jmp word   ptr 测试    只会修改 ip
;使cs:ip指向程序第一条指令
assume  cs:code

data    segment
        dw 0,0
data    ends
code    segment
        start:  mov ax,data
                mov ds,ax
                mov bx,0
                jmp word    ptr [bx+1]
code    ends
end start