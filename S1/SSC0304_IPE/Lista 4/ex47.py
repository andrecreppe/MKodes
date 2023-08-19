import numpy as np

mat = eval(input().split(" ")[0])
arr = np.array(mat)

print("Transposta")
print(arr.transpose())

print("Inversa")
print(np.linalg.inv(mat))

print("Determinante")
print(np.linalg.det(mat))