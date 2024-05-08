% Dinamica de um sistema massa-mola-amortecedor
clear all, close all, clc,
set(0,'defaulttextfontsize',14,'defaultaxesfontsize',14)

%Parametros do modelo
m=1180; %kg
c=4e3; %Ns/m
k=90e3; %N/m

%% Propriedades dinamicas

disp('- - -')
disp('Propriedades dinamicas:')
wn=sqrt(k/m); 
disp(sprintf('Freq.Natural = %.2f rad/s (%.2f Hz)',wn,wn/2/pi))
xi=c/2/sqrt(k*m);
disp(sprintf('Fator Amort. = %.2f (%%)',xi*100))
wd=wn*sqrt(1-xi^2);
disp(sprintf('Freq.Natural Amort. = %.2f rad/s (%.2f Hz)',wd,wd/2/pi))

disp('- - -')
disp('Resposta Livre')
disp('+ Analitica: u=exp(-xi*wn*ti).*(u0*cos(wd*ti)+(v0+xi*wn*u0)/wd*sin(wd*ti));')
disp('+ Numerica: [to,zo]=ode45(@(t,x)ode_mma(t,x,m,c,k),ti,[u0;v0]); uo=zo(:,1);')
% Resposta livre
u0=0; %desloc. inicial (em m)
v0=0.1; %veloc. inicial (em m/s)

ti=[0:1e-4:2]';
u=exp(-xi*wn*ti).*(u0*cos(wd*ti)+(v0+xi*wn*u0)/wd*sin(wd*ti));
figure('Name','Resposta Livre')
%set(gcf,'position',[1361 71 560 420])
subplot(211)
plot(ti,u*1e3,'k-'), title('Resp. Analitica')
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,

[to,zo]=ode45(@(t,x)ode_mma(t,x,m,c,k),ti,[u0;v0]);
uo=zo(:,1);
subplot(212), 
plot(to,uo*1e3,'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,

pause %%%%%%%%%%%%%%%%%%%

%% Resposta a Forcamento Harmonico

disp('- - -')
disp('Resposta a Forcamento Harmonico')
disp('+ Analitica: U=(p0/k)/sqrt((1-r^2)^2+(2*xi*r)^2); al=atan(2*xi*r/(1-r^2)); u=U*cos(W*ti-al);')
disp('+ Numerica: [to,zo]=ode45(@(t,x)ode_mmafh(t,x,m,c,k,p0,W),ti,[u0;v0]); uo=zo(:,1);')
% Resposta a forcamento harmonico
% p(t) = p0*cos(W*t)
p0=1; %amplit. forca (em N)
W=10; %freq. forca (em rad/s)

ti=[0:1e-4:10]';
u0=0; %desloc. inicial (em m)
v0=0; %veloc. inicial (em m/s)

r=W/wn; %razao de freq.
U=(p0/k)/sqrt((1-r^2)^2+(2*xi*r)^2);
al=atan(2*xi*r/(1-r^2));
u=U*cos(W*ti-al);
figure('Name','Resposta a Forcamento Harmonico (tempo)')
%set(gcf,'position',[800 565 560 420])
subplot(211)
plot(ti,u*1e3,'k-'), title('Resp. Analitica')
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,

[to,zo]=ode45(@(t,x)ode_mmafh(t,x,m,c,k,p0,W),ti,[u0;v0]);
uo=zo(:,1);
subplot(212), 
plot(to,uo*1e3,'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,

figure('Name','Resposta a Forcamento Harmonico (espectro)')
%set(gcf,'position',[1361 565 560 420])
subplot(211),
Wi=[1:1e-3:5*wn]'; ri=Wi/wn;
Ui=(p0/k)./sqrt((1-ri.^2).^2+(2*xi*ri).^2);
plot(ri,1e3*Ui,'k-'),
xlabel('Razao de Freq.'), ylabel('Deslocamento (mm)')
set(gca,'xlim',[0 5],'xtick',[0:1:5]), grid on,

subplot(212),
ali=atan2(2*xi*ri,(1-ri.^2));
plot(ri,180/pi*ali,'k-'),
xlabel('Razao de Freq.'), ylabel('Fase (graus)')
set(gca,'xlim',[0 5],'xtick',[0:1:5],'ylim',[0 180],'ytick',[0:45:180]), grid on,

pause %%%%%%%%%%%%%%%%%%%

%% Resposta a Forcamento Periodico (Onda quadrada)

disp('- - -')
disp('Resposta a Forcamento Periodico (Onda quadrada)')
% Resposta a forcamento periodico
% p(t) = p1*cos(W1*t) + p2*cos(W2*t)
pv=[1;1/3;1/5;1/7;1/9;1/11;1/13]; %amplit. forca (em N)
Wv=wn/6*[1;3;5;7;9;11;13]; %freq. forca (em rad/s)

ti=[0:1e-4:10]';
u0=0; %desloc. inicial (em m)
v0=0; %veloc. inicial (em m/s)

figure('Name','Resposta a Forcamento Periodico')
%set(gcf,'position',[800 71 560 420])
[to,zo]=ode45(@(t,x)ode_mmafmh(t,x,m,c,k,pv,Wv),ti,[u0;v0]);
uo=zo(:,1);
plot(to,uo*1e3,'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,

% Resposta a forcamento qualquer
%z(t) = z0*sin(W*t) para 0<t<pi/W; 0 para t>pi/W
%p(t) = k*z + c*zd = k*z0*sin(W*t) + c*z0*W*cos(W*t) para 0<t<pi/W; 0 para t>pi/W

ti=[0:1e-3:5]';
u0=0; %desloc. inicial (em m)
v0=0; %veloc. inicial (em m/s)
z0=100e-3;
W=2;

pause %%%%%%%%%%%%%%%%%%%

%% Resposta a Forcamento Qualquer

disp('- - -')
disp('Resposta a Forcamento Qualquer')
figure('Name','Resposta a Forcamento Qualquer (Lombada)')
%set(gcf,'position',[1361 71 560 420])
[to,zo]=ode45(@(t,x)ode_mmafq(t,x,m,c,k,z0,W),ti,[u0;v0]);
uo=zo(:,1);
plot(to,uo*1e3,'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,

pause %%%%%%%%%%%%%%%%%%%

%% Deslocamento vs Velocidade vs Força

disp('+ Deslocamento vs Velocidade vs Força')
figure('Name','Resposta a Forcamento Qualquer (Lombada)')
%set(gcf,'position',[1361 71 560 630])
subplot(311)
uo=zo(:,1);
plot(to,uo*1e3,'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on,
subplot(312)
vo=zo(:,2);
plot(to,vo*1e3,'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Velocidade (mm/s)'), grid on,
subplot(313),
zo=z0*sin(W*to); zop=z0*W*cos(W*to); id=find(to>pi/W); zo(id)=0; zop(id)=0;
plot(to,k*(uo-zo)+c*(vo-zop),'k-'), title('Resp. Numerica'),
xlabel('Tempo (s)'), ylabel('Força (N)'), grid on,
