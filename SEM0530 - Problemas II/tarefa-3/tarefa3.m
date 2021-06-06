# tarefa3.m
clear all;
close all;

% Matriz de Rigidez do Sistema

k = rigidez();

% Caso 1: Forcas Aplicadas Simultaneamentes

u1 = caso1(k)
u1tot = sum(u1)

% Caso 2: Deslocamento na Extremidade Livre

u2 = caso2(k)
u2tot = sum(u2)

% Graficos

n = 1:10;

figure
plot(n, diag(k), 'm');
xlabel('Mola');
xlim([1 10]);
ylabel('Rigidez da Mola (N/m)');
title('Variacao do coeficiente k');

figure
subplot(1,2,1, 'align');
    plot(u1, n);
    xlabel('Deslocamento (m)');
    ylabel('Mola');
    ylim([1 10]);
    title('Caso 1: Forcas Aplicadas');
subplot(1,2,2, 'align');
    plot(u2, n, 'r');
    xlabel('Deslocamento (m)');
    ylabel('Mola');
    ylim([1 10]);
    title ('Caso 2: Deslocamento na Extremidade');
