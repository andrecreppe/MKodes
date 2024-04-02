     ORG 0000h      ; Origem
main:
     MOV A, #02     ; Move o valor 02d para ACC (1 µs)
     MOV B, #03     ; Move o valor 03d para B (2 µs)
     MOV 47h, #07   ; Move o valor 07d para o end. 47h (2 µs)
     ADD A, 47h     ; Soma o conteudo de 47h com ACC (1 µs)
     DEC A          ; Decrementa 1 unidade de ACC (1 µs)
     DEC A          ; Decrementa 1 unidade de ACC (1 µs)
     DEC A          ; Decrementa 1 unidade de ACC (1 µs)
     INC B          ; Incrementa 1 unidade de B (1 µs)
     SUBB A, B      ; Subtrai A por B (1 µs)
     MUL AB         ; Multiplica A por B (4 µs)
     INC B          ; Incrementa 1 unidade de B (1 µs)
     INC B          ; Incrementa 1 unidade de B (1 µs)
     DIV AB         ; Divide A por B (4 µs)
     MOV 20h, A     ; Move o conteudo de A para o end. 20h (1 µs)
     MOV 22h, B     ; Move o conteudo de B para o end. 22h (2 µs)
     JMP main       ; Salta para "main" (2 µs)
end
