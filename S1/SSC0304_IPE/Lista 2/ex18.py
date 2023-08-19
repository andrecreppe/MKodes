soma = 0

for i in range(0, 4):
    val = int(input())
    if(val % 2):
        continue
    soma += val

print("A soma dos numeros pares =", soma)