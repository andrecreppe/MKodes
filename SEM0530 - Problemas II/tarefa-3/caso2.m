# caso2.m
function u = caso2(k)
  Fel = k(10,10) .* 0.03; 
  F = (Fel + zeros(10, 1));

  u = (k\F);
end
