;============================================================
; Info
;============================================================
; Простое логическое ветвление if-elseif-else
; Беззнаковое сравнение RCX и RAX
; Упрощённый пример (плюс попробовал некоторые оптимизации)
; RCX == RAX => RBX == 1
; RCX < RAX  => RBX == 2
; RCX > RAX  => RBX == 3
; Пример взят из книги "Ассемблер на примерах" 2006г.
;============================================================
; Vars
;============================================================
sysExitCode equ 60
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
    xor rbx, rbx

    inc rbx         ;mov rbx, 1 (изначально знаем что rbx == 0)
    cmp rax, rcx
    je short end_if ;если равно, то в конец проверки
    inc rbx         ;mov rbx, 2 (знаем что rbx в начале процедуры стал равен 1)
    ja short end_if ;если rax > rcx , то в конец проверки
    inc rbx         ;иначе mov rbx, 3

    end_if:
    ;============================================================
    ; Exit
    ;============================================================
    mov rax, sysExitCode
    xor rdi, rdi
    syscall