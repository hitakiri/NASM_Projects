;============================================================
; Info
;============================================================
; Пример вычисления длины строки
; печатаем 42 предварительно узнав длину строки '42'
;============================================================
; Vars
;============================================================
sysExitCode equ 60
;============================================================
; Data
;============================================================
section .data
    text      db "42", 10, 0
;section .bss
;    buffer          resb 20
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    mov rdi, text
    call _strLen
    mov r8, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, text
    mov rdx, r8
    syscall

    ;============================================================
    ; Exit
    ;============================================================
    mov rax, sysExitCode
    xor rdi, rdi
    syscall

;|input | = rdi (1 param) rdi - указатель на строку
;|output| = rax - число (длина строки)
_strLen:
  push rcx
  push rbx

  mov   rbx, rdi
  xor   al, al
  mov   rcx, 0xffffffff

  repne scasb               ; повтор пока не [edi] != al

  sub   rdi, rbx            ; длина строки
  mov   rax, rdi

  pop rbx
  pop rcx
  ret