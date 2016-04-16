.model small
.stack 100h
.data

.code
main proc
    mov ah,01h     ; input symbol
    mov cx,20      ; number repeat
dockytu:            
    int 21h        ; receive a symbol
    cmp al,'0'     ; compare outpput with '0'
    loope dockytu  ; repeat
main endp
end main