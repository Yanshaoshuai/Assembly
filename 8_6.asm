;修改过时数据
;元数据:                   起始地址    假设seg:60
;公司名称   DEC             00
;总裁姓名   Ken Olsen       03
;排名       137            0C
;收入       40             0E
;著名产品:  PDP            10

;新数据
;Ken Olsen在富豪榜排名上升至    38
;DEC收入增加    70亿美元
;著名产品变为   VAX系列计算机

assume  cs:codesg,ds:datasg

datasg  segment
    db  'DEC'
    db  'Ken Oslen'
    dw  137
    dw  40
    db  'PDP'
datasg  ends

codesg  segment
    start:  mov ax,datasg
            mov ds,ax
            mov bx,0

            mov word    ptr [bx+0ch],38 ;按字修改
            add word    ptr [bx+0eh],70

            mov si,0
            mov byte    ptr [bx+10h+si],'V' ;按字节修改
            inc si
            mov byte    ptr [bx+10h+si],'A'
            inc si
            mov byte    ptr [bx+10h+si],'X'

            mov ax,4c00H
            int 21H
codesg  ends
end start

comment /*
struct company dec = {"DEC", "Ken Olsen", 137, 40, "PDP"};

void change_company()
{
    int i;
    dec.pm = 38;
    dec.sr = dec.sr + 70;
    i = 0;
    dec.cp[i] = 'V';
    i++;
    dec.cp[i] = 'A';
    i++;
    dec.cp[i] = 'X';
}

*/