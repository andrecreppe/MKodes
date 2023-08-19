class Person(object):
    name:str
    sex:str
    age:int

    def __init__(self, name, sex, age):
        self.name = name
        self.sex = sex
        self.age = int(age)

    def getName(self):
        return self.name

    def getSex(self):
        return self.sex

    def getAge(self):
        return self.age

#Main
#f = open("b:\\Programming\\IPE\\Lista 6\\dados-59.txt", "r")
f = open("dados.txt", "r")

data = []

for line in f:
    name, sex, age = line.split()
    data.append(Person(name, sex, age))

f.close()

totM = 0
totW = 0
sumAgeM = 0
sumAgeW = 0

for person in data:
    if(person.getSex() == 'm'):
        totM += 1
        sumAgeM += person.getAge()
    else:
        totW += 1
        sumAgeW += person.getAge()

total = totM + totW

avgAge = (sumAgeM + sumAgeW) / total
avgM = sumAgeM / totM
avgW = sumAgeW / totW

print(total, totM, totW, f'{avgAge:.2f}', f'{avgM:.2f}', f'{avgW:.2f}')
