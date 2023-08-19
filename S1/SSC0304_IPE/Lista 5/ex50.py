class Product(object):
    id:int
    cost:float
    qtd:int = 0

    #SETs
    def setId(self, id):
        self.id = id
    def setCost(self, cost):
        self.cost = cost
    def setQtd(self, qtd):
        self.qtd = qtd

    #GETs
    def getId(self):
        return self.id
    def getCost(self):
        return self.cost
    def getQtd(self):
        return self.qtd

    #Methods
    def getTotal(self):
        return self.cost * self.qtd
    
    def addQtd(self, add):
        self.qtd += add

    def __str__(self):
        return '#{}:    {}  {:.2f} {:.2f}\n'.format(self.id, self.qtd, self.cost, self.getTotal())

    def toString(self):
        return '#{}:    {}  {:.2f} {:.2f}\n'.format(self.id, self.qtd, self.cost, self.getTotal())

class Recipt:
    items = []

    def finalValue(self):
        tot = 0.0

        for p in self.items:
            tot += p.getTotal()

        return tot

    def addProduct(self, prod:Product):
        self.items.append(prod)

    def addQtd(self, id, qtd):
        for p in self.items:
            if p.getId() == id:
                p.addQtd(qtd)
                break

    def __str__(self):
        self.items = sorted(self.items, key = Product.getId)

        output = '#COD QTD VL_UN R$\n'

        for p in self.items:
            if p.getQtd() > 0:
                output += p.toString()

        output += 'Total: R$ {:.2f}'.format(self.finalValue())

        return output

#Main
rp = Recipt()

qtd = int(input())

for i in range(qtd):
    prod = Product()

    id, price = map(float, input().split(" "))

    prod.setId(int(id))
    prod.setCost(price)

    rp.addProduct(prod)

qtd = int(input())

for i in range(qtd):
    id, qtd = map(int, input().split(" "))

    rp.addQtd(id, qtd)

print(rp)
