assume  cs:code

code    segment                     ;   al      CF      OF      SF      ZF      PF
        start:  sub al,al           ;   0       0       0       0       1       1
                mov al,10h          ;  10H      0       0       0       1       1 
                add al,90h          ;  A0H      0       0       1       0       1
                mov al,80h          ;  80H      0       0       1       0       1
                add al,80h          ;  00H      1       1       0       1       1
                mov al,0FCH         ; 0FCH      1       1       0       1       1
                add al,05H          ; 01H       1       0       0       0       0
                mov al,7DH          ; 7DH       1       1       1       0       0    
                add al,0BH          ; 88H       0       1       1       0       1

                mov ax,4c00h
                int 21h
code    ends
end start