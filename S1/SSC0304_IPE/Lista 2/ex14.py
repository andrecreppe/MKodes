num = int(input())
vals = input().split(" ")

count = 0
for i in range(0, 10):
    if(num > int(vals[i])):
        count += 1

print(count)