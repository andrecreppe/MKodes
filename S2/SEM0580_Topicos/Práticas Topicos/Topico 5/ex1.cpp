#include<iostream>
#include<stdlib.h>
#include<conio.h>

using namespace std;

class Vector {
	private:
		int arr[];
		int sortArr[];
		int count;

        void bubbleSort() {
            int n = this->count;

            for(int i=1; i<n; i++) {
                this->sortArr[i] = this->arr[i];
            }

            for (int i=1; i<n; i++) {
                for (int j=1; j<n-i; j++) {
                    if (this->sortArr[j] > this->sortArr[j+1]) {
                        int buff = this->sortArr[j+1];
                        this->sortArr[j+1] = this->sortArr[j];
                        this->sortArr[j] = buff;
                    }
                }
            }

            this->count = n;
        }

        void showSortArr() {
//            system("cls");

            cout << "Stored data:" << endl;

            for(int i=1; i<this->count; i++) {
                cout << "[" << i << "] = " << this->sortArr[i] << endl;
            }

            cout << endl;
        }

	public:
		Vector() {
			this->count = 1;
		}

		void addValue(int x) {
			int index = this->count;

			this->arr[index] = x;

			this->count = index + 1;
		}

		void showArr() {
            system("cls");

			cout << "Stored data:" << endl;

			for(int i=1; i<this->count; i++) {
				cout << "[" << i << "] = " << this->arr[i] << endl;
			}

			cout << endl;
		}

        void getOne(int x) {
           cout << "First recurrence of: " << x << endl;

            for(int i=1; i<this->count; i++) {
                int item = this->arr[i];

                if(item == x) {
                    cout << "[" << i << "] = " << item << endl;
                    return;
                }
            }

            cout << "Item not found!" << endl;
        }

        void getMany(int x) {
            bool found = false;

            cout << "Search all recurrences of: " << x << endl;

            for(int i=1; i<this->count; i++) {
                int item = this->arr[i];

                if(item == x) {
                    found = true;
                    cout << "[" << i << "] = " << item << endl;
                }
            }

            if(!found) {
                cout << "Item not found!" << endl;
            }
        }

        void binarySearch (int x) {
            int max = this->count;
            int min = 1;

            this->bubbleSort();
//            this->showSortArr();

            while (min <= max) {
                int half = (max-1) / 2;

                int item = this->sortArr[half];

                if (x == item) {
                    cout << "[" << half << "] = " << item << endl;
                    return;
                } else if (x < item) {
                    max = half - 1;
                } else {
                    min = half + 1;
                }
            }

            cout << "Item not found!" << endl;
        }

        void getMinMax() {
            int size = this->count;

            this->bubbleSort();

            cout << "Min: " << this->sortArr[1] << endl;
            cout << "Max: " << this->sortArr[size - 1];
        }

        void mode() {
            int max = 0;

            for(int i=1; i<this->count; i++) {
                int item = this->arr[i];

                if(item > max) {
                    max = item;
                }
            }

            int counting[max] = {};

            for(int i=1; i<this->count; i++) {
                int item = this->arr[i];
                counting[item] += 1;
            }

            int modeIndex = 0;
            int recMode = counting[0];

            for(int i=1; i<max; i++) {
                int rec = counting[i];

                if(rec > recMode) {
                    modeIndex = i;
                    recMode = rec;
                }
            }

            cout << "Mode = " << modeIndex << " (" << recMode << " times)" << endl;
        }
};

int menu() {
    system("cls");

    cout << "> Table <" << endl;
    cout << "1- Insert items" << endl;
    cout << "=====================" << endl;
    cout << "> Search <" << endl;
    cout << "2- Get One" << endl;
    cout << "3- Get Many" << endl;
    cout << "4- Binary search" << endl;
    cout << "=====================" << endl;
    cout << "> Properties <" << endl;
    cout << "5- Max and min elements" << endl;
    cout << "6- Mode" << endl;
    cout << "=====================" << endl;
    cout << "7- Exit" << endl;
    cout << "=====================" << endl;

    int op;
    cout << "Operation: ";
    cin >> op;

    return op;
}

int main() {
    int op;
	Vector v;

	cout << "** Integer Table Manager **" << endl << endl;

	while(true) {
        op = menu();

	    if(op == 7) {
	        return 0;
	    } else if(1 <= op && op <= 6) {
            int item;

            switch (op) {
                case 1:
                    cout << "Table insertion (enter -1 to exit)" << endl;

                    while(true) {
                        cout << "Item to add: ";
                        cin >> item;

                        if(item >= 0) {
                            v.addValue(item);
                        } else {
                            break;
                        }
                    }

                    v.showArr();
                    getch();

                    break;
                case 2:
                    int x;
                    cout << "Element to search: ";
                    cin >> x;
                    cout << endl;

                    v.getOne(x);

                    getch();
                    break;
                case 3:
                    cout << "Element to search: ";
                    cin >> x;
                    cout << endl;

                    v.getMany(x);

                    getch();
                    break;
                case 4:
                    cout << "Element to search: ";
                    cin >> x;
                    cout << endl;

                    v.binarySearch(x);

                    getch();
                    break;
                case 5:
                    v.getMinMax();

                    getch();
                    break;
                case 6:
                    v.mode();

                    getch();
                    break;
            }
	    }
	}
}

