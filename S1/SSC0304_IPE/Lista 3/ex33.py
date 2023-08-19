txt = input()

txt = txt.lower()
tam = int(len(txt)) - 1

wrong = False

for i in range(0, tam):
    if(txt[i] != txt[tam-i]):
        wrong = True

    if(wrong):
        print("NAO")
        break

if(not wrong):
    print("SIM")