assume  cs:code
code    segment
    start:  mov ax,6
            call    ax  ;   push ip（指向下一条指令）
            inc ax          ;该条指令偏移地址是5
            mov bp,sp       ;该条指令偏移地址是6
            add ax,[bp]     ;bp默认段是ss
code    ends
end start
