.model small
.stack 100h
.data

.code
main proc
    mov ah,01h
    mov cx,20
looping:
    int 21h
    cmp al,13
    loopnz looping
main endp
end main