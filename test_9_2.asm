assume  cs:code

data    segment
        dd  12345678H
data    ends

code    segment
        start:  mov ax,data
                mov ds,ax
                mov bx,0
                mov [bx],bx      ;低地址改变ip
                mov [bx+2],code ;高地址改变cs
                jmp dword   ptr ds:[0]
code    ends
end start