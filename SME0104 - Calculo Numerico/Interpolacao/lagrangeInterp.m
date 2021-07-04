function y = lagrangeInterp(xi,yi,x)
  % xi, yi, x: vetor linha ou coluna
  [m,n]= size (xi);
  if (n == 1) 
    xi = xi'; 
    yi = yi';
    x = x'; 
    n = m;
  endif

  L = ones(n,length(x));

  for i =1:n
    for j =1:n
      if ( i ~= j )
        L(i,:) = L(i,:).*(x-xi(j))/(xi(i)-xi(j));
      end
    end
  end

  y = yi*L;
end
