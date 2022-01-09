% simulador.m
% ======= INICIALIZACAO =======

close all
clear all
clc
pkg load control
pkg load statistics

makePlot = false;

% ======= PROGRAMA DO ENUNCIADO =======

% Parametros do Motor.
Rm = .98;
Km = .0274;
Ke = .0297;
Kd = 7.2e-5;
J = 5e-4; %foi alterado
L = 2.5e-5;
Fc = .0593;

Ac = [-Rm/L -Ke/L; Km/J -Kd/J];
Bc = [1/L; 0];
Mc = [0; -Fc/J];
Cc = zeros(2,2);
Dc = zeros(1,1);

% Construindo os modelos no formato que o Octave requer:
sysc = ss(Ac,Bc,Cc,Dc);
syscM = ss(Ac,Mc,Cc,Dc);
%disp('Veja o que o Octave entende como modelo:')
%sysc

% Convertendo para tempo discreto:
delT = 1e-6; %periodo amostral
sysd = c2d(sysc,delT);
sysdM = c2d(syscM,delT);

% Extraindo as matrizes A,B
Par = ss(sysd);
Ad = Par.a;
Bd = Par.b;
Par = ss(sysdM);
Md = Par.b;

% Simular agora e facil:
x(:,1) = [0; 0];
t=0: delT: .00001;
uinfty = 50 * ones(size(t,2),1);

% Grafico de corrente x tempo:
if makePlot
  plot(t,x(1,:))
  title('Corrente x tempo - Motor DC')
  xlabel('tempo[s]')
  ylabel('corrente[A]')
end

% ======= ANALISE DO PROBLEMA =======

n = [1e2 1e3 1e4];
n2 = 1e1;
boxdata = zeros(3, n2);

for i = 1:length(n)
  estim = zeros(1,n(i));
  esper = zeros(1,n2);

  for a = 1:n2 % For do valor esperado
    for j = 1:n(i) % For da estimativa
      for k = 1:size(t,2)-1
        x(:, k+1) = Ad*x(:, k) + Bd*uinfty(k) + Md*sign(x(1, k)) + 2*[1 0; 0 1]*rand(2, 1);
      end
      
      L = 50*delT*inv(x(1,2)-x(1,1));
      estim(1, j) = L;
    end
    
    Lmed = mean(estim);
    esper(1,a) = Lmed;
    
    if a == 1
      printf('Media da estimativa de L_%d\n', n(i))
      printf('- Lmed_%d = %d\n', n(i), Lmed)
    end
  end

  printf('\nEsperanca de L_%d\n', n(i))
  printf('- u_%d = %d\n', n(i), mean(esper))
  boxdata(i,:) = esper;

  printf('\nDesvio Padrao de E(L_%d)\n', n(i))
  printf('- DP_%d = %d\n', n(i), std(esper))
  
  printf('=====================\n')
end

axis([0,3]);
boxplot({boxdata(1,:), boxdata(2,:), boxdata(3,:)});
title("Boxplot das Medias Esperadas");
