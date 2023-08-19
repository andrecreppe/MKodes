# rigidez.m
function [k, K] = rigidez()
  % Dados do problema
  dk = (50 + 0.5 .* 72); % 118029(72)
  kmin = 10000.;
  b = 0.2;

  % Calculo da Rigidez
  k = zeros(1, 10);
  for i = 1:10
    k(1,i) = kmin + (dk .* power(exp(1), -b .* i)) .* 1000;
  end
  
  %k = [1 2 3 4 5 6 7 8 9 10];
  
  K = zeros(10, 10);
  for i = 1:10
    K(i,i) = k(1, i);
    
    if(i != 10)
      K(i,i) += k(1, i+1);
    end
    
    if(i-1 > 0)
      K(i-1, i) = -k(1, i);
    end
    
    if(i+1 < 11)
      K(i+1, i) = -k(1, i+1);
    end
  end
end
