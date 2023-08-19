def circle(x1, y1, x2, y2, x3, y3):
    det = y1 * (x2-x3) + y2 * (x3-x1) + y3 * (x1-x2)
    return abs(det) / 2

n, r = map(int, input().split(" "))

pontosX = []
pontosY = []

for i in range(n):
    x, y = map(int, input().split(" "))
    pontosX.append(x)
    pontosY.append(y)

resultado = False

for i in range(n-2):
    for j in range(i+1, n-1):
        for k in range(j+1, n):
            x1 = pontosX[i]
            y1 = pontosY[i]
            x2 = pontosX[j]
            y2 = pontosY[j]
            x3 = pontosX[k]
            y3 = pontosY[k]

            if(circle(x1, y1, x2, y2, x3, y3) > 0):
                xc = ((y1-y3) * ((x1 ** 2) + (y1 ** 2) - (x2 ** 2) - (y2 ** 2)) + (y2 - y1) * ((x1 ** 2) + (y1 ** 2) - (x3 ** 2) - (y3 ** 2))) / (2 * (y1 - y3) * (x1 - x2) + 2 * (y2 - y1) * (x1 - x3))

                yc = 0.0

                if y1 != y2:
                    yc = (x1 ** 2 - x2 ** 2 - 2 * xc * (x1 - x2) + y1 ** 2 - y2 ** 2) / (2 * (y1 - y2))
                else:
                    yc = (x1 ** 2 - x3 ** 2 - 2 * xc * (x1 - x3) + y1 ** 2 - y3 ** 2) / (2 * (y1 - y3))

                raio = (x1-xc)**2 + (y1-yc)**2
                
                if raio == r**2:
                    resultado = True
                    break;break;break

if(resultado):
    print("S")
else:
    print("N")