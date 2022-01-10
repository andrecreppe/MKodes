% desafio2.m
% ======= INICIALIZACAO =======

close all
clear all
clc
pkg load statistics

% Controle
n = 10000;
canPlot = true;

% ======= ENUNCIADO =======

u = [100; 100];
sA = [125 150; 150 425]; % Software Antigo
sN = [200 300; 300 500]; % Software Novo

% ======= CALCULOS =======

ic = tinv(0.975, n-1); % Parametro do intervalo de confianca para o erro

% Software Antigo
x = normrnd(u(1), sA(1,1)^0.5, n, 1);
y = normrnd(u(2)+ sA(2,1)*(x-u(1))/sA(1,1), ones(n,1)*(sA(2,2)-sA(2,1)*sA(1,2)/sA(1,1))^0.5, n, 1);
SA_RES = [x y];

A = inpolygon(SA_RES(:,1), SA_RES(:,2), [102 108 128 121],[115 107 137 146]);
pA = mean(A) * 100;
dA = std(A) * 100;
dpA = dA/n ^ .5;
eA = dpA * ic;

% Software Novo
x = normrnd(u(1), sN(1,1)^0.5, n, 1);
y = normrnd(u(2)+ sN(2,1)*(x-u(1))/sN(1,1), ones(n,1)*(sN(2,2)-sN(2,1)*sN(1,2)/sN(1,1))^0.5, n, 1);
SN_RES = [x y];

B = inpolygon(SN_RES(:,1),SN_RES(:,2),[102 108 128 121],[115 107 137 146]);
pN = mean(B) * 100;
dN = std(B) * 100;
dpN = dN/n ^ .5;
eN = dpN * ic;

% ======= RESULTADOS =======

printf('========== DADOS ==========\n')
printf('Quantidade de Testes:\n'); n

printf('\n========== SOFTWARE ANTIGO ==========\n')
printf('Estimador da Proporcao:\n'); pA
printf('Estimador do Desvio Padrao da Proporcao:\n'); dA
printf('Desvio Padrao do Estimador da Proporcao:\n'); dpA
printf('Erro para um Intervalo de Confianca de 95%%:\n'); eA

printf('\n========== SOFTWARE NOVO ==========\n')
printf('Estimador da Proporcao:\n'); pN
printf('Estimador do Desvio Padrao da Proporcaoo:\n'); dN
printf('Desvio Padrao do Estimador da Proporcao:\n'); dpN
printf('Erro para um Intervalo de Confianca de 95%%:\n'); eN

% ======= GRAFICOS =======

if canPlot
  figure 
  hold on
  scatter(SA_RES(:,1),SA_RES(:,2),'.','markeredgecolor','r')
  axis([0 200 0 200])
  plot([102 108 128 121 102],[115 107 137 146 115],'linewidth',3,'b')
  grid on
  xlabel('Pos X'); ylabel('Pos Y')
  title('Arremessos - Software Antigo')
  hold off
  
  figure 
  hold on
  scatter(SN_RES(:,1),SN_RES(:,2),'.','markeredgecolor','b')
  axis([0 200 0 200])
  plot([102 108 128 121 102],[115 107 137 146 115],'linewidth',3,'r')
  grid on
  xlabel('Pos X'); ylabel('Pos Y')
  title('Arremessos - Software Novo')
  hold off
end
