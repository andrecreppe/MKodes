function a = mmq(x,y,k)
  n = length(x);
  X = vander(x);
  X = X(:,n-k:n);
  a = ((X'*X)\(X'*y'))';
end
