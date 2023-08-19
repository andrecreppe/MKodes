import numpy as np

mat = eval(input().split()[0])
n = int(input())

m = np.array(mat)

print("M * N")
print(m * n)
print("M + N")
print(m + n)
print("M - N")
print(m - n)
print("M / N")
print(m / n)