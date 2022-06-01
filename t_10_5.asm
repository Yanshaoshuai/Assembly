assume  cs:code

stack   segment
    dw  8   dup(0)
stack   ends

code    segment
        start:  mov ax,stack
                mov ss,ax
                mov sp,16
                mov ds,ax
                mov ax,0
                call    word    ptr ds:[0eh]    ;push   cs
                                                ;push   ip
                inc ax
                inc ax
                inc ax
                mov ax,4c00H
                int 21H
code    ends
end start