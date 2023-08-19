class Person(object):
    __id:int
    __name:str
    __adress:str

    def get_id(self):
        return self.__id

    def set_id(self, id):
        self.__id = id

    def get_name(self):
        return self.__name

    def set_name(self, name):
        self.__name = name

    def get_adress(self):
        return self.__adress

    def set_adress(self, adress):
        self.__adress = adress

class Funcionario(Person):
    __base_salary:float

    def get_base_salary(self):
        return self.__base_salary

    def set_base_salary(self, base_salary):
        self.__base_salary = base_salary

    def get_total_recived(self):
        pass

class Clt(Funcionario):
    __transportation:float
    __food:float

    def get_transportation(self):
        return self.__transportation

    def set_transportation(self, transportation):
        self.__transportation = transportation

    def get_food(self):
        return self.__food

    def set_food(self, food):
        self.__food = food

    def get_total_recived(self):
        return self.get_base_salary() + self.__food + self.__transportation

    def __str__(self):
        output =  'Tipo: Clt'
        output +=  '\nNome: ' + self.get_name()
        output +=  '\nEndereco: ' + self.get_adress()
        output +=  '\nSalario Base: ' + str(self.get_base_salary())
        output +=  '\nTransporte: ' + str(self.get_transportation())
        output +=  '\nAlimentacao: ' + str(self.get_food())
        output +=  '\nTotal Recebido: ' + str(self.get_total_recived()) +'\n'
        return output

class Comissionado(Funcionario):
    __sales:int
    __percentage:float

    def get_sales(self):
        return self.__sales

    def set_sales(self, sales):
        self.__sales = sales
    
    def get_percentage(self):
        return self.__percentage

    def set_percentage(self, percentage):
        self.__percentage = percentage

    def get_total_recived(self):
        return self.get_base_salary()   + self.__sales * self.__percentage

    def __str__(self):
        output =  'Tipo: Comissionado'
        output +=  '\nNome: ' + self.get_name()
        output +=  '\nEndereco: ' + self.get_adress()
        output +=  '\nSalario Base: ' + str(self.get_base_salary())
        output +=  '\nVendas: ' + str(self.get_sales())
        output +=  '\nComissao: ' + str(self.get_percentage())
        output +=  '\nTotal Recebido: ' + str(self.get_total_recived()) +'\n'
        return output

n = int(input())

funcionarios = []

for i in range(n):
    tipo = int(input())

    if(tipo == 1):
        p = Clt()
        p.set_id(int(input()))
        p.set_name(input())
        p.set_adress(input())
        p.set_base_salary(float(input()))
        p.set_transportation(float(input()))
        p.set_food(float(input()))
        funcionarios.append(p)
    else:
        p = Comissionado()
        p.set_id(int(input()))
        p.set_name(input())
        p.set_adress(input())
        p.set_base_salary(float(input()))
        p.set_sales(int(input()))
        p.set_percentage(float(input()))
        funcionarios.append(p)

funcionarios = sorted(funcionarios, key = Person.get_id)

for p in  funcionarios:
    print(p)