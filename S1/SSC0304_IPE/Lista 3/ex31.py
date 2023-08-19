import math
import decimal

def angle(x1, x2, x3, y1, y2, y3):  
    num = ((x2-x1)*(x3-x1)) + ((y2-y1)*(y3-y1))

    den = math.sqrt((x2-x1)**2 + (y2-y1)**2) * math.sqrt((x3-x1)**2 + (y3-y1)**2)  

    return math.degrees(math.acos(num/den))
  
x = []
y = []

for i in range(3):
    data = input().split(" ")
    x.append(int(data[0]))
    y.append(int(data[1]))

decimal.getcontext().prec = 12

alpha = decimal.Decimal(angle(x[0], x[1], x[2], y[0], y[1], y[2]))
beta = decimal.Decimal(angle(x[1], x[2], x[0], y[1], y[2], y[0]))
gamma = decimal.Decimal(angle(x[2], x[1], x[0], y[2], y[1], y[0]))

if((alpha + beta + gamma) != 180):
    print("NAO")
else:
    print("SIM")

    if(alpha == 90 or beta == 90 or gamma == 90):
        print("R")
    elif(alpha > 90 or beta > 90 or gamma > 90):
        print("O")
    else:
        print("A")