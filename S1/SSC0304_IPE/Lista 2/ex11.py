num = int(input())

num *= num
strNum = str(num)

resp = ""

for i in range(0, len(strNum)):
    if(strNum[i] == '0'):
        resp += "Zero "
    elif(strNum[i] == '1'):
        resp += "Um "
    elif(strNum[i] == '2'):
        resp += "Dois "
    elif(strNum[i] == '3'):
        resp += "Tres "
    elif(strNum[i] == '4'):
        resp += "Quatro "
    elif(strNum[i] == '5'):
        resp += "Cinco "
    elif(strNum[i] == '6'):
        resp += "Seis "
    elif(strNum[i] == '7'):
        resp += "Sete "
    elif(strNum[i] == '8'):
        resp += "Oito "
    elif(strNum[i] == '9'):
        resp += "Nove "

print(resp)
