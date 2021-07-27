% limits2D.m
function [x,y,z,w] = limits2D(min, Cts)
    global sbdv
    
    if min(1) == 1
        x = Cts(1, min(2)).p0;
        y = Cts(3, min(2)).p0;
    elseif min(1) == sbdv
        x = Cts(sbdv - 2, min(2)).p0;
        y = Cts(sbdv, min(2)).p0;
    else
        x = Cts(min(1) - 1, min(2)).p0;
        y = Cts(min(1) + 1, min(2)).p0;
    end
    
    if min(2) == 1
        z = Cts(min(1), 1).k;
        w = Cts(min(1), 3).k;
    elseif min(2) == sbdv
        z = Cts(min(1), sbdv - 2).k;
        w = Cts(min(1), sbdv).k;
    else
        z = Cts(min(1), min(2) - 1).k;
        w = Cts(min(1), min(2) + 1).k;
    end
end
