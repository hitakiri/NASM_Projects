;============================================================
; Info
;============================================================
; Пример перевода ASCII в число
; печатаем число 42
;============================================================
; Vars
;============================================================
sysExitCode equ 60
;============================================================
; Data
;============================================================
section .data
    textVar     db '42'
section .bss
    buffer      resb 20
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    lea rsi, [textVar]
    mov rcx, 2
    call _ASCIItoNum ;должно вернуть число

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
    mov byte [esi], 10  ; перенос строки (конечно в реальной функции оставлять это нельзя)

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

;|input | = rcx, rsi (2 params) rsi - указатель на строку, rcx - длина строки
;|output| = rax - число
_ASCIItoNum:
    push rbx

    xor rbx,rbx
  .next_digit:
    movzx rax,byte[rsi] ; присваивание с обнулением
    inc rsi
    sub al,'0'          ; конвертация
    imul rbx,10
    add rbx,rax         ; rbx = rbx*10 + rax
  loop .next_digit      ; while (--rcx)
    mov rax,rbx

    pop rbx
    ret
