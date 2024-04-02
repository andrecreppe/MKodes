     ORG 0000h         ; Origem
     JMP main          ; Salta para "main" (2 µs)

     ORG 33h           ; Origem em 33h
main:
     CLR A             ; Limpa o ACC (1 µs)
     mov R0, #03h      ; Move o valor 4Fh para R0 (1 µs)

block01:
     JZ block02        ; Salto condicional para "block02" (2 µs)
                       ; SE (A = 0)
     JNZ block03       ; Salto condicional para "block03" (2 µs)
                       ; SE (A != 0)
     NOP               ; Espera de 1 µs (1 µs)

block02:
     MOV A, R0         ; Move o valor de R0 para ACC (1 µs)
     SJMP block01      ; Salto incondicional para "block01" (2 µs)

block03:
     DJNZ R0, block03  ; Decrementa condicionalmente R0 (2 µs)
                       ; e salta para "block03"
                       ; SE (R0 != 0 )
     SJMP main         ; Salta incondicionalmente para "main" (2 µs)
end
