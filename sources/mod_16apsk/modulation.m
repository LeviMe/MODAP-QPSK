

% Les trois constellations associées aux trois modulations correspondent
% exactement à ce qui est demandé dans l'énoncé. 

function [res] = modulation(bits,type,rate)    
    gamma=gamma_dvbs2(rate);

    if (type==1) 
       modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 4,'PhaseOffset',-pi/4,...
        'SymbolMapping','Custom','CustomSymbolMapping',[ 1,0,2,3] );
        %constellation(modObj);


    end
    if (type==2) 
       modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 8,'PhaseOffset',-pi/4,...
        'SymbolMapping','Custom','CustomSymbolMapping',[ 6,1,0,4,5,2,3,7] );
        %constellation(modObj);
    end

    if (type==3) 
        [Constellation, BitMapping ] = DVBS2Constellation('16APSK',gamma);
        Constellation=Constellation(BitMapping+1);
        modObj = comm.GeneralQAMModulator(Constellation);
       
        
    end

    res = step(modObj, bits)';

end


