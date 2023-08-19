#include <iostream>

using namespace std;

float series(int n, int d) {
	if(d != 50) {
		return (n/d) + series(n+2, d+1);
	} else {
		return (n/d);
	}
}

int main() {
	cout << series(1,1) << endl;
	
//	float count = 1;
//	for(int i=2; i<=50; i++) {
//		count += (i+1)/i;
//	}
//	
//	cout << count;
	
	return 0;
}

