function [res] = demodulation(symb,type)

    rate=2/3;
    gamma=gamma_dvbs2(rate);

    if (type==1)
        demodObj=comm.PSKDemodulator('BitInput',true, 'ModulationOrder', 4,'PhaseOffset',-pi/4,...
        'SymbolMapping','Custom','CustomSymbolMapping',[ 1,0,2,3]);
        res=step(demodObj,symb');
    end
    if (type==2)
        demodObj=comm.PSKDemodulator('BitInput',true, 'ModulationOrder', 8,'PhaseOffset',-pi/4,...
        'SymbolMapping','Custom','CustomSymbolMapping',[ 6,1,0,4,5,2,3,7],...
        'DecisionMethod','Log-likelihood ratio','Variance',0.81);
         llr_bits_recus=step(demodObj,symb');
         res=(llr_bits_recus<0);
    end

    if (type==3) 
        res=demod_16apskllr(symb,gamma);
end


end
