

function [res] = modulation(bits,type)


    
    rate=2/3;
    gamma=gamma_dvbs2(rate);

    if (type==1)
        modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 4); 
       % modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 4,'PhaseOffset',-pi/4,...
       % 'SymbolMapping','Custom','CustomSymbolMapping',[ 1,0,2,3] );
        %constellation(modObj);


    end
    if (type==2)
        modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 8,'PhaseOffset',pi/8); 
      %  modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 8,'PhaseOffset',-pi/4,...
       % 'SymbolMapping','Custom','CustomSymbolMapping',[ 6,1,0,4,5,2,3,7] );
        %constellation(modObj);

    end
    if (type==1 || type==2)
        res=step(modObj,bits)';
    end

    if (type==3) 
        res=mod_16apsk(bits,gamma);
    end


end


