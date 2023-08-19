#include <iostream>

using namespace std;

int main() {
	int n;
	
	cout << "Insira um valor inteiro n: ";
	cin >> n;
	
	float sum = 0;
	float nCalc = n;
	
	for(int i=1; i<=n; i++) {
		sum += (i/nCalc);
		
		nCalc--;
	}
	
	cout << "\nO resultado da expressao para n = " << n << " vale: " << sum;	
}

