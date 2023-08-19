def findTime(t, p):
    if(p == "Mercurio"):
        d = t // 5068800
        t -= d * 5068800
        h = t // 3600
        t -= h * 3600
        m = t // 60
        t -= m * 60
        s = t
    elif(p == "Venus"):
        d = t // 20995200
        t -= d * 20995200
        h = t // 3600
        t -= h * 3600
        m = t // 60
        t -= m * 60
        s = t
    elif(p == "Terra"):
        d = t // 86400
        t -= d * 86400
        h = t // 3600
        t -= h * 3600
        m = t // 60
        t -= m * 60
        s = t
    elif(p == "Jupiter"):
        d = t // 35760
        t -= d * 35760
        h = t // 3600
        t -= h * 3600   
        m = t // 60
        t -= m * 60
        s = t
    
    return (str(d) + " dias, " + str(h) + " horas, " + str(m) + " minutos e " + str(s) + " segundos")

sec, planet = input().split(" ")
sec = int(sec)

time = findTime(sec, planet)

print(str(sec) + " segundos no planeta " + str(planet) + " equivalem a:")
print(time)