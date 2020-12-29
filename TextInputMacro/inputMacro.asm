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
; MACROs
    ;;printStr(str, str_length)
    %macro printStr 2
        mov rax, sysWright
        mov rdi, STDOUT
        mov rsi, %1
        mov rdx, %2
        syscall
    %endmacro

_start:
;;-----DEBUG----
;   global CMAIN        ; for correct debugging
;CMAIN:                 ; for correct debugging
;    mov rbp, rsp       ; for correct debugging
;;-----------

    printStr questionText, questionLength
    mov rax, sysRead
    mov rdi, STDIN
    mov rsi, nameFromInput
    mov rdx, 16
    syscall
    printStr answerText, answerLength
    printStr nameFromInput, inputBuff

;;-----------
; EXIT
    mov rax, sysExitCode
    mov rdi, NOERR
    syscall
