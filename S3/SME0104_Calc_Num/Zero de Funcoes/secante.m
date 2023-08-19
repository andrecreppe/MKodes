function [x,k] = secante(func,x0,x1,tol,kmax)
  f0 = func(x0);
  
  for k=1:kmax
    f1 = func(x1);
    ds = f1*(x1-x0)/(f1-f0);
    x0 = x1;
    x1 = x1 - ds;
    
    if(abs(ds)<tol)
      x=x1;
      return;
    end
    
    f0=f1;
  end
  
  x = NaN;
end
