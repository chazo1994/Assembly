.model small
.stack 100h
.data 
     thongbao db 'nhap mot chu cai thuong$'
.code
main proc 
     mov ax,@data
     mov ds,ax
notify:     
     mov ah,9
     lea dl,thongbao
     int 21h
input:
     mov dl,10         ; new line
     int 21h
     mov ah,1
     int 21h
format:
     mov dl,10
     int 21h
     mov dl,13
     int 21h
show:
     
     
main endp 
end main