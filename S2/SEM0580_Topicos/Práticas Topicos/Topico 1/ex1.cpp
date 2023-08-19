#include <iostream>

using namespace std;

int main() {
	int x, n;
	int res;
	
	cout << "*** Calculadora de exponencial ***" << endl;
	cout << "Insira uma base inteira (x): ";
	cin >> x;
	cout << "Insira agora o expoente (n): ";
	cin >> n;
	
	int xo = x;
	for(int i=1; i<n; i++) {
		x *= xo;
	}
	
	cout << xo << "^" << n << " = " << x;
}

