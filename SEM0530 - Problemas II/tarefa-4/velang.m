# velang.h
function dthdt = velang(t, th)
  num = (860 - 8.6 .* t).^2;
  den1 = (400 .* sin(th)).^2;
  den2 = (600 - 400 .* cos(th)).^2;
  
  dthdt = sqrt(num ./ (den1 + den2));  
end
