#include <iostream>

using namespace std;

bool verifyPoints(float x, float y) {
	if((x < 0) || (y < 0)) {
		return false;
	}
	
	float calc = (x*x) + (y*y);
	
	if(calc > 1) {
		return false;
	}
	
	return true;
}

int main() {
	int n;
	
	cout << "Quantos numeros voce vai testar? ";
	cin >> n;

	float x, y;
	int count = 0;
	
	cout << "\nInsira o(s) par(es) ordenado(s) (x,y) com valores separados por um espaco:" << endl;
	
	for(int i=0; i<n; i++) {
		cout << "Par " << i+1 << ": ";
		cin >> x >> y;
		
		if(verifyPoints(x, y)) {
			count++;
		}
	}
	
	cout << "\nDos " << n << " ponto(s) inseridos, " << count << " pertence(m) a figura!";
}

