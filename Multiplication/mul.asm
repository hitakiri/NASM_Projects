;============================================================
; Vars
;============================================================
sysExitCode equ 60
var_A equ 127
;============================================================
; Data
;============================================================
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    xor rax, rax
    mov al, var_A
    push rax

    call _mulProc
    call _imul
    mov rax, 4
    call _sqrt
    mov rax, 4
    mov rbx, 3
    mov [rsp+8], rbx
    mov [rsp], rax
    call _perRectProc

    ;============================================================
    ; Exit
    ;============================================================
    _exit:
    mov rax, sysExitCode
    xor rdi, rdi
    syscall

;|input | = [rsp+16] (1 param)
;param1 * param1 * param1
;|output| = rax
_mulProc:
    push rbp
    mov rbp, rsp
    ;sub rsp, 8

    xor rax, rax
    xor rdx, rdx
    mov rax, [rbp+16]
    mul al              ; поднимаем флаг OF
    mov rbx, [rbp+16]
    mul bx              ; остаток падает в rdx

    mov [rbp-4], ax     ; записываем основную часть в стек
    mov [rbp-2], dx     ; записываем остаток в стек
    mov eax, [rbp-4]    ; записываем разультат в регистр rax

    mov rsp, rbp
    pop rbp
    ret 8     ;каждый переданный параметр +8

_imul:
    ; rax * operand
    mov rax, -5
    mov rbx, 7
    imul rbx

    ; rax = operand * num
    mov rbx, 20
    imul rbx, 7

    ; operand1 (rcx) = operand2 (rbx) * num
    xor rcx, rcx
    mov rbx, 25
    imul rcx, rbx, 5

    ; porand1 = operand1 * var
    mov rbx, 3
    imul rbx, var_A

    ret

;|input | = rax
;param1 * param1
;|output| = rax
_sqrt:
    mul rax
    ret

;|input | = rax, rbx
;per = (a + b) * 2
;|output| = rax
_perRect:
    add rax, rbx
    mov rbx, 2
    mul rbx
    ret

;|input | = rsp, rsp+8
;per = (a + b) * 2
;|output| = rax
_perRectProc:
    push rbp
    mov rbp, rsp
    push rbx

    mov rax, [rbp+16]
    add rax, [rbp+24]
    mov rbx, 2
    mul rbx

    pop rbx
    mov rsp, rbp
    pop rbp
    ret 16
