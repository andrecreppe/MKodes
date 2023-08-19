#Média até digitar "-1"

a = soma = 0

while True:
    txtEntrada = "Digite o valor " + str(a+1) + " = "

    val = float(input(txtEntrada))

    if(val < 0):
        break
    
    soma += val
    a += 1

media = soma / a

print("\nMedia = ", round(media, 3))