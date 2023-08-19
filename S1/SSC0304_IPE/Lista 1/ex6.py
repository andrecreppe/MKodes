a, b, c = input().split(" ")

a, b, c = [int(a), int(b), int(c)]

buff = 0

if(a > b):
    buff = a
    a = b
    b = buff

if(b > c):
    buff = b
    b = c
    c = buff

if(a > b):
    buff = a
    a = b
    b = buff

print(a, b, c)