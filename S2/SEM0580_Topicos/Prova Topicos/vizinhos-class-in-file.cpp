// André Zanardi Creppe - 11802972
// Programado dentro da IDE CLion

// estou enviando essa outra cópia pois tive alguns problemas ao executar esse programa no DevC++.
// então para evitar possiveis problemas, essa é uma versão do meu código feita em classe única

#include <stdio.h>

class Vizinhos {
public:
	void transform(float matA[20][20], float matB[20][20]) {
		/* Forma escolhida de receber uma matriz: referência, e as duas
		 * Forma escolhida de varrer a matriz: separar as bordas do ceu "miolo"
		 * - Bordas => divididas entre cada caso (cima, fundo, esq, dir)
		 */

		for(int i=0; i<20; i++) {
			for(int j=0; j<20; j++) {
				float avg = 0;

				if(j == 0) { // topo
					avg = top(matA, i, j);
				} else if(j == 19) { // fundo
					avg = bottom(matA, i, j);
				} else if(i == 0) { // esquerda
					avg = left(matA, i, j);
				} else if(i == 19) { // direita
					avg = right(matA, i, j);
				} else { // miolo
					avg = center(matA, i, j);
				}

				matB[j][i] = avg;
			}
		}
	}

	void test() {
		float matA[20][20], matB[20][20];

		for(int i=0; i<20; i++) {
			for(int j=0; j<20; j++) {
				matA[i][j] = 1;
				matB[i][j] = 0;
			}
		}

		showMatrix(matA);
		transform(matA, matB);
		showMatrix(matB);

		getchar();
	}

private:
	float center(float mat[20][20], int x, int y) {
		// Não preciso me preocupar com nada

		float sum = 0;

		sum += mat[y-1][x-1] * 0.1;
		sum += mat[y-1][x] * 0.15;
		sum += mat[y-1][x+1] * 0.1;
		sum += mat[y][x-1] * 0.15;
		// x,y = centro
		sum += mat[y][x+1] * 0.15;
		sum += mat[y+1][x-1] * 0.1;
		sum += mat[y+1][x] * 0.15;
		sum += mat[y+1][x+1] * 0.1;

		return sum;
	}

	float top(float mat[20][20], int x, int y) {
		// Só preciso me preocupar com os casoss de quinas

		float sum = 0;

		if(x != 0) {
			sum += mat[y][x-1] * 0.15;
			sum += mat[y+1][x-1] * 0.1;
		}

		if(x != 19) {
			sum += mat[y][x+1] * 0.15;
			sum += mat[y+1][x+1] * 0.1;
		}

		// x,y = centro
		sum += mat[y+1][x] * 0.15;

		return sum;
	}

	float bottom(float mat[20][20], int x, int y) {
		// Só preciso me preocupar com os casoss de quinas

		float sum = 0;

		if(x != 0) {
			sum += mat[y-1][x-1] * 0.1;
			sum += mat[y][x-1] * 0.15;
		}

		if(x != 19) {
			sum += mat[y-1][x+1] * 0.1;
			sum += mat[y][x+1] * 0.15;
		}

		// x,y = center
		sum += mat[y-1][x] * 0.15;

		return sum;
	}

	float left(float mat[20][20], int x, int y) {
		// Só preciso me preocupar com os casoss de quinas

		float sum = 0;

		if(y != 0) {
			sum += mat[y-1][x] * 0.15;
			sum += mat[y-1][x+1] * 0.1;
		}

		if(y != 19) {
			sum += mat[y+1][x] * 0.15;
			sum += mat[y+1][x+1] * 0.1;
		}

		// x,y = center
		sum += mat[y][x+1] * 0.15;

		return sum;
	}

	float right(float mat[20][20], int x, int y) {
		// Só preciso me preocupar com os casoss de quinas

		float sum = 0;

		if(y != 0) {
			sum += mat[y-1][x-1] * 0.1;
			sum += mat[y-1][x] * 0.15;
		}

		if(y != 19) {
			sum += mat[y+1][x-1] * 0.1;
			sum += mat[y+1][x] * 0.15;
		}

		// x,y = center
		sum += mat[y][x-1] * 0.15;

		return sum;
	}

	void showMatrix(float mat[20][20]) {
		for(int i=0; i<20; i++) {
			for(int j=0; j<20; j++) {
				printf("%.2f  ", mat[j][i]);
			}
			printf("\n");
		}

		printf("\n");
	}
};

//int main() {
//	Vizinhos viz;
//	viz.test();
//}
