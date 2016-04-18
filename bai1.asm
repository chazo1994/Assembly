.model small
.stack 100h
.data 
    tb DB "nhap do dai xau X lon hon xau Y! $"
    tb1 DB "nhap xau ky tu X: $"
    tb2 DB "nhap xau ky tu Y: $"  
    
    kq1 db "xau Y la con cua X! $"
    kq2 db "xau Y khong phai la con cua X! $"
    
    vitri db "vi tri xau Y: $"
    soluong db " xau X chua : $"
    
    strX    db 200,?,200 dup (' ')  ;200 is max number of characters allowed(199) , ? is number of characters user entered   
    
    strY    db 200,?,200 dup (' ') 
    lengthX dw ?
    lengthY dw ?  
    
    isChildren db 0
    count dw 0 
    local dw 10 dub(0)
.code
main proc
    mov ax,@data   
    mov ds,ax
    mov es,ax
    ;thong bao
    lea dx,tb
    mov ah,09h
    int 21h
    mov ah,02h
    mov dl,10
    int 21h   ; xuong dong
    mov dl,13
    int 21h   ; ve dau dong
    
    mov ah,09h
    lea dx,tb1
    int 21h
    
    ;nhap chuoi X
    mov ah, 0Ah                         ; ham nhan chuoi nhap vao tu keyboard   
    mov dx, offset strX                 ; input: dx chua dia chi de luu chuoi
    int 21h
    ; do dai cua chuoi X se duoc luu o "db ?" duoi dang 1byte
    ; lay do dai chuoi X luu vao CX, do la 1byte nen luu vao cl, va de ch =0     
    mov si, offset strX + 1             ; tro den offset cua o nho luu do dai
    mov cl,[si]                         ; luu do dai tro boi ds:si vao cl
    mov ch,0                            ; clear ch to use cx
   ; lea dx,lengthX                           
    mov lengthX,cx                        ; luu do dai strX vao lengthX   
    inc cx                              ; cx = length + 1 day la vi tri can phai chua '$' de hien xau
    add si,cx                           ; luc nay si tro den vi tri length + 1
    mov al,'$'
    mov [si],al                         ; luc nay length + 1 chua '$'
    ; now cx store length of strX
     
    
    ; nhap chuoi Y
    ;thong bao 2
    mov ah,02h
    mov dl,10
    int 21h                             ; xuong dong
    mov dl,13
    int 21h                             ; ve dau dong  
    
    
    mov ah,09h
    mov dx,offset tb2
    int 21h
      
    ; nhap Y
    mov ah,0Ah
    mov dx, offset strY
    int 21h
    
    mov si, offset strY + 1            
    mov cl,[si]                      
    mov ch,0   
    mov lengthY,cx                           
    inc cx                              
    add si,cx                           
    mov al,'$'
    mov [si],al
    
    
    mov ah,02h
    mov dl,10
    int 21h                             ; xuong dong
    mov dl,13
    int 21h                             ; ve dau dong  
    
    call  cmpCharacter
    
    cmp count,0
    jz noChildren 
    mov ah,09h
    lea dx,kq1
    int 21h
    jmp printf
    
noChildren:
    mov ah,09h 
    lea dx,kq2
    int 21h 
    jmp exit
    
printf:       
    ; in vi tri xau con
    mov ah,02h
    mov dl,10
    int 21h                             ; xuong dong
    mov dl,13
    int 21h 
    mov ah,09h
    lea dx,vitri
    int 21h
    
    mov ah,02h
    mov dl,10
    int 21h                             ; xuong dong
    mov dl,13 
    int 21h 
    mov cx,count
    push si 
    mov si,offset local
Lap:
    push ax 
    mov ax,0
    mov al,[si]
    inc si
    call printNumber
    pop ax
    dec cx
    jnz Lap     
    pop si
    
              
    ; in so xau con
    mov ah,02h
    mov dl,10
    int 21h                             ; xuong dong
    mov dl,13
    int 21h    
    mov ah,09h
    lea dx,soluong
    int 21h
    
    
    mov ah,02h
    mov dl,10
    int 21h                             ; xuong dong
    mov dl,13
    int 21h
    push ax
    mov ax,0
    mov ax,count
    call printNumber  
    pop ax                  
exit:
    mov ah,4ch
    int 21h   
main endp
      
      
    ; ham so sanh theo de bai
cmpCharacter proc near 
    mov si, offset strX + 2
    mov di, offset strY + 2  
    mov cx,lengthX  
;duyet toan bo chuoi X
FORX:
    cmpsb        ; so sanh va tang si va di mot don vi
    
    jnz continue
    push di
    call checkSubString 
    pop di
continue:
    dec di ; dua di tro ve gia tri truoc khi tang boi cmpsb   
    loop FORX
    
    ret     
cmpCharacter endp
       
       
    ; ham kiem tra chuoi con
checkSubString proc near 
    dec si ; vi sau khi cmps phia tren si da tang len mot don vi 
    dec di; vi sau khi smpsb phia tren si da tang len mot don vi
    mov bx,si 
    ;dec si ; vi sau lenh cmpsb truoc do si da tang 1 don vi
    add bx,lengthY
    ;dec bx ;bx=bx-1     bx tro den diem cuoi cua chuoi strY
    push dx
    mov dx,0
    mov dx,lengthX
    sub dx,cx   ; lay vi tri bang nhau dau tien cua y va x  s    
FORY: 
    cmpsb          ; so sanh va si=si+1 ; di = di +1
    jnz continue1 
    cmp si,bx    ;khi duyet den cuoi xau y
    jz isChildrenX 
    cmp cx,0    ; khi ma duyet het chuoi X
    jz continue1
    loop FORY ; luc nay CX van giam  
                             
isChildrenX:
   
    push si 
    mov si,offset local   ; dung si de duyet mang
    add si,count         ; do dia mang bang so lan chua y
    mov [si],dx 
    pop si
    
    add count,1 ; khi duyet het xau Y thi Y la con cua X
    cmp count,1
    ;jnz continue1 ; neu Y duoc tim thay lan thu 2 hoac lon hon thi jump 
    
continue1:
    pop dx 
    
    ret
checkSubString endp         

;ham in so thap phan

printNumber proc near
     push cx
     push bx
     push dx
     mov cx,0
     mov bx,10  
     mov dx,0
repeat:
    IDIV bx
    push dx  
    mov dx,0
    inc cx
    cmp ax,0  
    jnz repeat
for:    
    pop dx 
    add dl,30h
    mov ah,02h
    int 21h
    loop for
    
    pop dx
    pop bx
    pop cx 
    
    mov ah,02h
    mov dl,' '
    int 21h
    
    ret
printNumber endp
end main
    