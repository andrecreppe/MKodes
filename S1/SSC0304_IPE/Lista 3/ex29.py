sz = int(input())
vet1 = input().split(" ")
vet2 = input().split(" ")

soma = 0

for i in range(0, sz):
    soma += float(vet1[i]) * float(vet2[i])

print(format(soma, '.2f'))