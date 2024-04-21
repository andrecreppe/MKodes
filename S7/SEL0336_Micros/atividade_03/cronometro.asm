; PROJETO CRONÔMETRO
; - ANDRÉ ZANARDI CREPPE - 11802972
; - LUCAS GAMBIER COSTA MENDES - 11802777
; - VICTOR HENRIQUE D'AVILA - 11821521

  ORG 00h                 ; [ORIGEM]
  JMP main              ; Pula para main (programa principal)


  ORG 03h                 ; [INTERRUPÇÃO EXTERNA 0]
  JB P3.2, int01        ; Se (P3.2 == 1), cronômetro 1 acionado >> pula para "int01"
                        ; Se não, segue adiante
  JMP timer1            ; Pula para "timer1"


  ORG 13h                 ; [INTERRUPÇÃO EXTERNA 1]
  JB P3.3, int01        ; Se (P3.3 == 1), cronômetro 2 acionado >> pula para "int01"
                        ; Se não, segue adiante
  JMP timer2            ; Pula para "timer2"


  ORG 33h                 ; [PROGRAMA PRINCIPAL]
main:                   ; [Main]
  MOV IE, #11111111b    ; Habilita interrupções
  JMP $                 ; Consome tempo enquanto aguarda interrupções (permanece na linha)

int01:                    ; [Finalização da Interrupção Externa]
  JNB P3.3, loop2       ; Se (P3.3 == 0), ou seja cronômetro 2 acionado >> pula para "loop2"
                        ; Se não, prossegue
  MOV P1, #11111111b    ; Desliga o display de 7 segmentos
  MOV TCON, #00000000b  ; Desliga o temporizador
  RETI                  ; Termina a Interrupção


  ORG 60h                 ; [CRONÔMETROS - PT1]
timer1:                   ; [Início do Timer 1]
  MOV R3, #00h          ; Coloca o valor 00h em R3 (é o valor a ser mostrado no display)
  MOV R4, #0Ah          ; Coloca o valor 0Ah em R4 (0Ah = 10d)
  MOV DPTR, #display    ; Coloca o endereço da legenda "display" em DPTR
  MOV TCON, #00010000b  ; Liga temporizador
  MOV TMOD, #00000001b  ; Coloca temporizador em modo 1
  MOV TH0, #0D8h        ; Coloca o valor 0D8h em TH0
  MOV TL0, #0EFh        ; Coloca o valor 0EFh em TL0
loop1:                    ; [Loop do Cronômetro 1]
  JB P3.2, int01        ; Verifica se o cronômetro 1 (Interrupção) foi desacionado. Se foi >> pula para "int01"
                        ; Se não, prossegue
  JNB TF0, loop1        ; Verifica se temporizador atingiu overflow. Se sim >> prossegue
                        ; Se não, volta para "loop1"
  MOV A, R3             ; Coloca o valor de R3 em A
  MOVC A, @A+DPTR       ; Move o valor contido em um endereço de memória relativo (DPTR + A) para A
  MOV P1, A             ; Coloca o valor do acumulador em P1
  INC R3                ; Incrementa em 1 o valor de R3
  CLR TF0               ; Quando TF0 =1, limpa o timer para reiniciar a contagem
  MOV TH0, #0D8h        ; Recarrega o temporizador
  MOV TL0, #0EFh        ; Recarrega o temporizador
  DJNZ R4, loop1        ; Decrementa o valor de R4 e se for diferente de 0 pula para o loop1
  JMP timer1            ; Pula para timer1, recome�ando o processo com R3 incrementado de 1 unidade


  ORG 90h                 ; [CRONÔMETROS - PT2]
timer2:                   ; [Início do Timer 2]
  MOV R3, #00h          ; Coloca o valor 00h em R3 (é o valor a ser mostrado no display)
  MOV R4, #0Ah          ; Coloca o valor 0Ah em R4 (0Ah = 10d)
  MOV DPTR, #display    ; Coloca o endereço da legenda "display" em DPTR
  MOV TCON, #00010000b  ; Liga temporizador
  MOV TMOD, #00000001b  ; Coloca temporizador em modo 1
  MOV TH0, #08Ah        ; Coloca o valor 08Ah em TH0
  MOV TL0, #0CBh        ; Coloca o valor 0CBh em 0CBh
loop2:                    ; [Loop do Cronômetro 2]
  JNB P3.2, loop1       ; Verifica se temporizador atingiu overflow. Se sim >> prossegue
                        ; Se não >> volta para "loop1"
  JB P3.3, int02        ; Verifica se o cronômetro 2 (Interrupção) foi desacionado. Se foi >> pula para "int02"
                        ; Se não, prossegue
  JNB TF0, loop2        ; Verifica se temporizador atingiu overflow. Se sim >> prossegue
                        ; Se não, volta para "loop2"
  MOV A, R3             ; Coloca o valor de R3 no acumulador
  MOVC A, @A+DPTR       ; Move o valor contido em um endereço de memória relativo (DPTR + A) para o registrador A
  MOV P1, A             ; Coloca o valor do acumulador no P1
  INC R3                ; Incrementa em 1 o valor de R3
  CLR TF0               ; Quando (TF0 == 1), limpa o timer para reiniciar a contagem
  MOV TH0, #08Ah        ; Recarrega o temporizador
  MOV TL0, #0CBh        ; Recarrega o temporizador
  DJNZ R4, loop2        ; Decrementa o valor de R4. Se (R4 != 0) >> pula para o "loop2"
  JMP timer2            ; Pula para timer2, recomeçando o processo com R3 incrementado de 1 unidade

int02:                    ; [Finalização da Interrupção Externa]
  MOV P1, #11111111b    ; Desliga o display de 7 segmentos
  MOV TCON, #00000000b  ; Desliga o temporizador
  RETI                  ; Termina a Interrupção

display:                  ; [Valores do Display]
  DB 0C0h               ; Valor de P1 para acender 0 no display
  DB 0F9h               ; Valor de P1 para acender 1 no display
  DB 0A4h               ; Valor de P1 para acender 2 no display
  DB 0B0h               ; Valor de P1 para acender 3 no display
  DB 99h                ; Valor de P1 para acender 4 no display
  DB 92h                ; Valor de P1 para acender 5 no display
  DB 82h                ; Valor de P1 para acender 6 no display
  DB 0F8h               ; Valor de P1 para acender 7 no display
  DB 80h                ; Valor de P1 para acender 8 no display
  DB 90h                ; Valor de P1 para acender 9 no display

end
