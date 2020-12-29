;%include "io64.inc"    ; for correct debugging

section .data
    text db "Hello World", 10
section .text
    global _start
;    global CMAIN       ; for correct debugging

;CMAIN:                 ; for correct debugging
_start:
;    mov rbp, rsp       ; for correct debugging
    mov rax, 1
    mov rdi, 1
    mov rsi, text
    mov rdx, 13
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
