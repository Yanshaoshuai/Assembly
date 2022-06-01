;使retf 执行后 从1000:0000处执行指令
assume  cs:code

stack   segment
    db  16  dup(0)
stack   ends
code    segment
    start:  mov ax,stack
            mov ss,ax
            mov sp,16
            mov ax,1000h
            push    ax
            mov ax,0
            push    ax
            retf    ;   pop ip
                    ;   pop cs
code    ends
end start