qtd = int(input())

dic = {}
for i in range(qtd):
    name, phone = input().replace("\r","").split(" ")
    dic[name] = phone


while(len(dic) > 0):
    print(dic.popitem())