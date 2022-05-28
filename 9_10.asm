;演示编译错误   jmp out of range by 1 byte(s)
assume  cs:code
code    segment
        start:  jmp short s     ;jmp short偏移范围是-128~127之间
                db  128 dup(0)
            s:  mov ax,0ffffh
code    ends
end start