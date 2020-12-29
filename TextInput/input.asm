;%include "io64.inc"    ; for correct debugging

;;-----------
; VARs
STDIN   equ 0
STDOUT  equ 1
NOERR   equ 0

sysRead     equ 0
sysWright   equ 1
sysExitCode equ 60

inputBuff   equ 16

;;-----------
; DATA
section .data
    questionText    db "What is your name? "
    questionLength  equ $ - questionText
    answerText      db "Hello, "
    answerLength    equ $ - answerText
section .bss
    nameFromInput   resb inputBuff ; 16 байт на ввод имени (16 ASCII символов)
section .text
    global _start

;;-----------
; START CODE
_start:
;;-----DEBUG----
;   global CMAIN        ; for correct debugging
;CMAIN:                 ; for correct debugging
;    mov rbp, rsp       ; for correct debugging
;;-----------

    call _printQuestionText
    call _getNameFromInput
    call _printAnswerText
    call _printNameFromInput

;;-----------
; EXIT
    mov rax, sysExitCode
    mov rdi, NOERR
    syscall

;;-----------
; PROCs
_printQuestionText:
    mov rax, sysWright
    mov rdi, STDOUT
    mov rsi, questionText
    mov rdx, questionLength
    syscall
    ret

_printAnswerText:
    mov rax, sysWright
    mov rdi, STDOUT
    mov rsi, answerText
    mov rdx, answerLength
    syscall
    ret

_getNameFromInput:
    mov rax, sysRead
    mov rdi, STDIN
    mov rsi, nameFromInput
    mov rdx, 16
    syscall
    ret

_printNameFromInput:
    mov rax, sysWright
    mov rdi, STDOUT
    mov rsi, nameFromInput
    mov rdx, 16
    syscall
    ret
