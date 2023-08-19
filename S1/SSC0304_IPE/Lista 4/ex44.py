names = input().replace("\r", "").split(",")
ids = input().replace("\r", "").split(",")
querry = input().replace("\r", "").split(",")

dic = {}
for i in range(len(names)):
    dic[names[i]] = int(ids[i])

for i in range(len(querry)):
    del(dic[querry[i]])

print(dic)