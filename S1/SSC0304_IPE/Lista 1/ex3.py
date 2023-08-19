val = int(input())

count = val // 100
print(count, "de R$100,00")

val -= 100*count
count = val // 50
print(count, "de R$50,00")

val -= 50*count
count = val // 10
print(count, "de R$10,00")

val -= 10*count
count = val // 5
print(count, "de R$5,00")

val -= 5*count
count = val // 1
print(count, "de R$1,00")