;============================================================
; Info
;============================================================
; Пример перевода числа в ASCII
; печатаем число 38
;============================================================
; Vars
;============================================================
sysExitCode equ 60
;============================================================
; Data
;============================================================
section .data
    numVar      db 38
section .bss
    buffer          resb 20
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    mov rax, [numVar]
    lea rsi,[buffer]

    call _numToASCII

    mov r8, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, r8
    mov rdx, 4
    syscall

    ;============================================================
    ; Exit
    ;============================================================
    mov rax, sysExitCode
    xor rdi, rdi
    syscall

;|input | = rax, rsi (2 params) rsi - указатель на буфер
;|output| = rax - указатель на первый элемент буфера
_numToASCII:
    push rbx
    push rdx

    add esi,19          ; buffer - 1
    mov byte [esi], 0   ; конец строки
    dec esi
    mov byte [esi], 10  ; перенос строки

    mov rbx,10
  .next_digit:
    xor rdx,rdx
    div rbx
    add dl,'0'          ; конвертация
    dec rsi             ; уменьшаем адрес бууфера
    mov [rsi],dl
    test rax,rax        ; если eax == 0
  jnz .next_digit
    mov rax,rsi

    pop rdx
    pop rbx
    ret
