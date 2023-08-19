a1 = float(input())
a2 = float(input())
a3 = float(input())

if(a1+a2+a3 == 180):
    if(a1 > 90 or a2 > 90 or a3 > 90):
        print("Triangulo obtuso")
    elif(a1 == 90 or a2 == 90 or a3 == 90):
        print("Triangulo retangulo")
    else:
        print("Triangulo agudo")
else:
    print ("Valores nao formam um triangulo")