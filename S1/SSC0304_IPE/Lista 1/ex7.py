ano = int(input())

if(ano % 4) == 0:
    if(ano % 100) == 0:
        if(ano % 400) == 0:
            print("sim")
        else:
            print("nao")
    else:
        print("sim")
else:
    print("nao")