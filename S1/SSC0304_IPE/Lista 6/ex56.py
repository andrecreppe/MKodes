import pickle as pk

class Funcionario (object):
    def __init__(self, nome, idade, sexo, salario):
        self.nome = nome
        self.idade = idade
        self.sexo = sexo
        self.salario = salario

#Main
#f = open("b:\\Programming\\IPE\\Lista 6\\dados-funcionario.bin", "rb")
f = open("dados-funcionario.bin", "rb")

total = pk.load(f)

totM = 0
totW = 0
sumSalM = 0
sumSalW = 0

for i in range(total):
    line = pk.load(f)

    if(line.sexo == 'm'):
        totM += 1
        sumSalM += line.salario
    else:
        totW += 1
        sumSalW += line.salario

f.close()

avgSal = (sumSalM + sumSalW) / total
avgSalM = sumSalM / totM
avgSalW = sumSalW / totW

print(total, totM, totW, f'{avgSal:.2f}', f'{avgSalM:.2f}', f'{avgSalW:.2f}')
