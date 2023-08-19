def findSum(lst):
    soma = 0

    for i in range(len(lst)):
        soma += float(lst[i])

    return soma

tot = int(input())
vals = input().split(" ")

soma = 0
ok = False
vSub = []

for i in range(len(vals)):
    for j in range(i, len(vals)):
        vSub = vals[i:j+1]

        if(findSum(vSub) == tot):
            print("SIM")
            ok = True
            break
    if(ok):
        break

if(not ok):
    print("NAO")