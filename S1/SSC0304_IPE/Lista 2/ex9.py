num = int(input())

output = "0 " + str(num)
for i in range(2, 11):
    output += " "
    output += str(num * i)

print(output)