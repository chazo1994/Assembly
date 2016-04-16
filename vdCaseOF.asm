.model small
.stack 100h
.data
.code
main proc 
    mov ax,100
    cmp ax,0
    jb gan1
    jz gan2
    ja gan3
gan1:
    mov bx,-1
    jmp tieptuc
gan2:
    mov bx,0
    jmp tieptuc
gan3:
    mov bx,1
    jmp tieptuc
tieptuc:
main endp
end main