.model small
.stack 100h
.data
.code
main proc
    mov cx,80
    mov ah,02h
    mov dl,'*'
inra:
    int 21h
    LOOP inra
main endp
end main