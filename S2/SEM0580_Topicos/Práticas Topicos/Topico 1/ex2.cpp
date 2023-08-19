#include <iostream>

using namespace std;

int main() {
	int num;
	
	cout << "*** Conversor Binario -> Decimal ***" << endl;
	cout << "Digite o valor binario: ";
	cin >> num;
	
	int base = 1;
	int res = 0;
	int buff = num;
	
    while (buff) {
        int reminder = buff % 10;
        buff = buff / 10;

        res += reminder * base;

        base = base * 2;
    }
    
	cout << num << " -> " << res;
}

