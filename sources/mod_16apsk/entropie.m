

function res=entropie(M)
    [C, prop]=distribution(M);
    res=-sum(prop.*log2(prop));
end