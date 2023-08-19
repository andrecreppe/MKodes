#include <iostream>
#include <cstring>
#include <conio.h>

#define MAX 10

using namespace std;

void orderer(string str, char table[MAX][MAX]) {
    int len = str.length();

    for(int i=0; i<len; i++) {
        for(int j=0; j<len; j++) {
            table[i][j] = str[i];
        }
    }
}

void scrambler(string str, char table[MAX][MAX]) {
    int len = str.length();
    int posx = -1;

    for(int i=len; i>0; i--) {
        int count = i;
        posx++;

        for(int j=0; j<len; j++) {
            if(count == len) {
                count = 0;
            }

            table[j][posx] = str[count];

            count++;
        }
    }
}

void displayMatrix(int len, char table[MAX][MAX]) {
	printf("\n");
    for(int i=0; i<len; i++) {
        for(int j=0; j<len; j++) {
            printf("%c ", table[j][i]);
        }
        printf("\n");
    }

    printf("\n");
}

int recursiveFinder(int x, int y, char table[MAX][MAX], int pos, int len) {
    if(x == len || y < 0) { // out of boundary
        return 0;
    }

    char el = table[x][y];
    char ref = table[pos][0]; // 1st line is always the correct word

    if(el == ref) {
        printf("(%d, %d)-%c ", x, y, el);

        if(pos == len-1) { // end of the word
            return 1;
        }

        int res = recursiveFinder(x+1, y, table, pos+1, len); // go right
        res += recursiveFinder(x, y-1, table, pos+1, len); // go up

        return res;
    }

    return 0;
}

int findWords(char table[MAX][MAX], int len) {
    int count = 0;

    for(int i=0; i<len; i++) {
        for(int j=0; j<len; j++) {
            count += recursiveFinder(j, i, table, 0, len);
        }
        printf("\n");
    }

    return count;
}

int main() {
    // Initialization
    string word;
    int len;

    char table[MAX][MAX];
    memset(table, 0, sizeof(table));

    // User entry

    do {
        printf("Digite uma palavra com 10 caracteres ou menos:");
        getline(cin, word);

        len = word.length();
    } while(len <= 0 || len > MAX);

    // Word table

    scrambler(word, table);
//    orderer(word, table);

    displayMatrix(len, table);

    // Algorithm

    int qtd = findWords(table, len);
    printf("\nFoi encontrado %d jeitos diferentes.", qtd);
    
    getch();

    return 0;
}

