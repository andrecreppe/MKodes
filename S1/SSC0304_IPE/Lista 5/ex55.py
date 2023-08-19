class Atleta:
    nome:str
    def __init__(self, nome):
        self.nome = nome

class Corredor(Atleta):
    def correr(self):
        return ('Corredor '+self.nome+' correndo')

class Nadador(Atleta):
    def nadar(self):
        return ('Nadador '+self.nome+' nadando')

class Ciclista(Atleta):
    def pedalar(self):
        return ("Ciclista "+self.nome+" pedalando")

class TriAtleta(Corredor,Nadador,Ciclista):

    def __str__(self):
        return '{}\n{}\n{}'.format(self.correr(), self.nadar(), self.pedalar())

obj = TriAtleta(input())

print(obj)