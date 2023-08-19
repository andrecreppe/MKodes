def bigger(arr):
    mx = int(arr[0])

    for i in range(len(arr)):
        valArr = int(arr[i])
        if valArr > mx:
            mx = valArr

    return mx

def average(arr):
    avg = 0

    for i in range(len(arr)):
        avg += int(arr[i])

    avg /= len(arr)

    return avg

def variance(arr):
    soma = 0
    med = average(arr)

    for i in range(len(arr)):
        valArr = int(arr[i])
        soma += (med-valArr)*(med-valArr)
    
    return soma/len(arr)


n = int(input())
vals = input().split(" ")

print("Maior: %.2f" % bigger(vals))
print("Media: %.2f" % average(vals))
print("Variancia: %.2f" % variance(vals))