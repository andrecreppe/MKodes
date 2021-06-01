function [L,U] = luDecomp(A)
  % A: matriz quadrada
  % L, U: matrizes triang. inf. e sup., respectivamente
  n = size(A,1);
  L = eye(n); U = zeros(n);
  
  for k=1:n
    for j=k:n
      U(k,j) = A(k,j) - L(k,1:k-1) * U(1:k-1,j);
    end
    
    for i=k+1:n
      L(i,k) = (A(i,k) - L(i,1:k-1)*U(1:k-1,k))/U(k,k);
    end
end
