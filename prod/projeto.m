% Limpeza
close all
clear all

% Tamanho do grafo
col = 5.;
lin = 4.;

% Opera��es
[n, m, C, coord] = geragrafo(col, lin);
[q] = distfluid(m, n, C);
  
% Gr�fico 1 = Grafo com gradiente nos n�s
if(1)
  figure
  % N�s
  scatter(coord(:,1), coord(:,2), 600, q, "filled"); 
  title("Grafo com gradiente nos n�s");
  xlabel("Colunas");
  ylabel("Linhas");
  hold on
  
  % Arestas
  for i=1:m
    xaux=[coord(C(i,1),1) coord(C(i,2),1)];
    yaux=[coord(C(i,1),2) coord(C(i,2),2)];
    plot(xaux, yaux, "k-", "linewidth", 2);
  end
  set(gca,'XTick',[], 'YTick', []);
  hold off
end
 
% Gr�fico 2 = Gradiente 3D
if(1)
  figure
  [xx yy] = meshgrid((1:col)-1,(1:lin)-1);
  matq = reshape(q, col, lin)';
  surf(xx,yy,matq);
  
  title("Gradiente da press�o no sistema");
  xlabel("Colunas");
  ylabel("Linhas");
  zlabel("Press�o");
  set(gca,'XTick',[], 'YTick', []);
end

% Histograma e probabilidade do limite
if(1)
  qtd = 10000;
  data = zeros(1, qtd);
  count = 0.;
  
  for i=1:qtd
    [q] = distfluid(m, n, C);
    data(i) = min(q);
    
    if data(i) < -40
      count += 1.;
    end
  end
  
  prob = (count*100.) ./ qtd
  
  figure
  hist(data);
  title("Histograma das press�es m�nimas");
  xlabel("Press�es M�nimas");
  ylabel("Recorr�ncia");
end
