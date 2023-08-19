def isTriangle(a, b, c):
    return a<(b+c) and b<(c+a) and c<(a+b)

a = int(input())
b = int(input())
c = int(input())

if(isTriangle(a, b, c)):
    if(a == b == c):
        print("Triangulo Equilatero")
    elif(a != b and a != c and b != c):
        print("Triangulo Escaleno")
    else:
        print("Triangulo Isosceles")
else:
    print("Valores nao formam um triangulo")