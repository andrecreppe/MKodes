#include <iostream>
#include <math.h>

using namespace std;

float macLaurin(float a) {
	float a3 = pow(a, 3) / 6;
	float a5 = pow(a, 5) / 120;
	float a7 = pow(a, 7) / 5040;
	
	return (a - a3 + a5 - a7);
}

int main() {
	int n;
	
	cout << "Quantos valores vai inserir? ";
	cin >> n;
	cout << endl;
	
	float ang[n], conv, res[n];
	
	for(int i=0; i<n; i++) {
		cout << "Angulo " << i+1 << ": ";
		cin >> ang[i];
		
		conv = (M_PI * ang[i]) / 180;
		res[i] = macLaurin(conv);
	}
	
	for(int i=0; i<n; i++){
		cout << "\nsen (" << ang[i] << ") = ~" << res[i];
	}
	
	return 0;
}

