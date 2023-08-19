#include <iostream>
#include <math.h>

using namespace std;

// A fórmula dada do enunciado não funciona!
// Utilizei portanto a série de Leibniz
float pi() {
	float res = 0;
	bool flag = false;
	
	for(int i=1; i<=10000; i+=2) {
		float part = (float) 1/i;
		
		if(flag) {
			part *= -1;
		}
		
		res += part;
		
//		cout << i << " <> " << part << endl;
		
		flag = !flag;
	}
	
	return 4*res;
}

float area(float r) {
	return pi() * pow(r, 2);
}

float volume(float r) {
	return (4/3) * pi() * pow(r, 3);
}

int main() {
	float r;
	
//	cout << pi();
//	
//	return 0;
	
	cout << "Entre com o valor do raio: ";
	cin >> r;
	
	cout << "\nArea de uma circunferencia de raio " << r << " = " << area(r);
	cout << "\nVolume de uma esfera de raio " << r << " = " << volume(r);
	
	return 0;
}

