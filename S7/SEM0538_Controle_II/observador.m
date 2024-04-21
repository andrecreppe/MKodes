% EESC/USP - SEM 538 - Sistemas de Controle II
% Exemplo Observador - 2018

clear all
%close all
A = [ 0 1; 0 0];
B = [0;1];
C = [1 0];
D = 0;

%Controlador
wn = 1;
zeta = 0.707;
p=roots([1 2*wn*zeta wn*wn]);
K = acker(A,B,p);
Ac = A-B*K;

%Observador
wn2 = 5;
zeta2 = 0.5;
p2=roots([1 2*wn2*zeta2 wn2*wn2]);
L =acker(A',C',p2)';
Ae = A-L*C;

AA = [A  -B*K; L*C  Ae-B*K];
BB = [0;0;0;0];
CC = [0 0 0 0];
DD= 0;

MF = ss(AA,BB,CC,DD);
[Y,T,X] = lsim(MF,zeros(1,101),[0:0.1:10],[1;0;0;0]) ;

figure
plot(T,X(:,1:2),'b',T,X(:,3:4),'r')
