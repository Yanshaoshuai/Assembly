; 初始值 21000H=be 21001H=00
assume cs:codesg
codesg segment

    mov ax,2000H
    mov ss,ax
    mov sp,0
    add sp,10
    pop ax
    pop bx
    push ax
    push bx

    mov ax,4c00H
    int 21H

codesg ends
end
    