for i in range(0, 10):
    num = float(input())

    if(i == 0):
        maxVal = num
        minVal = num
    elif(num > maxVal):
        maxVal = num
    elif(num < minVal):
        minVal = num

print(format(minVal, '.2f'))
print(format(maxVal, '.2f'))
