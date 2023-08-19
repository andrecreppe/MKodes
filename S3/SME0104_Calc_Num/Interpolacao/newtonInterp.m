function y = newtonInterp(xi,yi,x)
  % xi, yi, x: vetor linha ou coluna
  [m,n]= size(x);
  if (n == 1) 
    xi = xi';
    yi = yi';
    n = m;
  end
  
  n = length(xi); 
  ni = length(x); 
  N = ones(n,ni);
  
  D=zeros(n); 
  D(:,1) = yi';

  for j=1:n-1 % tabela de diferencas divididas
    for i=1:n-j
      D(i,j+1) = (D(i+1,j)-D(i,j))/(xi(i+j)-xi(i));
    end
  end
  
  for i=2:n % forma de Newton
    N(i,:) = N(i-1,:).*(x-xi(i-1));
  end

  y = D(1,:)*N;
end
