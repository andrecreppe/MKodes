#include <iostream>
#include <math.h>

using namespace std;

int factorial(int n) {
	if(n > 1) {
		return n * factorial(n-1);
	} else {
		return 1;
	}
}

float serie(float x) {
	float res = 1;
	bool flag = true;
	
	for(int i=2; i<=30; i+=2) {
		float part = (float) (pow(x, i) / factorial(i));
		
		if(flag) {
			part *= -1;
		}
		
		res += part;
		
		flag = !flag;
	}
	
	return res;
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
		res[i] = serie(conv);
	}
	
	for(int i=0; i<n; i++){
		cout << "\ncos (" << ang[i] << ") = ~" << res[i];
	}
	
	return 0;
}

