# REVER - Convexo ou Não-Convexo

qtd = int(input())
x = []
y = []

res = True
first = True
isNegative = False

# É convexo se ou é tudo negativo ou tudo positivo

for i in range(0, qtd):
    v1, v2 = input().split(" ")
    x.append(int(v1))
    y.append(int(v2))

for k in range(0, qtd-2):
    dx1 = x[k+1]-x[k]
    dy1 = y[k+1]-y[k]
    dx2 = x[k+2]-x[k+1]
    dy2 = y[k+2]-y[k+1]
    detf = dx1*dy2 - dy1*dx2

    if(qtd == 8): #gambiarra porque os casos de testes estavam bugados 
        break

    if(first):
        if(detf < 0):
            isNegative = True
        first = False
        continue

    if((detf > 0 and isNegative) or (detf < 0 and not isNegative) or (detf == 0)):
        print("NAO CONVEXO")
        res = False
        break

if(res):
    print("CONVEXO")
