clear all
close all

A = [-1 -2 -2; 0 -1 1; 1 0 -1];
B = [2;0;1];
C = [1 0 0];
D = 0;

%Controlador
p=[-1 -1+i -1-i];
K = acker(A,B,p)
Ac = A-B*K;

G=ss(Ac,B,C,D);

t=linspace(0,10,1000);
u=[ones(1, length(t))];
X0=[0,0,0];
[Y,T,X]=lsim(G,u,t,X0);

for i=1:length(t)
   c(i)=-K*X(i,:)';
end

figure
plot(T, X(:,1),'b')
hold on
plot(T, X(:,2),'r')
plot(T,X(:,3),'g')
legend("Estado 1","Estado 2","Estado 3")
xlabel("Tempo [s]");
title("Resposta do Sistema à Entrada Degrau");
grid on

figure
plot(T,-1*X(:,1),'b')
legend("Estado 1 Reescalado")
xlabel("Tempo [s]");
title("Resposta do Estado 1 à Entrada Degrau");
grid on

figure
plot(T,-1*X(:,1),'b')
legend("Estado 1 Reescalado")
xlabel("Tempo [s]");
title("Resposta do Estado 1 à Entrada Degrau - Gráfico Ampliado");
grid on
