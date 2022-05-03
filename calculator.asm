
org 100h

mov di,0      
call mispar      
mov op,al
cmp si,1
jne zz
    cmp op,'/'
    jne zz1
    inc chelkem
    jmp zz
   zz1:neg num1
zz:mov dx,num1
mov num2,dx
mov num1,0
mov s,0
mov di,1
call mispar
cmp si,1
jne rr
    cmp op,'/'
    jne rr1
    inc chelkem
    jmp rr
   rr1:neg num1
rr:call peula
cmp op,'*' 
je ww 
cwd
cmp op,'/'
je ee
ww:call printf
ee:hlt




tav:mov cc,0
    mov ah,7
    int 21h
    ret
    
ptav:mov dl,al
    mov ah,2
    int 21h
    ret 
    
minus:cmp al,'-'
    jne mb
    inc si
    call ptav
 ma:call tav
 mb:call checkm 
    cmp cc,1
    jne ma
    call ptav
    mov ah,0
    sub ax,30h
    mov num1,ax
    ret
    
checkm:cmp al,30h
    jge cm
    ret
 cm:cmp al,39h
     jg csof
    mov cc,1
 csof:ret
 
 
checkop:cmp al,45
    jne ca
    jmp ce
 ca:cmp al,'/'
    jne cb
    jmp ce
 cb:cmp al,'*'
    jne cd
    jmp ce
 cd:cmp al,43
    jne yy
    jmp ce 
 yy:ret
 ce:mov s,1
    ret
    
checks:cmp al,61
    jne tt
    mov s,1
 tt:ret    

check2:cmp di,0
    jne sh
    call checkop
    jmp tf
 sh:call checks
 tf:cmp s,1
    jne ty
    call ptav
 ty:ret     

check:call checkm
    call check0
    call check2
    ret
    
check0:
    cmp num1,0
    jne nullend
    cmp al,30h
    je nullend2 
    
    
    
    nullend:ret
    nullend2:mov cc,0
    ret  
    
sum:sub al,30h
    mov bl,al
    mov ax,10
    mul num1
    mov num1,ax 
    add num1,bx
    ret
    
mispar: mov si,0
    mov cx,3
    call tav 
    call minus

    xx: call tav
        call check
        cmp s,1
        je end
        cmp cc,1
        jne xx 
        call ptav
        call sum
        loop xx
    end:cmp s,1
        je bb
     ea:call tav
        call check2
        cmp s,1
        jne ea
     bb:ret   

peula:mov dx,0
    cmp op,'*'
    jne a
    call kefel
    ret
  a:cmp op,'+'
    jne b
    call plus
    ret
  b:cmp op,'-'
    jne c
    call pachot
    ret
  c:call chiluk
  ret
  
kefel:
mov ax,num1
imul num2   
ret      

plus:
mov ax,num1
add ax,num2
ret

pachot:
mov ax,num2
sub ax,num1
ret

chiluk:

mov ax,num2
mov cx,num1
cmp num1,0
je err2
div cx
mov scher,dx 
push ax
cmp chelkem,1
jne wv
cmp num2,0
je wv
mov al,'-'
call ptav
wv:pop ax 
mov dx,0
call printf
mov cx,5
cmp scher,0
je cend
mov al,'.'
call ptav
mov dx,scher
 yx:mov ax,10
    imul dx
    mov bx,num1
    div bx
    mov scher,dx
    add al,30h 
    call ptav
    mov dx,scher
    cmp dx,0
    je cend
loop yx
cend:ret 
err2:call error
ret


printf:
    mov si,0
    mov cx,10
    mov di,0
    add dx,0
    jns hh
    call negativ
 hh:sub ax,y[si]
    sbb dx,y[si+2]
    jc tikoon
    inc res[di]
    jmp hh
 tikoon:add ax,y[si]
    adc dx,y[si+2]
    add si,4
    inc di
    loop hh
    mov si,0 
    mov cx,9
   g1: cmp res[si],30h
    jne gg
    inc si
   loop g1
 gg:lea dx,res
    add dx,si
    mov ah,9
    int 21h
 pg:ret
    
negativ:
    not ax
    not dx
    add ax,1
    adc dx,0
    push ax
    push dx
    mov dl,'-'
    mov ah,2
    int 21h
    pop dx
    pop ax
    ret  

error:lea dx,err
    mov ah,9
    int 21h
    ret


ret    
x db '*','+','/','-'
s db 0
num1 dw 0
num2 dw 0
op db 0 
y dd 1000000000,100000000,10000000,1000000,100000,10000,1000,100,10,1
res db 10 dup (30h)
z db '$' 
scher dw 0 
cc dw 0
chelkem dw 0
err dw 69,114,114,111,114,33,'$'

ret




