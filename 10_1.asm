;使ret执行后 CS:IP指向代码段的第一条指令
assume  cs:code

stack   segment

stack   ends

code    segment
        mov ax,4c00H
        int 21H
        start:  mov ax,stack
                mov ss,ax
                mov sp,16

                mov ax,0
                push    ax
                mov bx,0
                ret         ;相当于pop ip
code    ends
end start