;使retf指令执行后   cs:ip   指向代码段的第一条指令
assume  cs:code

stack   segment
    db  16  dup(0)
stack   ends

code    segment
            mov ax,4c00H
            int 21H
    start:  mov ax,stack
            mov ss,ax
            mov sp,16
            mov ax,0
            push    cs
            push    ax
            mov bx,0
            retf        ;pop    ip
                        ;pop    cs
code    ends
end start