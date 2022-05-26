;使用[bx+idata] 把datasg段第一个字符串转大写 第二个字符串转小写
;使用idata[bx]表示 [bx+idata] 
assume  cs:codesg,ds:datasg
datasg  segment
    db  'BaSiC'
    db  'MinIX'
datasg  ends
codesg  segment
    start:  mov ax,datasg
            mov ds,ax
            mov bx,0
            mov cx,5
        s:  mov al,0[bx]
            and al,11011111B
            mov 0[bx],al
            mov al,5[bx]        ;5[bx]=[bx+5]
            or  al,00100000B
            mov 5[bx],al
            inc bx
            loop    s

            mov ax,4c00H
            int 21H
codesg  ends
end start

comment /*
;c语言版本
char    str_1[5]="BaSiC";
char    str_2[5]="MinIX";

int main(){
    int i;
    i=0;
    do
    {
        str_1[i]=str_1[i]&0xDF;
        str_2[i]=str_2[i]|0x20;
        i++;
    } while (i<5);
    
    return 0;
}
*/