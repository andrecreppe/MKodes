names1 = input().split(",")
nums1 = input().split(",")

names2 = input().split(",")
nums2 = input().split(",")

dic1 = {}
print("Agenda 1")
for i in range(len(names1)):
    dic1[names1[i].rstrip("\r")] = int(nums1[i])
print(dic1)

dic2 = {}
print("Agenda 2")
for i in range(len(names2)):
    dic2[names2[i].rstrip("\r")] = int(nums2[i])
print(dic2)

print("Agenda Mesclada")
dic2.update(dic1)
print(dic2)
