num = int(input())

for i in range(num, 0, -1):
    if(num % i) == 0:
        print(i)
        