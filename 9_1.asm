;将s处的一条指令复制到s0处
assume  cs:codesg

codesg  segment
        s:  mov ax,bx
            mov si, offset  s   ;mov   ax,bx的机器码占用两个字节
            mov di, offset  s0  ;nop占用一个字节
            mov ax,cs:[si]
            mov cs:[di],ax
        s0: nop
            nop
codesg  ends
end s