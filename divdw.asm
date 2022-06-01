;X/N=int(H/N)*65536+(rem(H/N)*65536+L)/N
;dx=int(H/N)    ax=(rem(H/N)*65536+L)/N的商     cx=(rem(H/N)*65536+L)/N的余数
assume  cs:code
stack   segment
    dw  8 dup(0)
stack   ends
code    segment
        start:  mov ax,stack
                mov ss,ax
                mov sp,16

                mov ax,4240H    ;1000000/10=F4240H/0AH=186A0H...0
                mov dx,0FH
                mov cx,0AH
                call    divdw
                
                mov ax,4c00H
                int 21H
        divdw:  push    ax
                mov ax,dx
                mov dx,0
                div cx          ;dx=rem(H/N)    ax=int(H/N)结果的高16位

                mov bx,ax

                pop ax      ;dx=rem(H/N)    dx  ax  =(rem(H/N)*65535+L)
                div cx      ;(rem(H/N)*65535+L)/N   余数在dx,商在ax(结果的低16位)
                mov cx,dx   ;余数放到cx
                mov dx,bx   ;dx  = int(H/N) 结果的高16位

                ret
code    ends
end start