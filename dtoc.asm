assume cs:code
data    segment
    db 10 dup(0)
data   ends
code    segment
        start:  mov ax,12666
                mov bx,data
                mov ds,bx

                mov si,0
                call    dtoc

                mov dh,11
                mov dl,4
                mov cl,2
                call    show_str

                mov ax,4c00H
                int 21H
        dtoc:   push    cx
                push    bx
                push    ax
                push    si
                push    dx
                mov cx,0
                mov dx,0
                mov  bx,10

            s:  div  bx
                mov  cx,ax   ;商为0结束
                push dx      ;dx余数入栈
                inc si
                jcxz ok      ;商为0跳转
                mov dx,0
                jmp short    s

           ok:  mov cx,si
                mov si,0
            s0: pop ax
                add ax,30h
                mov [si],ax
                inc si
                loop    s0

                pop dx
                pop si
                pop ax
                pop bx
                pop cx
                ret

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
        s2:     mov cl,[si]         ;ds:[si]字节移入cx
                jcxz    ok2          ;判断是否结束
                mov al,cl           ;bl存放要输出的字节
                mov es:[bx+di],ax   ;输出到缓冲区
                inc si
                add di,2            ;di+2
                jmp short    s2

        ok2:    pop es
                pop bx
                pop ax
                pop si
                pop cx
                pop dx
                pop di
                ret
code    ends
end    start