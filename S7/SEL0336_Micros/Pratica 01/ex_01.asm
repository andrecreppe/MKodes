	ORG 0000h        ; Origem
main:
	MOV A, #0A6h     ; Move o valor A6h para ACC (1 µs)
	MOV  A, #00h     ; Move o valor 00h para ACC (1 µs)
	CLR RS0          ; Torna o LSB de PSW zero (1 µs)
	CLR RS1          ; Torna o MSB de PSW zero (1 µs)
                   ; PSW = 00 -> Selecionou o Banco 0
	MOV R0, #4Fh     ; Move o valor 4Fh para R0 (1 µs)
	MOV B, #05h      ; Move o valor 05h para B (2 µs)
	MOV 027h, P1     ; Move o valor de P1 para o end. 27 (2 µs)
	SETB RS0         ; Torna o LSB de PSW um (1 µs)
                   ; PSW = 01 -> Selecionou o Banco 1
	MOV R0, 27h      ; Move o conteudo no end. 27h para R0 (2 µs)
	MOV 11h, R0      ; Move o conteudo de R0 para o end. 11h (2 µs)
	MOV R1, #11h     ; Move o valor 11h para R1 (1 µs)
	MOV A, @R1       ; Move R1 de forma indireta para ACC (1 µs)
	MOV DPTR, #9A5Bh ; Move o valor 9A5Bh para DPTR (2 µs)
	NOP              ; Espera de 1 µs (1 µs)
	JMP $            ; Segura o programa (2 µs)
end
