# rigidez.m
function k = rigidez()
  % Dados do problema
  dk = (50 + 0.5 .* 72); % 118029(72)
  kmin = 10000.;
  b = 0.2;

  % Calculo da Rigidez
  k = zeros(10, 10);
  for i = 1:10
    k(i,i) = kmin + (dk .* power(exp(1), -b .* i)) .* 1000;
  end
end
