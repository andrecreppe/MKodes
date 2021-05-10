# rigidez.m
function res = rigidez(u)
  % Dados do enunciado
  g = 9.81;
  m = 180 + 72; % 118029(72)
  
  res = (g .* m) ./ u;
end
