;字符串转大写   不传递长度  使用0表示结尾
assume  cs:code

data    segment
    db  'conversation',0    ;0代表字符串结束
data    ends

code    segment
        start:  mov ax,data
                mov ds,ax
                mov si,0
                call    capital
    capital:    mov cl,[si]
                mov ch,0
                jcxz    ok  ;如果当前访问到了0就结束
                and byte    ptr [si],11011111B
                inc si
                jmp short   capital
            ok: ret
code    ends
end start