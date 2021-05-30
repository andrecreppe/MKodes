function x = eliminacaoGaussPivot(A,b)
  % A: matriz dos coeficientes
  % b: vetor termo independente
  % x: vetor solucao
  n = size(A,1);
  
  for k=1:n-1
    [~,p] = max(abs(A(k:n,k)));
    p = p+(k-1);
    A([k p],k:n) = A([p k],k:n);
    b([k p]) = b([p k]);
    
    for i=k+1:n
      m = -A(i,k)/A(k,k);
      A(i,k:n) = A(i,k:n) + m*A(k,k:n);
      b(i) = b(i) + m*b(k);
    end
  end
end

x = subRegressiva(A,b);
