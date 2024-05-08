clear all, close all
clc

set(0,'defaulttextfontsize', 14, 'defaultaxesfontsize', 14)
 
%% Sistema

% Parametros do Modelo
m = 1180; % kg
c = 4e3;  % Ns/m
k = 90e3; % N/m

% Propriedades dinamicas
wn = sqrt(k/m);
xi = c/2/sqrt(k*m);
wd = wn*sqrt(1-xi^2);

%% 3.1) Pista - Lombada

ti = [0:1e-3:5]';
u0 = 0; % m >> desloc. inicial
v0 = 0; % m*s >> veloc. inicial

z0 = 8e-2; % m >> altura lombada
W = 2; % rad/s >> frequencia de passagem

[to,zo]=ode45(@(t,x)sistpista(t,x,m,c,k,z0,W,1),ti,[u0;v0]);

uo=zo(:,1);
vo=zo(:,2);
zo=z0*sin(W*to); zop=z0*W*cos(W*to); id=find(to>pi/W); zo(id)=0; zop(id)=0;

figure
subplot(311)
plot(to,uo*1e3,'r-'), title('Resp. Numerica - Lombada'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on
subplot(312)
plot(to,vo*1e3,'b'),
xlabel('Tempo (s)'), ylabel('Velocidade (mm/s)'), grid on
subplot(313),
plot(to,k*(uo-zo)+c*(vo-zop),'m'),
xlabel('Tempo (s)'), ylabel('Força (N)'), grid on

%% 3.2) Pista - Valeta

z0 = 5e-2; % m >> profundidade valeta
W = 2; % rad/s >> frequencia de passagem

[to,zo]=ode45(@(t,x)sistpista(t,x,m,c,k,z0,W,2),ti,[u0;v0]);

uo=zo(:,1);
vo=zo(:,2);
zo=z0*sin(W*to); zop=z0*W*cos(W*to); id=find(to>pi/W); zo(id)=0; zop(id)=0;

figure
subplot(311)
plot(to,uo*1e3,'r-'), title('Resp. Numerica - Valeta'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on
subplot(312)
plot(to,vo*1e3,'b'),
xlabel('Tempo (s)'), ylabel('Velocidade (mm/s)'), grid on
subplot(313),
plot(to,k*(uo-zo)+c*(vo-zop),'m'),
xlabel('Tempo (s)'), ylabel('Força (N)'), grid on

%% 3.3) Pista - Lombofaixa

ti = [0:1e-3:6]';
z0 = 15e-2; % m >> altura lombofaixa valeta
W = 2; % rad/s >> frequencia de passagem

[to,zo]=ode45(@(t,x)sistpista(t,x,m,c,k,z0,W,3),ti,[u0;v0]);

uo=zo(:,1);
vo=zo(:,2);
zo=z0*sin(W*to); zop=z0*W*cos(W*to); id=find(to>pi/W); zo(id)=0; zop(id)=0;

figure
subplot(311)
plot(to,uo*1e3,'r-'), title('Resp. Numerica - Lombofaixa'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on
subplot(312)
plot(to,vo*1e3,'b'),
xlabel('Tempo (s)'), ylabel('Velocidade (mm/s)'), grid on
subplot(313),
plot(to,k*(uo-zo)+c*(vo-zop),'m'),
xlabel('Tempo (s)'), ylabel('Força (N)'), grid on
