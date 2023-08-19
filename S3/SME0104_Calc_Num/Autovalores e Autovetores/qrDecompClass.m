% clgs
function [Q,R] = qrDecompClass(A)
  [m,n] = size(A);
  Q = zeros(m,n);
  R = zeros(n,n);
  
  for j=1:n
    V = A(:,j);
    
    for i=1:j-1
      R(i,j) = Q(:,i)'*A(:,j);
      V = V - R(i,j)*Q(:,i);
    end
    
    R(j,j) = norm(V);
    Q(:,j) = V/R(j,j);
  end
end
