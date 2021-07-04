function s = cubicSpline(xi,yi,x)
  [n,m]= size (xi);
  if (n == 1) 
    xi = xi'; 
    yi = yi'; 
    n = m; 
  end

  h = xi(2:end) - xi(1:end-1);
  u = 2*(h(1:end-1)+h(2:end));
  A = spdiags([ [h(2:end-1);0] u [0;h(2:end-1)]],-1:1,n-2,n-2);
  w = 6*(yi(2:end)-yi(1:end-1))./h;
  v = w(2:end)-w(1:end-1);
  z = A\v; z = [0;z;0];

  a = (z(2:end)-z(1:end-1))./(6*h);
  b = z(1:end-1)/2;
  c =-(h/6).*(z(2:end)+2*z(1:end-1))+(yi(2:end)-yi(1:end-1))./h;
  d = yi(1:end-1);

  pp = mkpp (xi,[a b c d]);
  s = ppval(pp ,x);
end
