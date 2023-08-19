vals = input().split(" ")

soma = 0

for i in range(0, 10):
    soma += float(vals[i])

print(format(soma/10, '.2f'))