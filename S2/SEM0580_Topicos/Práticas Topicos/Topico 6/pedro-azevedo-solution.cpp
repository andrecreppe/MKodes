#include <iostream>
using std::cout;
using std::cin;
using std::endl;
#include <string>
using std::string;
using std::getline;
#include <Windows.h>

// aquele programa que forma uma matriz a partir de uma palavra com a rotacao da ultima letra e mostra todos os caminhos possiveis pra formar a palavra original

void setcolor(unsigned short color){
    HANDLE hcon = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(hcon, color);
}

class WordMath{                               
	private:                                     
		char matrix[50][50]; 
		string word;   // palavra inserida pelo usuario
		
		word_paths_aux(int line, int column, int letter){ // funcao que recebe uma posicao (linha e coluna) de uma letra da palavra (a letra seria word[letter])  e busca todos os caminhos possiveis a partir desse ponto para terminar a palavra completa
			int static counting=0;  // -> conta a quantidade de caminhos 
			int static listpositions[50];  /* -> lista de posicoes passadas no caminho    
			Exemplo: {2,2,2,3,1,3,1,4} significaria que percorreu as posicoes (2,2), (2,3), (1,3), (1,4), nessa ordem.*/
			listpositions[2*letter]=line;       
			listpositions[2*letter+1]=column;
			letter++;
			if (letter==word.length()){  // chegou no final da palavra, pode imprimir o caminho
				counting++;
				cout<<"Caminho de numero "<<counting<<'\n'<<endl;
				for (int i=0;i<this->word.length();i++){                             
					for (int j=0;j<this->word.length();j++){                              
						for (int k=0; k<this->word.length()*2-1; k+=2){
							if (i==listpositions[k] && j==listpositions[k+1]){   // se a posicao estiver na lista das posicoes passadas pelo caminho, troca a cor do elemento para verde
								setcolor(2);       
								break;
							}
							else
								continue;
						}
						cout<<matrix[i][j]<<" ";          
						setcolor(15);                                     
					}
					cout<<'\n';
				}
				cout<<endl;
			}else{
				if (word[letter]==matrix[line-1][column])
					word_paths_aux(line-1,column,letter);
				if(word[letter]==matrix[line][column+1])
					word_paths_aux(line,column+1,letter);
			}
		}
		 
	public:         
		void set_word(string word){
			for (int i=0; i<word.length(); i++)
				for (int j=0; j<word.length(); j++){
					if (j+i<word.length()){
						matrix[i][j+i]=word[j];
					}
					if (j+i>=word.length()){
						matrix[i][j+i-word.length()]=word[j];
					}
				}
			this->word=word;
		}
		
		void show_matrix(){  // mostra a matriz formada pela rotacao da letra final da palavra (funcao nao utilizada nesse codigo mas pode ser util em codigos futuros)
			for (int i=0;i<this->word.length();i++){
				for (int j=0;j<this->word.length();j++){
					cout<<matrix[i][j]<<" ";                                               
				}
				cout<<'\n';
			}
		}
		
		void word_paths(){  // funcao que encontra todas as posicoes correspondentes que possuem a mesma letra de inicio da palavra original e chama a funcao word_path_aux para formar os caminhos inteiros
			for (int i=0;i<this->word.length();i++){  
				for (int j=0;j<this->word.length();j++){
					if(matrix[i][j]==word[0]){
						word_paths_aux(i,j,0);
					}else
						continue;
				}
			}
		}
};

int main(){
	string w;
	WordMath wm;
	
	cout<<"Digite uma palavra: \n >> ";
  	cin>>w;
  	wm.set_word(w);
  	cout<<endl;
  	
  	wm.word_paths();

	system("pause");
	return 0;
}

