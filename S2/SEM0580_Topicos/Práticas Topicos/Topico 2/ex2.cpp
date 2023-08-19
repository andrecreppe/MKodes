#include <iostream>

using namespace std;

long expon(int x, int n) {
	int res = x;
	
	for(int i=2; i<=n; i++) {
		res *= x;
	}
	
	return res;
}

float series(int n, int d) {
	if(d != 1) {
		return (expon(2, n) / d) + series(n+1, d-1);
	} else {
		return (expon(2, n) / d);
	}
}

int main() {
	cout << expon(1, 50) << endl;
	
	return 0;
}

