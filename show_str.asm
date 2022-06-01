;show_str在屏幕指定位置 用指定颜色  显示一个用0结尾的字符串
assume  cs:code
data    segment
    db  'Welcome to masm!',0
data    ends
code    segment
        start:  mov dh,11    ;行号
                mov dl,72    ;列号
                mov cl,2    ;颜色
                mov ax,data
                mov ds,ax
                mov si,0    ;ds:si指向字符串首地址
                call    show_str

                mov ax,4c00H
                int 21H
    show_str:   push    di
                push    dx
                push    cx
                push    si
                push    ax
                push    bx
                push    es
                
                mov ax,0B800H
                mov es,ax           ;输出段地址
                mov ax,0a0h 
                mul dh              
                mov bx,ax           ;bx存放行首地址 
                mov dh,0
                mov di,dx           ;di存放列偏移地址
                
                mov ah,cl           ;颜色属性放到bh
                mov ch,0            ;ch置为0
        s:      mov cl,[si]         ;ds:[si]字节移入cx
                jcxz    ok          ;判断是否结束
                mov al,cl           ;bl存放要输出的字节
                mov es:[bx+di],ax   ;输出到缓冲区
                inc si
                add di,2            ;di+2
                loop    s

        ok:     pop es
                pop bx
                pop ax
                pop si
                pop cx
                pop dx
                pop di
                ret

code    ends
end start