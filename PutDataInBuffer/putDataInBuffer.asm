;============================================================
; Vars
;============================================================
STDOUT  equ 1

sysWright   equ 1
sysExitCode equ 60

numOfElements equ 5
;============================================================
; Data
;============================================================
section .bss
    buffer          resb 20
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    mov r8, numOfElements
    mov r9, buffer
    _putInBuff_loop:
        cmp r8, 0
        je _putInStack_printFromStack
        mov r10b, r8b
        add r10b, '0'
        mov byte [r9], r10b
        inc r9
        mov byte [r9], '-'
        inc r9
        dec r8
    jmp _putInBuff_loop
    _putInStack_printFromStack:
        mov r10b, '0'
        mov byte [r9], r10b
        inc r9
        mov byte [r9], 10
        mov rax, sysWright
        mov rdi, STDOUT
        mov rsi, buffer
        mov rdx, 20
        syscall

    ;============================================================
    ; Exit
    ;============================================================
    mov rax, sysExitCode
    xor rdi, rdi
    syscall
