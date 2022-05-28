;在屏幕中间输出Welcome to masm!
;绿色   绿底红色    白底蓝色    
;每行80个字符   每个字节分为属性(高16位)+ASCII(低16位)
;72-87         列
;11 12 13      行
;   7       6          5           4           3                2          1           0
;   BL      R          G           B           I                R          G           B
;  闪烁             背景色                    高亮                        前景色
assume  cs:codesg
data    segment
    db  "Welcome to masm!"
    db  00000010B,00100100B,01110001B   ;绿色   绿底红色    白底蓝色    
data    ends

stack   segment
        db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stack   ends
codesg  segment
        start:  mov ax,0B800h
                mov es,ax
                mov bp,0
                mov ax,data
                mov ds,ax
                mov bx,0
                
                mov ax,stack
                mov ss,ax
                mov sp,16

                mov cx,3
                mov si,0        ;行偏移量
                mov di,0        ;第几行
            s:  mov dh,[16+di]  ;移入属性
                push    cx
                mov cx,16
            s0: mov dl,[bx]                     ;写入字符
                mov es:[728H+bp+si],dx   ;写入缓冲区
                inc bx
                add bp,2
                loop    s0
                add si,0a0h
                pop cx
                mov bp,0
                mov bx,0
                inc di
                loop    s
                mov ax,4c00H
                int 21H
codesg  ends
end start