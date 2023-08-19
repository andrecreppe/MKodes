# projeto.m
close all
clear all

% Funcionamento do mecanismo: 0 -> 90 graus
t = 0 : 0.001 : 3;

theta1 = 1.0953;
theta = (pi./6) .* t;

% Funcoes de movimento
f = 2.3911 - (1.8098 .* cos(theta1 + theta));

x = sqrt(f);

v = x ./ (3.6196 .* sin(theta1 + theta));

anum1 = 0.9049 .* power(sin(theta1 + theta), 2) .* v;
anum2 = cos(theta1 + theta) .* v;
aden = 3.6196 .* power(sin(theta1 + theta), 2) .* sqrt(f);
a = (anum1 - anum2) ./ aden;

% Graficos
figure
plot(t, (theta + theta1), 'g');
title('Variacao do Angulo do pistao');
xlabel('Tempo (s)');
ylabel('Angulo (rad)');

figure
plot(t, x, 'r');
title('Variacao da Extensao do Pistao');
xlabel('Tempo (s)');
ylabel('Deslocamento (ft)');

figure
plot(t, v, 'b');
title('Variacao da Velocidade Angular');
xlabel('Tempo (s)');
ylabel('Velocidade angular (rad/s)');

figure
plot(t, a, 'm');
title('Variacao da Aceleracao Angular');
xlabel('Tempo (s)');
ylabel('Aceleracao angular (rad/s^2)');
