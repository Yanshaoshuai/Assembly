;写出每条指令执行后 ZF  PF  SF等标志位的值
assume  cs:code
                                ;ax    bx       ZF      PF      SF
code    segment     
        start:  sub al,al       ;0              1       1       0
                mov al,1        ;1              1       1       0
                push    ax      ;               1       1       0
                pop bx          ;      1        1       1       0
                add al,bl       ;2H    1        0       0       0
                add al,10       ;0CH   1        0       1       0
                mul al          ;90H   1        0       1       0

                mov ax,4c00h
                int 21h
code    ends
end start