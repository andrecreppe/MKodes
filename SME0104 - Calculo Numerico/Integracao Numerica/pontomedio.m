function I = pontomedio(func, a, b, N)
    I = 0;
    h = (a + b)/N;
    
    X = a:h:b;

    for i=2:N
        xm = (X(i) + X(i-1)) / 2;
        I = I + func(xm);
    end
    
    I = I * h;
end
