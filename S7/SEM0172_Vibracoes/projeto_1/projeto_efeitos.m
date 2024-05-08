clear all, close all
clc

set(0,'defaulttextfontsize', 14, 'defaultaxesfontsize', 14)
 
%% Sistema

% Parametros do Modelo
m = 1180; % kg
%c = 4e3;  % Ns/m
c = [2e3 4e3 8e3];
k = 90e3; % N/m
%k = [45e3 90e3 180e3]; 

% Propriedades dinamicas
wn = sqrt(k./m)
xi = c./2./sqrt(k.*m)
wd = wn.*sqrt(1-xi.^2)

%% Resposta Impulsiva

I = 100; % N >> impulso

u0 = 0;   % m
v0 = I./m; % m/s 

ti = [0:1e-4:3]';
u = (I./(m.*wd)).*exp(-xi.*wn.*ti).*sin(wd.*ti);

figure
plot(ti, u*1e3)
%title('Resposta ao Impulso - Variando k')
title('Resposta ao Impulso - Variando c')
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on
%legend('k/2', 'k', '2k')
legend('c/2', 'c', '2c')

%% Pista - Lombada

ti = [0:1e-3:5]';
u0 = 0; % m >> desloc. inicial
v0 = 0; % m*s >> veloc. inicial

z0 = 8e-2; % m >> altura lombada
W = 2; % rad/s >> frequencia de passagem

[to1,zo1]=ode45(@(t,x)sistpista(t,x,m,c(1),k(1),z0,W,1),ti,[u0;v0]);
[to2,zo2]=ode45(@(t,x)sistpista(t,x,m,c(2),k(1),z0,W,1),ti,[u0;v0]);
[to3,zo3]=ode45(@(t,x)sistpista(t,x,m,c(3),k(1),z0,W,1),ti,[u0;v0]);

uo1=zo1(:,1);
vo1=zo1(:,2);
zo1=z0*sin(W*to1); zop1=z0*W*cos(W*to1); id1=find(to1>pi/W); zo1(id1)=0; zop1(id1)=0;

uo2=zo2(:,1);
vo2=zo2(:,2);
zo2=z0*sin(W*to1); zop2=z0*W*cos(W*to1); id2=find(to1>pi/W); zo2(id2)=0; zop2(id2)=0;

uo3=zo3(:,1);
vo3=zo3(:,2);
zo3=z0*sin(W*to1); zop3=z0*W*cos(W*to1); id3=find(to1>pi/W); zo3(id1)=0; zop3(id1)=0;

uo = [uo1 uo2 uo3];
vo = [vo1 vo2 vo3];
zo = [zo1 zo2 zo3];
zop = [zop1 zop2 zop3];

figure
subplot(311)
%plot(to1,uo*1e3), title('Resp. Lombada - Variando k')
plot(to1,uo*1e3), title('Resp. Lombada - Variando c')
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on
%legend('k/2', 'k', '2k')
legend('c/2', 'c', '2c')
subplot(312)
plot(to1,vo*1e3),
xlabel('Tempo (s)'), ylabel('Velocidade (mm/s)'), grid on
subplot(313),
plot(to1,k.*(uo-zo)+c.*(vo-zop)),
xlabel('Tempo (s)'), ylabel('Força (N)'), grid on
