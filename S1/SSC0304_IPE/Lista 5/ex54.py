class Aluno(object):
    def setNumUsp(self, numUSP):
        self.numUSP = numUSP
    def setNome(self, nome):
        self.nome = nome
    def setCurso(self, curso):
        self.curso = curso
    def setIdade(self, idade):
        self.idade = idade

    def getNumUsp(self):
        return self.numUSP
    def getNome(self):
        return self.nome 
    def getCurso(self):
        return self.curso
    def getIdade(self):
        return idade

    def __str__(self):
        return 'Nome: ' + self.nome + '\n' + 'Curso: ' + self.curso + '\n' + 'N USP: ' + str(self.numUSP) + '\n' + 'IDADE: ' + str(self.idade) + '\n'
    
#Main
alunos = []

numUsp = int(input())

while(numUsp != -1):
    al = Aluno()
    al.setNumUsp(numUsp)
    al.setNome(input())
    al.setCurso(input())
    al.setIdade(int(input()))

    alunos.append(al)

    numUsp = int(input())

while(True):
    opc = int(input())

    if(opc==-1):
        break

    elif(opc==1):
        numUsp = int(input())

        for al in alunos:
            if(al.getNumUsp()==numUsp):
                print(al)
                break

    elif(opc==2):
        cur = input()

        for al in alunos:
            if(al.getCurso()==cur):
                print(al)
    
    else:
        for al in alunos:
            print(al)
