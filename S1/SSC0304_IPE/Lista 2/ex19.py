vals = input().split()

i = 0
soma = 0
while(True):
    val = int(vals[i])

    if(val == -1):
        break

    if(val%2):
        i += 1
        continue

    soma += val
    i += 1

print(soma)