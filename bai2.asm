.model small
.stack 100h
.data

    m dw 100 dup(0)
    n dw 0
    
    tb1 db "nhap N: $"
    tb2 db "so lon nhat trong mang la: $"
    tb3 db "nhap mang so hexa: $"
.code    
main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
     
    ;thong bao
    mov ah,09
    lea dx,tb1
    int 21h
             
    ; nhap N nho hon 100
    
    call inputNumber
    mov n,bx  
    
    mov ah,02h   
    mov dl,10
    int 21h   ; xuong dong
    mov dl,13
    int 21h   ; ve dau dong
    mov ah,09h
    lea dx,tb3
    int 21h
    
    mov cx,n      ; so lan lap bang n
    mov di,offset m ; gan di tro den phan tu dau tien cua m
nhapmang:
    mov ah,02h 
    mov dl,10
    int 21h   ; xuong dong
    mov dl,13
    int 21h   ; ve dau dong

    call inputNumber
    mov [di],bx
    add di,2
    loop nhapmang
    
    mov di,offset m
    mov ax,[di] ; gia tri max ban dau gan cho ax  
    mov cx,n
timmax:
    cmp ax,[di]
    jge timtiep   ; nhay neu dx>= [di] so co dau
    mov ax,[di]    ; neu dx<[di] gan gia tri [di] cho dx
timtiep:           
    add di,2         ; tang di
    loop timmax
    
    ;in so max
    mov ah,02h   
    mov dl,10
    int 21h   ; xuong dong
    mov dl,13
    int 21h   ; ve dau dong
    
    mov bx,ax
    call sap 
main endp  
inputNumber proc near
    mov bx,0 ; xoa bx             
    mov ax,0 ;xoa ax  
    push cx ;
    push dx ;
    mov dx,0 ; xoa dx
    mov cl,10  
nhap:
    mov ah,01h         
    int 21h
    cmp al,'0' ; neu ky tu co ma ascii <0 dung nhap
    jb exit
    cmp al,'9' ; neu ky tu co ma ascii >9 dung nhap
    ja exit 
    cmp al,'-' ; neu no la so am
    jz soAm                              
    mov ch,al    ; chuyen ky tu nhap vao sang bh 
    sub ch,30h ; doi sang gia tri thap phan
    mov ax,bx ;chuyen gia tri bx sang cho ax
    mov bl,ch
    mov bh,0 ; xoa bh de dung bx=bl
    mov ch,0 ; xoa ch de dung cx=cl
    imul cx ;   lay cx*ax    dau ra dxax     ta chi lay ax la so 16 bit
    add ax,bx ; lay tong ax + gia tri nhap vao luu trong bx
    mov bx,ax  
    jmp nhaptiep
soAm:    
    add dx,1
nhaptiep:    
    jmp nhap  
    jmp exit
    
    cmp dx,0    ; xem co phai la so am hay khong
    jz exit     ; neu khong phai thi jump   
    not bx     ; dao bit
    add bx,1b ;         lay bu hai
    
   
exit: 
    pop dx
    pop cx   
    ret   
inputNumber endp  

sap proc near 
    push cx
    cmp bx,0 ; so sanh ax voi 0, bx la thanh ghi chua so can in
    jge continue  ; nhay neu lon hon hoac bang >=
    
    mov ah,02h
    mov dl,'-'
    int 21h
    not bx     ; dao bx
    add bx,1   ; lay bu hai cua bx
continue:
    mov cx,0  
    mov ax,bx ;chuyen gia tri tu bx sang ax
    mov bl,10; gan bl=10 la so chia
repeat:
    div bl  ; chia ax cho bl
    push ax  ; cat so du trong ah vao stack
    mov ah,0 ; xoa ah de dung ax=al  la thuong
    inc cx
    cmp al,0
    jnz repeat  
    mov ah,02h 
for:
    pop dx
    add dl,30h      
    int 21h 
    loop for   
    
    pop cx
    ret
sap endp
end main