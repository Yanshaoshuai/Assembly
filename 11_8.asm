assume  cs:code

code    segment                     
            start:  mov ax,0F1H     ;ax=1111 0001      
                    mov bx,1        ;bx=0000 0001
                    mov cx,0F0H     ;cx=1111 0000
                                    ;   ZF       CF      SF      OF         unsign      sign
                    cmp ax,bx       ;   0        0       1       0
                    cmp ax,cx       ;   0        1       0       0
                    cmp ax,ax       ;   1        0       0       0

                    mov ax,4c00h
                    int 21h
code    ends
end start