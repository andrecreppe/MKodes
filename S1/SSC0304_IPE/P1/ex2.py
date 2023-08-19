def findBlank(board):
    for i in range(3):
        for j in range(3):
            if(board[i][j] == '-'):
                return True
    
    return False

def searchLine(board):
    countX = 0
    countO = 0

    for i in range(3):
        for j in range(3):
            if(board[i][j] == 'x'):
                countX += 1
            elif(board[i][j] == 'o'):
                countO += 1

        if(countX == 3):
            return 1
        elif(countO == 3):
            return 2

        countX = 0
        countO = 0

    return 0

def searchRow(board):
    countX = 0
    countO = 0

    for i in range(3):
        for j in range(3):
            if(board[j][i] == 'x'):
                countX += 1
            elif(board[i][j] == 'o'):
                countO += 1
            
        if(countX == 3):
            return 1
        elif(countO == 3):
            return 2

        countX = 0
        countO = 0

    return 0

def searchDiagonal(board):
    if(board[0][0] == board[1][1] == board[2][2]):
        if(board[0][0] == 'x'):
            return 1
        else:
            return 2

    if(board[0][2] == board[1][1] == board[2][0]):
        if(board[0][0] == 'x'):
            return 1
        else:
            return 2

    return 0

data = input().replace("\n", "")
data = data.replace("\r", "")
l1 = data.split(" ")

data = input().replace("\n", "")
data = data.replace("\r", "")
l2 = data.split(" ")

data = input().replace("\n", "")
data = data.replace("\r", "")
l3 = data.split(" ")

board = [l1, l2, l3]

ln = searchLine(board)
if(ln == 1):
    print("x ganhou")
    exit()
elif(ln == 2):
    print("o ganhou")
    exit()

rw = searchRow(board)
if(rw == 1):
    print("x ganhou")
    exit()
elif(rw == 2):
    print("o ganhou")
    exit()

dg = searchDiagonal(board)
if(dg == 1):
    print("x ganhou")
    exit()
elif(dg == 2):
    print("o ganhou")
    exit()

if(findBlank(board)):
    print("em jogo")
else:
    print("empate")