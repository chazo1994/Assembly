.model small
.stack 100h
.data
.code
main proc
    mov bl,5
hienthi:
    mov ah,02h
    mov dl,'*'
    mov cx,50
indong:
    int 21h
    loop indong
    mov ah,02h
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    DEC bl
    jnz hienthi
main endp
end main
    