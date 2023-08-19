#include<iostream>

using namespace std;

int main() {
	float a, b, n;
	
	cout << "Inicio: ";
	cin >> a ;
	cout << "Fim: ";
	cin >> b;
	cout << "Divisoes: ";
	cin >> n;
	
	float h = (b-a) / n;
	float x1 = a;
	float x2;
	float sum = 0;
	
	while(x2<b) {
		x2 = x1 + h;
		
		float frac = ((1/(1+(x1*x1))) + (1/(1+(x2*x2))))/2;
		
		sum += frac * h;
		x1 = x2;
	}
	
	float pi = 4*sum;
	
	cout << "\nPI = " << pi;
	
	return 0;
}

