import string

dicLetters = dict.fromkeys(string.ascii_lowercase , 0)

#f = open("b:\\Programming\\IPE\\Lista 6\\texto.txt", "r")
f = open("texto.txt", "r")

text = f.read().lower()

f.close()

for c in text:
    if c.isalpha():
        dicLetters[c] = dicLetters[c] + 1

for c in dicLetters:
    print(c, '=', dicLetters[c])
