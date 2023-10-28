function mat = transfMatrix(th, d, al, a)
    costh = cos(sym(th));
    sinth = sin(sym(th));
    cosal = cos(sym(al));
    sinal = sin(sym(al));
    
    mat = [costh -sinth*cosal sinth*sinal a*costh
           sinth costh*cosal -costh*sinal a*sinth
           0 sinal cosal d
           0 0 0 1];
end
