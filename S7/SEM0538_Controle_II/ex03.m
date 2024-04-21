clear all
close all

A = [-10 1 0; -16 0 1; 0 0 0];
B = [0;0;10];
C = [1 0 0];
D = 0;

%Controlador
p=[-1.4 -1+2.15i -1-2.15i];
K = acker(A,B,p);
Ac = A-B*K;

%Observador
p2=[-4.25 -3+6.4i -3-6.4i];
L =acker(A',C',p2)';
Ae = A-L*C;

AA = [A  -B*K; L*C  Ae-B*K];
BB = [0;0;0;0;0;0];
CC = [0 0 0 0 0 0];
DD= 0;

MF = ss(AA,BB,CC,DD);
[Y,T,X] = lsim(MF,zeros(1,1001),[0:0.01:10],[1;0;0;0;0;0]) ;

figure
plot(T,X(:,1),'b')
hold on
plot(T,X(:,2),'r')
plot(T,X(:,3),'g')
legend("Estado 1","Estado 2","Estado 3")
xlabel("Tempo [s]");
title("Resposta do Sistema à Posição Inicial [1 0 0]'");
grid on

figure
plot(T,X(:,1),'b')
hold on
plot(T,X(:,4),'r')
legend("Estado 1","Estimativa 1")
xlabel("Tempo [s]");
title("Resposta do Estado 1 à Posição Inicial [1 0 0]'");
grid on

figure
plot(T,X(:,2),'b')
hold on
plot(T,X(:,5),'r')
legend("Estado 2","Estimativa 2")
xlabel("Tempo [s]");
title("Resposta do Estado 2 à Posição Inicial [1 0 0]'");
grid on

figure
plot(T,X(:,3),'b')
hold on
plot(T,X(:,6),'r')
legend("Estado 3","Estimativa 3")
xlabel("Tempo [s]");
title("Resposta do Estado 3 à Posição Inicial [1 0 0]'");
grid on
