% limits3D.m
function [x,y,z,w,u,v] = limits3D(min, Cts)
    global sbdv
    
    if min(1) == 1
        x = Cts(1, min(2), min(3)).p0;
        y = Cts(3, min(2), min(3)).p0;
    elseif min(1) == sbdv
        x = Cts(sbdv - 2, min(2), min(3)).p0;
        y = Cts(sbdv, min(2), min(3)).p0;
    else
        x = Cts(min(1) - 1, min(2), min(3)).p0;
        y = Cts(min(1) + 1, min(2), min(3)).p0;
    end
    
    if min(2) == 1
        z = Cts(min(1), 1, min(3)).k;
        w = Cts(min(1), 3, min(3)).k;
    elseif min(2) == sbdv
        z = Cts(min(1), sbdv - 2, min(3)).k;
        w = Cts(min(1), sbdv, min(3)).k;
    else
        z = Cts(min(1), min(2) - 1, min(3)).k;
        w = Cts(min(1), min(2) + 1, min(3)).k;
    end
    
    if min(3) == 1
        u = Cts(min(1), min(2), 1).M;
        v = Cts(min(1), min(2), 3).M;
    elseif min(3) == sbdv
        u = Cts(min(1), min(2), sbdv - 2).M;
        v = Cts(min(1), min(2), sbdv).M;
    else
        u = Cts(min(1), min(2), min(3) - 1).M;
        v = Cts(min(1), min(2), min(3) + 1).M;
    end
end
