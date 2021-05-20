# tempvel.m
% C�pia das equa��es para fazer a chamada utilizando fun��o an�nima (@)
function t = tempvel(s)
  v0 = (10 + 0.1 .* 72); % 118029(72)
  
  v = sqrt((8 .* s) - ((0.02 ./ 3) .* power(s, 3)) + power(v0, 2));
  
  t = 1 ./ v;
end
