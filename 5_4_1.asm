assume cs:code
code segment
    mov ax,2000H
    mov ds,ax 
    ;mov al,[0] ;masm 编译器将[idata]视为idata数据 debug把[idata]视为内存单元
    ;mov bl,[1]
    ;mov cl,[2]
    ;mov dl,[3]
    ;masm 编译器使用如下格式表示内存单元
    ;[寄存器]masm编译器中可以识别为ds:[寄存器]
    mov al,ds:[0]
    mov bl,ds:[1]
    mov cl,ds:[2]
    mov dl,ds:[3]
    mov ax,4c00H
    int 21H
code ends
end
