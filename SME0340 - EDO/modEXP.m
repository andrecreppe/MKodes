% modEXP.m
function f = modEXP(k)
    global t
    % Modelo Exponencial
    f = 2 .* exp(k .* t);
end
