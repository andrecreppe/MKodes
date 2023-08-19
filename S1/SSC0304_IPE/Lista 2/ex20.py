import decimal

def factorial(num):
    if(num == 2):
        return decimal.Decimal(2)
    else:
        return (num * factorial(num-1))

def taylorSine(theta, iter):
    soma = theta
    mult = -1
    for i in range(3, iter, 2):
        di = decimal.Decimal(i)
        soma += ((theta**di) / factorial(di)) * mult
        mult *= -1

    return soma

decimal.getcontext().prec = 12
    
angle, times = input().split(" ")
angle, times = [decimal.Decimal(angle), int(times)]

res = taylorSine(angle, times)

print(round(res, 6))
