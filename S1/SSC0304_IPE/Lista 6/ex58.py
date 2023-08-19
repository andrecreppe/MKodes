def biggestIndex(list, index, maxIndex, qtd):
    if(index >= qtd):
        return maxIndex
    else:
        maxIndex = list[index]>list[maxIndex] and index or maxIndex

        return biggestIndex(list, index+1 ,maxIndex, qtd)

#f = open("b:\\Programming\\IPE\\Lista 6\\dados-58.txt", "r")
f = open("dados.txt", "r")

total = int(f.readline())

data = list(map(float, f.readline().split()))

f.close()

biggest = biggestIndex(data, 1, 0, total)

print("Valor Maior: %.2f" % data[biggest])
print("Pos Maior:", biggest)
