     ORG 0000h           ; Origem
     JMP main            ; Salta para "main" (2 µs)

     ORG 33h             ; Origem em 33h
main:
     MOV R0, #20h        ; Move o valor 20h para R0 (1 µs)
     MOV R1, #0          ; Move o valor 0d para R1 (1 µs)

loop:
     MOV A, @R0          ; Move o conteudo no end. apontado por R0 para ACC (1 µs)
     SUBB A, #45h        ; Subtrai 45h de ACC (1 µs)
     JNC operation       ; Salto condicional para "operation" (2 µs)
                         ; SE (PSW = 0)
     INC R1              ; Incrementa R1 (1 µs)

operation:
     INC R0              ; Incrementa R0 (1 µs)
     CJNE R0, #24h, loop ; Compara R0 com o valor 24h (2 µs)
                         ; SE IGUALDADE, salta para "loop" 
     NOP                 ; Espera de 1 µs (1 µs)
     JMP $               ; Segura o programa (2 µs)
end
