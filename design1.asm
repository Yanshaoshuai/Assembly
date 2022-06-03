assume cs:code,ds:data,ss:stack
;每写一个部分前后空行隔开，并且中间加上注释
;!!!编程序不能光想，还要在纸上演算

;改初始的值+仔细观察换行字符si的变化
data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
    ;db为字节类型
    ;偏移量为0+si*4B
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;dd为双字类型
	;偏移量为84+si*4B
	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	;dw为字类型,字类型共有2B，压栈四次然后出栈四次
	;偏移量为168+si*2B
	;发现偏移量不对时就应该检查偏移量的地址
	
	;之前偏移量的公式运算错误导致程序出错
data ends

stack segment
	db 200 dup(0)
stack ends
;思路：用db存储应该加入的空格数量,然后按行来输出
code segment
start:mov ax,data
	  mov ds,ax
	  mov si,0;ds:bp指向data部分区域
	  mov cx,21
	  mov ax,0b800h
	  mov es,ax
	  mov si,0000h;es:si屏幕显示区域
	  mov ax,stack
	  mov ss,ax
	  mov sp,00c8h
	  mov bl,0;bl用于指向现在循环的是第几行
	  
	  ;s用于每行的大循环
	  ;bl数据出现问题，si数据出现问题
    s:
	  ;ip = 001d,si = 003e
	  
	  push cx
	  mov cx,4
	  mov bh,32;bh用来记录0的ascii码
	  
	  mov al,160
	  mov ah,bl
	  mul ah
	  mov si,ax;屏幕显示区域的段内偏移=行数*每行偏移量
	  ;算出具体每行的偏移量
	  
	  ;循环2:si = 00a0
	  
	  ;s1循环用于每行开始填14个空格
   s1:;mov es:[si],bh
      inc si
	  inc si
	  loop s1;填补空格
	  
	  mov bh,0
	  mov al,bl
	  mov ah,4
	  mul ah;算出0+bl*4B为年份的字符串所在的位置
	  ;结果在ax中
      
	  mov bp,ax
	  mov cx,4;将字符串的偏移量放入bp中
	  ;并设置循环次数
	  
	  ;s2循环用于将表示年份的字符串放入
	  ;屏幕显示区域的内存之中
   s2:mov al,ds:[bp]
      mov es:[si],al
	  inc bp
	  inc si
	  mov al,02h
	  mov es:[si],al
	  inc si
	  loop s2;每次放入一个字节，循环4次
      ;ip = 0049
	  
	  ;s3循环用于输出完年份之后中间再加5个空格
	  mov cx,5
	  mov bh,32
   s3:;mov es:[si],bh
      inc si
	  ;mov al,02h
	  ;mov es:[si],al
	  inc si
	  loop s3
	  
	  ;算出下一行数字所显示的偏移量
	  ;公式为4*21+bl*4B,即84+bl*4B,bl为每行的行号
	  ;之前这里出现bug，错写为84+bl*8B
	  mov al,bl
	  mov ah,4
	  mul ah
	  add ax,84
	  
	  mov bp,ax;bp保存偏移量
	  
	  mov ax,ds:[bp]
	  inc bp
	  inc bp
	  mov dx,ds:[bp]
	  inc bp
	  inc bp;高位数字保存在dx之中
	  ;低位数字保存在ax中
	  mov cx,10;除数保存在cx之中
	  ;ip = 0070h
	  
	  push dx
	  push ax;数据压栈，方便后面做除法使用
	  
	  ;ip = 0082,si = 001a
	  
	  call calcul
	  ;调用函数时会将主函数地址压栈，方便函数返回
	  
	  mov cx,4
	  mov al,32
	  mov ah,02h
   s8:;mov es:[si],al
      inc si
	  ;mov es:[si],ah
	  inc si
	  loop s8;补上4个空格
	  
	  ;ip = 0096,si = 0030
	  
	  ;计算下一个数字在data段中的偏移量
	  ;下一个数字偏移量计算公式为8*21+bl*2B
	  ;即168+bl*2B
	  mov ah,2
	  mov al,bl
	  mul ah
	  add ax,168
	  mov bp,ax
	  
	  ;si = 0030
	  
	  mov ax,ds:[bp]
	  inc bp
	  inc bp
	  ;这边出现bug，少加一次bp
      mov dx,0000
	  mov cx,10;将相应数字赋值,dx=0000
	  ;ax = 对应值
	  
	  push ax;保存数据，方便后面做除法使用
	  
	  ;bp = 00aa,si = 0030
	  
	  call calcul
	  ;就一个字，用ax存储,dx存储0
	  ;继续转换为ascii码,这里面出来的ax，bx与cx无意义
	  ;有意义的数已存入屏幕存储区
	  
	  ;ip = 00af,si = 003e
	  
	  pop cx
	  pop ax
	  pop dx
	;先将下面注释掉
	  call divdw;恢复数字进行除法
	  ;除法后dx保存高位商，ax保存低位商
	  call calcul;将数字转换为ascii码
	  
      pop cx
      inc bl;恢复循环次数and行号加一
	  sub cx,1
	  jcxz ok
	  jmp s
	  ;之前这里写错为loop s8导致屏幕一直显示绿色
	  ;debug循环只运行到了2793没有运行出最后的结果
	  ;说明中间存在bug
	  ;功能实现指令的无条件跳转
	  ;****这里直接loop无法实现，必须借助jcxz进行跳转
	  
   ok:mov ax,4c00h
	  int 21h
	  
calcul:;该函数计算将高16位保存在dx中
;低16位保存在ax中的数转换为ascii码并顺序
;存储在屏幕显示区域的内存中，数位不够7位时
;补空格

;***bug的出现:在调用内部的时候si的值变为0000
      mov cx,10
	  mov di,0
	  
      ;将余数压栈
	  ;if(ax == 0 && dx == 0)
	  ;退循环
	  ;else
	  ;将cx改为10
	  ;继续循环
	   
	   ;si = 001a
	   ;ip = 00c7
	   
   s4:call divdw
   
      ;ip = 00B1
   
      inc di;di记录循环次数
	  
	  ;ip = 00b4
	  
	  push cx
	  push dx
	  push ax
	  mov cx,ax;
	  jcxz ok1;判断ax是否为0
	  ;将余数弹入栈中，方便逆序取出
	  
	  pop ax;
	  pop dx;
	  mov cx,10
	  jmp s4;不为零时恢复数据继续循环
	  
  ok1:mov cx,dx
      jcxz ok2;判断dx是否为0
  
  ok2:pop ax
      pop dx
	  
	  mov cx,di;cx存储弹栈的次数
	  mov ax,di;
	  mov dx,7
	  sub dx,ax;dx = 7-ax保存空格
	  ;的循环次数
	  
   s6:pop ax
      add al,30h
	  mov es:[si],al
	  inc si
	  mov al,02h
	  mov es:[si],al
	  inc si
	  loop s6
	  ;将对应数字转换为ascii码存入
	  ;屏幕显示区域的内存之中
   
      mov cx,dx
   s7:;mov al,32
      ;mov es:[si],al
	  inc si
	  ;mov al,02h
	  ;mov es:[si],al
	  inc si;补上后面的空格
	  loop s7
      
      ret

divdw:push si

	  ;***之前这里存在bug，mov si,dx改变了
	  ;si的值

	  mov si,dx;si存储高16位
	  ;si = 000fh
	  mov bp,ax;bp存储低16位
	  ;bp = 4240h
	  mov dx,0000h
	  ;dx = 0000h
	  mov ax,si
	  ;ax = 000fh
	  div cx
	  ;这里计算H/N*65536
	  
	  push ax;商压入栈，高八位的dx肯定
	  ;dx = 0005h压入栈中
	  
	  ;之前这里写错了ax为商，dx为余数
	  ;dx直接就在高位了，不需要任何的操作
	  ;mov dx,cx;将余数挂到高位
	  ;dx = 0005h
	  
	  mov ax,bp;将低16位挂到ax
	  ;ax = 4240h，高位为余数本身就存储在dx中
	  div cx;这里计算H%N*65536+L
	  
	  mov cx,dx;cx保存余数
	  ;mov ax,dx;ax保存低16位
	  pop dx;dx保存高16位
	  ;低八位的ax即为商，无需操作
	  pop si
	  ret

code ends
end start