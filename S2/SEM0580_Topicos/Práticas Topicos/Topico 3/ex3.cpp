#include <iostream>

#define ITER 10

using namespace std;

float newton(float y, int n) {
    if(n == 1) {
        return y/2;
    }

    float minus1 = newton(y, n-1);

    float num = (minus1 * minus1) + y;
    float den = 2*newton(y, n-1);

    return num/den;
}

int main() {
    float y;

    cout << "Digite um valor para se achar a raiz quadrada: ";
    cin >> y;

    cout << "sqrt(" << y << ") = " << newton(y, ITER);

    return 0;
}

