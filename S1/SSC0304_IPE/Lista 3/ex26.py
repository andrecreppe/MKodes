txt = input().split(" ")

iMax = 0
szMax = len(txt[0])
iMin = 0
szMin = len(txt[0])

for i in range(1, len(txt)):
    sz = len(txt[i])

    if(sz > szMax):
        szMax = sz
        iMax = i
    elif(sz < szMin):
        szMin = sz
        iMin = i

print(txt[iMin])
print(txt[iMax])