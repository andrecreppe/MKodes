% sort3D.m
function r = sort3D(Consts)
    global sbdv
    global option
    
    Res = zeros(sbdv, sbdv, sbdv, 17);
    for a = 1:sbdv
        for b = 1:sbdv
            for c = 1:sbdv
                if option == 2
                    Res(a,b,c,:) = modLOG(Consts(a,b,c).k, Consts(a,b,c).M);
                else
                    Res(a,b,c,:) = modGOMP(Consts(a,b,c).k, Consts(a,b,c).M);
                end
            end
        end
    end
    
    Errs = zeros(sbdv,sbdv,sbdv);
    for a = 1:sbdv
        for b = 1:sbdv
            for c = 1:sbdv
                Errs(a,b,c) = eqmp3D(Res(a,b,c,:));
            end
        end
    end
    
    [M, L] = min(Errs);
    M = reshape(M, sbdv, sbdv);
    L = reshape(L, sbdv, sbdv);
    
    [N, C] = min(M);
    [O, D] = min(N);
    r = [L(C(D), D) C(D) D];
end
