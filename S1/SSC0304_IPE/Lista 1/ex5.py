a, b, c = input().split(" ")

a, b, c = [float(a), float(b), float(c)]

if(a == b == c):
    print("equilatero")
elif(a == b or a == c or b == c):
    print("isosceles")
else:
    print("escaleno")