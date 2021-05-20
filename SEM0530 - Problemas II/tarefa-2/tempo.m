# tempo.m
% Controle e limpeza
close all
clear all

% Dados do enunciado

r = 100;
s = 0:0.1:20;
v0 = (10 + 0.1 .* 72); % 118029(72)

% Equacoes do movimento

v = sqrt((8 .* s) - ((0.02 ./ 3) .* power(s, 3)) + power(v0, 2));

t = 1 ./ v;

% Mostrando os resultados desejados

fprintf('Tempo por área de trapézios\n');
areaT = trapz(s, t);
fprintf('tt = %f s\n', areaT);

fprintf('\nTempo por QUADPACK\n');
areaQ = quad(@tempvel, 0, 20);
fprintf('tq = %f s\n', areaQ);
