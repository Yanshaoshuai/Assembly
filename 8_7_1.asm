;计算100001/100
;被除数100001=186a1H>65535=FFFF=2^16-1
;所以被除数是32位除数是16位
assume  cs:codesg

codesg  segment
        start:  mov dx,1        ;被除数高16位存放在dx 
                mov ax,86a1h    ;被除数低16位存放在ax中
                mov bx,100      ;把除数放入bx
                div bx          ;(dx)*10000H+(ax)的值除以bx中的值
                                ;ax=1000=03e8 dx=1
                mov ax,4c00H
                int 21H
codesg  ends
end start