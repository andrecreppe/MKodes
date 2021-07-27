% eqmp3D.m
function r = eqmp3D(Pdiff)
    global data
    
    % Erro Quadratico Medio de Predicao - 3D
    diff = reshape(Pdiff, 1, 17, 1, 1);
    r = sum((data - diff) .^ 2) ./ 17;
end