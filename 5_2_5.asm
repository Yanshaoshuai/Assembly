assume cs:code
code segment
    mov ax,0ffffh ;字母开头需要在前面加0
    mov ds,ax   ;累加器
    mov bx,6
    mov al,[bx]
    mov ah,0
    mov dx,0
    mov cx,123
s:  add dx,ax
    loop s 
    mov ax,4c00H
    int 21H
code ends
end