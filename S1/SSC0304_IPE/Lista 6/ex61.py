#f = open("b:\\Programming\\IPE\\Lista 6\\QuePaisEste.txt", "r")
f = open("QuePaiseEste.txt", "r")

text = f.read().lower().split()

f.close()

p1, p2 = map(str, input().split())
n1, n2= 0, 0

for word in text:
    if word == p1.lower():
        n1 += 1
    if word == p2.lower():
        n2 += 1

print(p1, n1, p2, n2)
