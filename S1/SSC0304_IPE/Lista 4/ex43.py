def flip(vet, a, b):
    if (a >= b):
        return

    buff = vet[a]
    vet[a] = vet[b]
    vet[b] = buff

    flip(vet, a+1, b-1)

arr = list(map(int, input().split(" ")))

flip(arr, 0, len(arr)-1)

print(arr)