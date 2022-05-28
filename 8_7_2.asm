;计算1001/100
;被除数1001<65535 所以16位足够
;除数 100<255=2^8   所以8位足够
assume  cs:codesg

codesg  segment
        start:  mov ax,1001     ;被除数直接放在ax中
                mov bl,100      ;除数放在bl中
                div bl          ;(ax)的值除以bx中的值
                                ;al=0AH ah=01
                mov ax,4c00H
                int 21H
codesg  ends
end start