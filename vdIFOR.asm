.model small
.stack 100h
.data
.code
main proc
    mov ah,01h
    int 21h
    cmp al,'y'
    jz hienthi
    cmp al,'Y'
    jz hienthi
    jmp thoat
hienthi:
    mov ah,02h
    mov dl,al
    int 21h  
    jmp tieptuc
thoat: 
    mov ah, 4ch
    int 21h        
tieptuc:
main endp
end main