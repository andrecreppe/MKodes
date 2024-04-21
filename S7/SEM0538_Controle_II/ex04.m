clear all
close all

%%Letra B
A=[0 1; 2 -1];
B=[0; -1];
C=[1 0];
D=0;
p1=[-5+5i -5-5i];
K=place(A,B,p1)

G=ss(A-B*K,B,C,D);

t=linspace(0,3,1000);
u=[ones(1, length(t))];
X0=[0;0];
[Y,T,X]=lsim(G,u,t,X0);

figure
plot(T,X(:,1)/X(length(t),1),'b')
legend("Theta 1")
xlabel("Tempo [s]");
title("Resposta do Sistema à Entrada Degrau Letra B");
grid on

%%Letra C
L=place(A',C',p1)'
Ae = A-L*C;

AA = [A  -B*K; L*C  Ae-B*K];
BB = [0;-1;0;-1];
CC = [0 0 0 0];
DD= 0;

MF = ss(AA,BB,CC,DD);
X0=[0;0;0;0];
[Y,T,X] = lsim(MF,u,t,X0);

figure
plot(T,X(:,1)/X(length(t),1),'b')
legend("Theta 1")
xlabel("Tempo [s]");
title("Resposta do Sistema à Entrada Degrau Letra C");
grid on

%%Letra D
A=[0 1 0; 0 0 1; 0 2 -1];
B=[0;0;-1];
C=[0 1 0];
D=0;
p2=[-1 -5+5i -5-5i];
K=place(A,B,p2)

G=ss(A-B*K,B,C,D);

t=linspace(0,7,1000);
u=ones(1, length(t));
X0=[0;0;0];
[Y,T,X]=lsim(G,u,t,X0);

figure
plot(T,-1*X(:,1),'r')
hold on
plot(T,-1*X(:,2),'b')
plot(T,-1*X(:,3),'g')
legend("Integral de Theta 1","Theta 1","Ômega 1")
xlabel("Tempo [s]");
title("Resposta do Sistema à Entrada Degrau Letra D/E");
grid on

%%Letra F
p3=[-1 -5+5i -5-5i];
for k=[5 4 3 2 1]
    A=[0 1 0; 2 -1 1/2; -2 1 -(1+1/k)/2];
    B=[0; -1; 1-1/k];
    K=place(A,B,p3)
end

G=ss(A-B*K,B,C,D);

t=linspace(0,7,1000);
u=ones(1, length(t));
X0=[0;0;0];
[Y,T,X]=lsim(G,u,t,X0);

figure
plot(T,-1*X(:,1),'b')
hold on
plot(T,-1*X(:,2),'r')
plot(T,-1*X(:,3),'g')
legend("Theta 1","Ômega 1","Ômega 2")
xlabel("Tempo [s]");
title("Resposta do Sistema à Entrada Degrau Letra F");
grid on
