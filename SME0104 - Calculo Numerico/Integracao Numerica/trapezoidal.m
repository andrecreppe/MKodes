function I = trapezoidal(func, a, b, N)
    I = 0;
    h = (a + b)/N;
    
    X = a:h:b;

    for i=1:(N-1)
        I = I + func(X(i));
    end
    
    fsum = func(X(1)) + func(X(end));
    I = (0.5 * h * fsum) + (I * h);
end
