function yprime = ex04_2(t, y)
    a11 = -20;
    a12 = 1;
    a13 = 10;
    a21 = -5; 
    a22 = 10;
    a31 = -5;
    a32 = 50;
    a33 = -25;
    
     yprime = [ a11*y(1) + a12*abs(y(2) * y(3)) + a13*y(1)*y(2)*y(3); ... 
        a21*y(1)*y(2) + a22*cos(y(1)) + sqrt(abs(y(3))); ... 
        a31*y(1)*y(2) + a32*cos(y(1))*y(2) + a33*y(3) ];
end