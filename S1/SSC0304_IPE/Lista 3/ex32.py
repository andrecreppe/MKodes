def factorial(n):
    if(n == 1 or n == 0):
        return 1
    else:
        return n*factorial(n-1)

def anagrams(txt):
    txt = txt.replace("\n","")
    txt = txt.replace("\r","")
    
    rep = {}

    for letra in txt:
        #se a letra já é repetida, soma 1
        if letra in rep:
            #pega o valor atual
            #total = rep.get(txt[j])
            #atualiza com +1
            rep[letra] += 1
        else:
            #se não esta, adiciona
            rep[letra] = 1
        

    #agora que sabemos o total de rep vamos aplicar a formula
    nletra = factorial(len(txt))

    div = 1

    for valor in rep.values():
        div *= factorial(valor)

    return(nletra//div)

qtd = int(input())

resp = []

for i in range(0, qtd):
    txt = input()
    resp.append(anagrams(txt))

for i in range(0, qtd):
    print(resp[i])
