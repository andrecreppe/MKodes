# caso2.m
function u = caso2(K)
  Ft = K(10,10) .* 0.03; 
  F = (Ft + zeros(10, 1));
  
  K9 = K(1:10, 1:9);
  
  u = (K9\F);
  u(10, 1) = 0.03;
end
