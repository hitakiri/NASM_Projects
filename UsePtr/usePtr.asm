;============================================================
; Vars
;============================================================
sysExitCode equ 60
numOfElements equ 12
;============================================================
; Data
;============================================================
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    mov r8, numOfElements
    mov rbp, rsp
    _loop:
        cmp r8, 0
        je _exit
        push sysExitCode
        push numOfElements
        call _subFromStack
        dec r8
    jmp _loop

    ;============================================================
    ; Exit
    ;============================================================
    _exit:
    mov rax, sysExitCode
    xor rdi, rdi
    syscall

;|input | = [rsp+16],[rsp+24] (2 params)
;param1 + param2
;|output| = rax
_subFromStack:
    push rbp
    mov rbp, rsp
    push rdx
    push rbx

    mov rdx, [rbp+16]
    mov rbx, [rbp+24]
    add  rdx, rbx
    xchg rax, rdx

    pop rbx
    pop rdx
    mov rsp, rbp
    pop rbp
    ret 16 ;каждый переданный параметр +8
