% eqmp2D.m
function r = eqmp2D(Pdiff)
    global data
    
    % Erro Quadratico Medio de Predicao - 2D
    diff = reshape(Pdiff, 1, 17, 1);
    r = sum((data - diff) .^2) ./ 17;
end
