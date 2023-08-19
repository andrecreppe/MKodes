names = input().split(",")
ids = input().split(",")
querry = input().split(",")

dic = {}
for i in range(len(names)):
    dic[names[i].rstrip("\r")] = int(ids[i])

for i in range(len(querry)):
    name = querry[i].rstrip("\r")

    if(name in dic):
        print(dic[name])
    else:
        print("Nao Cadastrado")