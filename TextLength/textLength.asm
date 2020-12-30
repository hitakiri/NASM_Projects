;%include "io64.inc"    ; for correct debugging

;============================================================
; Vars
;============================================================
STDIN   equ 0
STDOUT  equ 1
NOERR   equ 0

sysRead     equ 0
sysWright   equ 1
sysExitCode equ 60

inputBuff   equ 16

;============================================================
; Data
;============================================================
section .data
    questionText    db "What is your name? ", 0
    answerText      db "Hello, ", 0
    answerLength    equ $ - answerText
section .bss
    nameFromInput   resb inputBuff ; 16 байт на ввод имени (16 ASCII символов)
section .text
    global _start
;============================================================
; Macros
;============================================================
    ;printStr(str, str_length)
    %macro printStr 2
        mov rax, sysWright
        mov rdi, STDOUT
        mov rsi, %1
        mov rdx, %2
        syscall
    %endmacro

_start:
;============================================================
; Debug
;======
;   global CMAIN        ; for correct debugging
;CMAIN:                 ; for correct debugging
;    mov rbp, rsp       ; for correct debugging
;============================================================

    mov rdi, questionText
    call _strlen
    printStr questionText, rdx ; в принципе возвращаем rdx в rdx (можно упростить)
    mov rax, sysRead
    mov rdi, STDIN
    mov rsi, nameFromInput
    mov rdx, inputBuff
    syscall
    printStr answerText, answerLength
    printStr nameFromInput, inputBuff

;============================================================
; Exit
;============================================================
    mov rax, sysExitCode
    mov rdi, NOERR
    syscall

; | input | rdi = string
; | output | rdx = string length
;============================================================
_strlen:

  push  rcx                 ; сохраняем счётчик

  xor   rcx, rcx            ; обнуляем счётчик
    _strlen_next_char:
        cmp   [rdi], byte 0         ; проверяем на нулевой байт
        jz    _strlen_exit          ; выход
        inc   rcx                   ; если символ != 0, инкрементим счетчик
        inc   rdi                   ; переходим на следующий счётчик
        jmp   _strlen_next_char     ; цыкл
    _strlen_exit:
        mov   rdx, rcx

        pop   rcx           ; восстанавливаем счётчик
        ret
