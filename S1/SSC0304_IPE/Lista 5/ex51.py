class Car(object):
    def __init__(self, id, manuf, model, color, year, price):
        self.id = id
        self.manufacturer = manuf
        self.model = model
        self.color = color
        self.year = year
        self.price = price

    def setID(self, id):
        self.id = id
    def setManufacturer(self, manuf):
        self.manufacturer = manuf
    def setModel(self, model):
        self.model = model
    def setColor(self, color):
        self.color = color
    def setYear(self, year):
        self.year = year
    def setPrice(self, price):
        self.price = price

    def getID(self):
        return self.id
    def getManufacturer(self):
        return self.manufacturer
    def getModel(self):
        return self.model
    def getColor(self):
        return self.color
    def getYear(self):
        return self.year
    def getPrice(self):
        return self.price

    def __str__(self):
        output = "Fab: " + self.getManufacturer()
        output += "\nMod: " + self.getModel()
        output += "\nCor: " + self.getColor()
        output += "\nAno: " + str(self.getYear())
        output += "\nPre: " + str(self.getPrice()) + "\n"
        return output

    def changeManufacturer(self, newManufacturer):
        setManufacturer(self, newManufacturer)

#Main
data = []

qtdCars = int(input())

for i in range(qtdCars):
    car = Car(int(input()), input(), input(), input(), int(input()), int(input()))
    data.append(car)

while(True):
    op = int(input())

    if(op == 0):
        break
    elif(op == 1):
        searchID = int(input())

        for car in data:
            if(car.getID() == searchID):
                print(car)
                break
    elif(op == 2):
        for car in data:
            if(car.getManufacturer() == "Chevrolet"):
                car.setManufacturer("GM")
    elif(op == 3):
        for car in data:
            print(car)
