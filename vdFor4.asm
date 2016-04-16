.model small
.stack 100h
.data
.code
main proc
    mov bx,0h
    mov ah,01h
lap:   
    int 21h
    cmp al,13
    jz tieptuc
    inc bx
    jmp lap  
tieptuc:
main endp
end main