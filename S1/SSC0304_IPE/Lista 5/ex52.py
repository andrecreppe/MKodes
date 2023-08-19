class Time(object):
    sec:int = 0
    min:int = 0
    hr:int = 0

    def setSec(self, s):
        self.sec = s
    def setMin(self, m):
        self.min = m
    def setHour(self, h):
        self.hr = h

    def getSec(self):
        return self.sec
    def getMin(self):
        return self.min
    def getHour(self):
        return self.hr

    def formatNumber(self, num):
        return "{:02d}".format(num)

    def __str__(self):
        return self.formatNumber(self.getHour()) + ":" + self.formatNumber(self.getMin()) + ":" + self.formatNumber(self.getSec())

class Date(object):
    day:int = 0
    mon:int = 0
    yr:int = 0

    def setDay(self, d):
        self.day = d
    def setMon(self, m):
        self.mon = m
    def setYear(self, y):
        self.yr = y

    def getDay(self):
        return self.day
    def getMon(self):
        return self.mon
    def getYear(self):
        return self.yr

    def formatNumber(self, num):
        return "{:02d}".format(num)

    def __str__(self):
        return self.formatNumber(self.getDay()) + "/" + self.formatNumber(self.getMon()) + "/" + self.formatNumber(self.getYear())

class Reminder(object):
    time:Time = None
    date:Date = None
    task:str = ""

    def setTime(self, tm):
        self.time = tm
    def setDate(self, dt):
        self.date = dt
    def setTask(self, tsk):
        self.task = tsk

    def getTime(self):
        return self.time
    def getDate(self):
        return self.date
    def getTask(self):
        return self.task

    def __str__(self):
        output = str(self.getDate()) + " - " + str(self.getTime())
        output += "\n" + self.getTask()
        return output

#Main
calendar = []

qtd = int(input())

for i in range(qtd):
    dayData = Date()
    dayData.setDay(int(input()))
    dayData.setMon(int(input()))
    dayData.setYear(int(input()))

    timeData = Time()
    timeData.setHour(int(input()))
    timeData.setMin(int(input()))
    timeData.setSec(int(input()))

    reminder = Reminder()
    reminder.setDate(dayData)
    reminder.setTime(timeData)
    reminder.setTask(input())

    calendar.append(reminder)

for event in calendar:
    print(event)
