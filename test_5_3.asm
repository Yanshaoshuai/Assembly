assume  cs:code,ds:data,ss:stack

code    segment

;start:  mov ax,stack   ;数据和栈在后面定义,不写标号也可以
        mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,data
        mov ds,ax

        push    ds:[0]
        push    ds:[2]
        pop     ds:[2]
        pop     ds:[0]

        mov ax,4c00H
        int 21H
code    ends

data    segment
    dw  0123h,0456h
data    ends
stack   segment
    dw  0,0
stack   ends

;end start  ;数据和栈在后面定义,不写标号也可以
end 