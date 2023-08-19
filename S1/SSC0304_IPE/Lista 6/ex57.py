import pickle as pk

class Aluno (object):
    def __init (self, nome, idade, sexo, matricula):
        self.nome  = nome
        self.idade = idade
        self.sexo = sexo
        self.matricula = matricula

    def __str__ (self):
        return "Nome: "+ self.nome + "\nIdade: " + str(self.idade) + "\nSexo: " + self.sexo + "\nMatricula: " + str(self.matricula)

#Main
#f = open("b:\\Programming\\IPE\\Lista 6\\dados-alunos.bin", "rb")
f = open("dados-alunos.bin", "rb")

total = pk.load(f)

data = []

for i in range(total):
    al = Aluno()

    line = pk.load(f)
    al.nome = line.nome
    al.idade = line.idade
    al.sexo = line.sexo
    al.matricula = line.matricula

    data.append(al)

inputID = int(input())

for i in range(total):
    if(inputID == data[i].matricula):
        print(data[i])
