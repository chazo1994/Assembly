.model small
.stack 100h
.data 
     thongbao1 db 'nhap mot chu cai thuong: $'  
     thongbao2 db 'chu cai hoa tuong ung la: $'
.code
main proc 
     mov ax,@data
     mov ds,ax
notify:     
     mov ah,9
     lea dx,thongbao1
     int 21h              ; hien ra thong bao 1
input:
     mov ah,1         ; nhap mot ky tu
     int 21h           
     mov bl,al
format:  
     mov ah,2
     mov dl,' '
     int 21h          ; dat dau cach de ket thuc viec nhap va chuyen sang viec ngat
     mov dl,10        ;xuong dong 
     int 21h
     mov dl,13        ; ve dau rong
     int 21h
show:
     mov ah,9
     lea dx,thongbao2      ; hien ra thong bao 2
     int 21h     
convert:
     sub bl,20h        ;al=al-20
     mov dl,bl
showcharactrer:           ; hien ra ky tu hoa
     mov ah,2
     int 21h

finish:
     mov ah,1
     int 21h
     mov ah,4ch
     int 21h
main endp 
end main