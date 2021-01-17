BITS 64
;============================================================
; Info
;============================================================
;Задание - Калькулятор стоимости товара
;
;Напишите калькулятор для расчета полной стоимости товара. Она рассчитывается из стоимости самого товара плюс стоимость доставки, минус скидка.
;
;Пример вывода:
;
;Стоимость товара: 6400
;Стоимость доставки: 350
;Размер скидки: 700
;---------
;Итого: 6050
;============================================================
; Vars
;============================================================
sysExitCode equ 60
inputBuff   equ 16
;============================================================
; Data
;============================================================
section .data
    tradeOffer      db "Please enter:", 0xA, "  the value: ", 0
    tradeOfferLen   equ $ - tradeOffer
    shippingCost    db "  shipping cost: ", 0
    shippingCostLen equ $ - shippingCost
    discount        db "  discount amount: ", 0
    discountLen     equ $ - discount
    total           db "Total: ", 0
    totalLen        equ $ - total

section .bss
    valInput        resb inputBuff  ; 16 байт на ввод имени (16 ASCII символов)
    shippingInput   resb inputBuff  ; 16 байт на ввод имени (16 ASCII символов)
    discountInput   resb inputBuff  ; 16 байт на ввод имени (16 ASCII символов)
    buffer          resb 18         ; inputBuff + 2 byte
section .text
    global _start
;============================================================
; Code
;============================================================
_start:
    ;--- print tradeOffer ---
    mov rax, 1
    mov rdi, 1
    mov rsi, tradeOffer
    mov rdx, tradeOfferLen
    syscall
    ;--- get the value ---
    xor rax, rax
    xor rdi, rdi
    mov rsi, valInput
    mov rdx, 16
    syscall
    ;--- convert and save value ---
    mov rdi, valInput
    call _strLen
    dec rax                         ;удаляем последний символ (0)
    dec rax                         ;удаляем перенос строки
    mov rcx, rax                    ;передаём длину строки
    call _ASCIItoNum
    xor r8, r8
    mov r8, rax                     ;сохраняем число
    ; --- print shipping cost ---
    mov rax, 1
    mov rdi, 1
    mov rsi, shippingCost
    mov rdx, shippingCostLen
    syscall
    ;--- get shipping cost ---
    xor rax, rax
    xor rdi, rdi
    mov rsi, shippingInput
    mov rdx, 16
    syscall
    ;--- convert and save shipping cost ---
    mov rdi, shippingInput
    call _strLen
    dec rax
    dec rax
    mov rcx, rax                    ;передаём длину строки
    call _ASCIItoNum
    add r8, rax                     ;прибавляем число (доставка)
    ; --- print discount ---
    mov rax, 1
    mov rdi, 1
    mov rsi, discount
    mov rdx, discountLen
    syscall
    ;--- get discount ---
    xor rax, rax
    xor rdi, rdi
    mov rsi, discountInput
    mov rdx, 16
    syscall
    ;--- convert and save discount ---
    mov rdi, discountInput
    call _strLen
    dec rax
    dec rax
    mov rcx, rax                    ;передаём длину строки
    call _ASCIItoNum
    sub r8, rax                     ;отнимаем число (скидка)
    ; --- print Total ---
    mov rax, 1
    mov rdi, 1
    mov rsi, total
    mov rdx, totalLen
    syscall
    ;--- convert and save Total val ---
    mov rax, r8
    lea rsi, [buffer]
    call _numToASCII
    mov rdi, rax
    mov r8, rax                     ;сохраняем итоговое число (в текстовом формате)
    call _strLen
    dec rax                         ;удаляем последний символ (0)
    mov r9, rax                     ;передаём длину строки
    ; --- print Total val ---
    mov rax, 1
    mov rdi, 1
    mov rsi, r8
    mov rdx, r9
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

    add rsi,19                      ; buffer - 1
    mov byte [rsi], 0               ; конец строки
    dec rsi
    mov byte [rsi], 10              ; перенос строки (конечно в реальной функции оставлять это нельзя)

    mov rbx,10
  .next_digit:
    xor rdx,rdx
    div rbx
    add dl,'0'                      ; конвертация
    dec rsi                         ; уменьшаем адрес бууфера
    mov [rsi],dl
    test rax,rax                    ; если eax == 0
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
    movzx rax,byte[rsi]             ; присваивание с обнулением
    inc rsi
    sub al,'0'                      ; конвертация
    imul rbx,10
    add rbx,rax                     ; rbx = rbx*10 + rax
  loop .next_digit                  ; while (--rcx)
    mov rax,rbx

    pop rbx
    ret

;|input | = rdi (1 param) rdi - указатель на строку
;|output| = rax - число (длина строки)
_strLen:
    push rbx
    push rcx

    mov   rbx, rdi
    xor   al, al
    mov   rcx, 0xffffffff

    repne scasb                     ; повтор пока не [edi] != al

    sub   rdi, rbx                  ; длина строки
    mov   rax, rdi

    pop rcx
    pop rbx
    ret
