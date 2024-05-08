function [xd]=sistpista(t,x,m,c,k,z0,W,i)
    % ====== Lombada ======
    if i == 1 
        if t<pi/W 
            pt=k*z0*sin(W*t)+c*z0*W*cos(W*t); 
        else 
            pt=0; 
        end
    % ====== Valeta ======
    elseif i == 2
        if t<pi/W 
            pt=-k*z0*sin(W*t)-c*z0*W*cos(W*t); 
        else 
            pt=0; 
        end
    % ====== Lombofaixa ======
    elseif i == 3
        if t<pi/(2*W) 
            pt=k*z0*sin(W*t)+c*z0*W*cos(W*t);
        elseif t>pi/(2*W) && t<4*(pi/(2*W))
            pt=z0; 
        elseif t>4*(pi/(2*W)) && t<5*(pi/(2*W))
            pt=-k*z0*sin(W*t)-c*z0*W*cos(W*t)+z0;
        else
            pt=0;
        end
    end

    xd=[x(2); -c/m*x(2)-k/m*x(1)+pt/m]; % sistema
end