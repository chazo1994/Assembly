.model small
.stack 100h
.data
.code
main proc
    mov ah,01h ;nhap mot ky tu
    int 21h ; dua ky tu vao al
    cmp al,'A' ;so sanh voi A
    jb tieptuc ; neu <a thi thoat
    cmp al,'Z' ; so sanh voi z
    ja tieptuc ; neu nho >z thi thoat
    mov ah,02h  ; in mot ky tu
    mov dl,al   ; dau vao la ky tu hoa vua nhap
    int 21h
tieptuc:
main endp
end main
    
    