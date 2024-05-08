clear all, close all
clc

set(0,'defaulttextfontsize', 14, 'defaultaxesfontsize', 14)
 
%% Sistema

% Parametros do Modelo
m = 1180; % kg
c = 4e3;  % Ns/m
k = 90e3; % N/m

% Propriedades dinamicas
wn = sqrt(k/m)
xi = c/2/sqrt(k*m)
wd = wn*sqrt(1-xi^2)

%% Resposta Impulsiva

I = 100; % N >> impulso

u0 = 0;   % m
v0 = I/m; % m/s 

ti = [0:1e-4:3]';
u = (I/(m*wd)).*exp(-xi*wn*ti).*sin(wd*ti);

figure
plot(ti, u*1e3, 'r')
title('Resposta ao Impulso')
xlabel('Tempo (s)'), ylabel('Deslocamento (mm)'), grid on

%% Resposta em Frequencia

% Deslocamento

p0 = 100; % N >> ampl. forca

Wi = [1:1e-3:5*wn]'; 
ri = Wi/wn;

UZi = sqrt((1 + (2*xi*ri).^2) ./ ((1 - ri.^2).^2 + (2*xi*ri).^2));
ali = atan2(2*xi*ri,(1-ri.^2));

[UZ_max, I] = max(UZi);
UZ_max
W_max = Wi(I)
r_max = W_max / wn

figure
subplot(211)
plot(ri, UZi, 'b')
title('Resposta em Frequencia')
xlabel('Razao de Freq.'), ylabel('Razao de Transm.'), grid on
subplot(212)
plot(ri, 180/pi*ali, 'm')
xlabel('Razao de Freq.'), ylabel('Fase (graus)'), grid on
set(gca,'xlim',[0 5],'xtick',[0:1:5],'ylim',[0 180],'ytick',[0:45:180])

% Forca Transmitida

Z = 0.010; % m -- amplitude
FTi = m .* Wi.^2 .* Z .* UZi;

FT_max = max(FTi)

figure
plot(ri, FTi, 'b')
title('Resposta em Frequencia')
xlabel('Razao de Freq.'), ylabel('Forca Transm. (N)'), grid on
