#include<iostream>

#define ITER 10

using namespace std;

class Calculo {
	public:
		float integral() { // returns PI
			float h = 0.0001;
			float x1 = 0;
			float x2;
			float sum = 0;
			
			while(x2 < 1) {
				x2 = x1 + h;
				
				float frac = ((1/(1+(x1*x1))) + (1/(1+(x2*x2))))/2;
				
				sum += frac * h;
				x1 = x2;
			}
			
			return 4 * sum;
		}
		
		float root(float y, int n) {
			if(n == 1) {
		        return y/2;
		    }
		
		    float minus1 = this->root(y, n-1);
		
		    float num = (minus1 * minus1) + y;
		    float den = 2 * this->root(y, n-1);
		
		    return num/den;
		}
};

int main() {
	int op;

	cout << "**Calculadora geometrica**" << endl << endl;
	cout << "Digite o numero da operacao desejada:" << endl;
	cout << "1 - Esfera" << endl;
	cout << "2 - Cubo" << endl;
	cout << "Operacao: ";
	
	cin >> op;
	
	Calculo calc;
	
	if (op == 1) { // Circ
		float r, a, v;
		
		cout << "\n\** ESFERA **" << endl;
		cout << "Digite o valor do raio: ";
		cin >> r;
		
		float pi = calc.integral();
		a = 4 * pi * r * r;
		v = (4 * pi * r * r * r) / 3; 
		
		cout << "Area da esfera: " << a << endl;
		cout << "Volume da esfera: " << v;
	} else { // Sqr
		float l, a, v;
		
		cout << "\n\** CUBO **" << endl;
		cout << "Digite o valor do lado: ";
		cin >> l;
		
		float diag = l * calc.root(3, ITER);
		a = 6 * l * l;
		v = l * l;
		
		cout << "Area do cubo: " << a << endl;
		cout << "Volume do cubo: " << v << endl;
		cout << "Diagonal do cubo: " << diag;
	}
}

