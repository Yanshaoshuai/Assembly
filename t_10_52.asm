assume  cs:code

data    segment
    dw  8 dup(0)
data    ends

code    segment
    start:  mov ax,data
            mov ss,ax
            mov sp,16
            mov word    ptr ss:[0],offset   s   ;把标号s的偏移地址移入栈的第0个字
            mov ss:[2],cs                       ;把cs移入栈的第二个字
            call    dword   ptr ss:[0]          ;push   cs
                                                ;push   ip
                                                ;jmp    ip=ss:[0]   cs=ss:[2]
            nop
        s:  mov ax,offset   s       
            sub ax,ss:[0cH]     ;[ax]-[ip](call之前)=1
            mov bx,cs           
            sub bx,ss:[0eh]     ;[bx]-cs=0
            mov ax,4c00H
            int 21H
code    ends
end start