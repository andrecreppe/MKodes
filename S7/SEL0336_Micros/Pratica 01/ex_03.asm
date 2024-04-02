     ORG 0000h         ; Origem
main:
     MOV A, #01010101b ; Move o valor binario para ACC (1 µs)
     MOV B, #11001110b ; Move o valor binario para ACC (2 µs)
     ANL A, B          ; AND LOGICO entre A e B (1 µs)
     RR A              ; Rotaciona A em 1 bit para direita (1 µs)
     RR A              ; Rotaciona A em 1 bit para direita (1 µs)
     CPL A             ; Realiza o complemento de A (1 µs)
     RL A              ; Rotaciona A em 1 bit para esquerda (1 µs)
     RL A              ; Rotaciona A em 1 bit para esquerda (1 µs)
     ORL A, B          ; OR LOGICO entre A e B (1 µs)
     XRL A, B          ; XOR LOGICO entre A e B (1 µs)
     SWAP A            ; Realiza o swap de A (1 µs)
     JMP main          ; Salta para "main" (2 µs)
end
