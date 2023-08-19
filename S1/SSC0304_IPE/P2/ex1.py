import pickle as pk

class Aluno(object):
    __matricula:int
    __nome:str
    __idade:int
    __sexo:str
    __notas:[] #5 notas

    def __init__(self, matricula, nome, idade, sexo, notas):
        self.__matricula = matricula
        self.__nome = nome
        self.__idade = idade
        self.__sexo = sexo
        self.__notas = notas

    def getID(self):
        return self.__matricula

    def getName(self):
        return self.__nome

    def getFinalNote(self):
        summ = 0
        sz = len(self.__notas)

        for i in range(sz):
            summ += self.__notas[i]

        return (summ / sz)

#Main
fb = open('alunos.bin', 'rb')

students = []
ids = []

for i in range(5):
    students.append(pk.load(fb))

fb.close()


ft = open('alunos.txt', 'r')

for data in ft:
    ids.append(int(data))

ft.close()


for id in ids:
    for student in students:
        if student.getID() == id:
            print(student.getName())

            if(student.getFinalNote() >= 5.0):
                print("Aprovado", f'{student.getFinalNote():.1f}')
            else:
                print("Reprovado", f'{student.getFinalNote():.1f}')
            print()
