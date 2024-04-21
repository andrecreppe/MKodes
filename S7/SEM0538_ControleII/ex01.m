clear all
close all

A = [-2 1;-2 0];
B = [1;3];
C = [1 0];
D = 0;

%Controlador
wn = 18;
zeta = 0.6;
p=roots([1 2*wn*zeta wn*wn]);
K = acker(A,B,p);
Ac = A-B*K;

G=ss(Ac,B,C,D);

t=linspace(0,5,1000);
u=[ones(1, length(t))];
X0=[0,0];
[Y,T,X]=lsim(G,u,t,X0);

figure
plot(T, X(:,1)/X(length(t),1),'b')
hold on
plot(T,X(:,2)/X(length(t),1),'r')
legend("Estado 1","Estado 2")
xlabel("Tempo [s]");
title("Resposta do Sistema à Entrada Degrau");
grid on

figure
plot(T,X(:,1)/X(length(t),1),'b')
legend("Estado 1")
xlabel("Tempo [s]");
title("Resposta do Estado 1 à Entrada Degrau");
grid on
