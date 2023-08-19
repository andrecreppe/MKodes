txt = input()
stxt = input()

if(txt.find(stxt) > 0):
    print("A frase contem a substring " + stxt)
else:
    print("A frase nao contem a substring " + stxt)