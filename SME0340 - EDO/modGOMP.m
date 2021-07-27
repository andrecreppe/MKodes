% modGOMP.m
function f = modGOMP(k,M)
    global t
    % Modelo de Gompertz
    up = log(2 ./ M) .* exp(-k .* t);
    f = M .* exp(up);
end