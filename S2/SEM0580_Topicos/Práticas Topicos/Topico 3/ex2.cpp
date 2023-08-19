// https://play.google.com/store/apps/details?id=com.andrecreppe.LeastSquares 

#include<iostream>

using namespace std;

struct Point {
	float x;
	float y;
};

class LeastSquares {
	private:
		float a, b;
		
	public:
		float getA() {
			return this->a;
		}
		
		float getB() {
			return this->b;
		}
		
		void calculate(Point points[], int n) {
			float sumX = 0;
			float sumY = 0;
			float sumXY = 0;
			float sumX2 = 0;
			
			for(int i=0; i<n; i++) {
				float x = points[i].x;
				float y = points[i].y;
				
				sumX += x;
				sumY += y;
				sumXY += x*y;
				sumX2 += x*x;
			}
			
			float den = ((n*sumX2) - (sumX*sumX));
			
			this->a = ((n*sumXY) - (sumX*sumY)) / den;
			this->b = ((sumY*sumX2) - (sumX*sumXY)) / den;
		}
};

int main() {
	cout << "** Minimos Quadrados **" << endl;
	
	int n;
	
	cout << "\nQuantos pontos vai inserir? ";
	cin >> n;
	
	Point points[n];
	
	cout << "Digite cada coordenada separada por um espaco:" << endl;
	for(int i=0; i<n; i++) {
		cout << i+1 << ": ";
		cin >> points[i].x >> points[i].y;
	}
	
	LeastSquares ls;
	ls.calculate(points, n);
	
	cout << "\nReta ajustada: " << ls.getA() << "x + " << ls.getB();
	
	return 0;
}

