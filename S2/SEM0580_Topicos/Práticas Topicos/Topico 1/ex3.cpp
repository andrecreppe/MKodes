#include <iostream>

using namespace std;

void findBinary(int n) {
	if (n/2 != 0) {
        findBinary(n/2);
    }
    
    cout << n%2;
}

int main() {
	int num;
	
	cout << "*** Conversor Decimal -> Binario ***" << endl;
	cout << "Digite o valor decimal: ";
	cin >> num;
	
	cout << num << " -> ";
	findBinary(num);
}

