# suspensao.m
function res = suspensao(u)
  % Dados providos do enunciado do problema
  d = 0.2;
  L = 0.5;
  k = 10000;
  g = 9.81;
  m = 180 + 72; % 118029(72)
  
  % Outros valores importantes que precisam ser calculados
  h = sqrt(power(L, 2) - power(d, 2));
  pit = sqrt(power(d, 2) + power((h-u), 2));
  
  % Quebrando a equação para facilitar leitura
  a = 2 .* k .* (L-pit);
  b = (h-u) ./ pit;
  c = m .* g;
  
  % Juntando de acordo
  res = (a .* b) - c;
end
