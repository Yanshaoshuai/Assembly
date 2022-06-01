assume  cs:code
data    segment
    db  'word',0
    db  'unix',0
    db  'wind',0
    db  'good',0
data    ends
code    segment
        start:  mov ax,data
                mov ds,ax
                mov bx,0

                mov cx,4
            s:  mov si,bx       ;把起始地址存在si中
                call    capital
                add bx,5
                loop    s

                mov ax,4c00H
                int 21H
    capital:    push    cx          ;暂存要使用到的寄存器
                push    si
    change:     mov cl,[si]     ;把si中的字节放入cl中
                mov ch,0
                jcxz    ok  ;如果当前访问到了0就结束
                and byte    ptr [si],11011111B
                inc si
                jmp short   change
            ok: pop si          ;恢复寄存器
                pop cx
                ret           
code    ends
end start