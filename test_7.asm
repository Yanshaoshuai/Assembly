;把data段中数据按照格式写入table段中
;并计算21年人均收入(取整)   结果也按照格式保存在table段中
assume  cs:codesg

data    segment
        db  '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db  '1984','1985','1986','1987','1988','1989','1990','1991','1992'
        db  '1993','1994','1995'
        ;以上是表示21年的21个字符串

        dd  16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd  345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
        ;以上是表示21年公司收入的21个dword数据

        dw  3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw  11542,14430,15257,17800
        ;以上是表示21年公司雇员人数的21个word数据
data    ends

table   segment
        db  21 dup('year summ ne ?? ')  ;21个16字节空间
table   ends

codesg  segment
        start:  mov ax,data
                mov ds,ax
                mov bx,0

                mov ax,table
                mov es,ax
                mov bp,0
                
                mov cx,21

            s:  mov si,0
                mov ax,[bx+si]      ;把年份写入第一列
                mov es:[bp+si],ax
                add si,2
                mov ax,[bx+si]
                mov es:[bp+si],ax

                mov si,0            
                mov ax,[bx+si+84]   ;把收入写入第二列
                mov es:[bp+si+5],ax
                add si,2
                mov ax,[bx+si+84]   
                mov es:[bp+si+5],ax
               
                add  bp,16
                add  bx,4
                loop    s

                mov bx,168
                mov bp,0
                mov cx,21
                
            s0: mov ax,[bx]         ;把雇员写入第三列
                mov es:[bp+10],ax

                mov ax,es:[bp+5]       ;计算收入
                mov dx,es:[bp+7]
                div word ptr es:[bp+10]
                
                mov es:[bp+13],ax

                add bx,2
                add bp,16
                loop    s0

                mov ax,4c00H
                int 21H
codesg  ends
end start