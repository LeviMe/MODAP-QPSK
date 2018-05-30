function [res] = demodulation(symb,type,rate)

    
    gamma=gamma_dvbs2(rate);

    if (type==1)
        %demodObj=comm.PSKDemodulator('BitOutput',true, 'ModulationOrder',4,'PhaseOffset',pi/4);
        demodObj=comm.PSKDemodulator('BitOutput',true, 'ModulationOrder', 4,'PhaseOffset',-pi/4,...
        'SymbolMapping','Custom','CustomSymbolMapping',[ 1,0,2,3]);
        res1=step(demodObj,symb');
        llr_bits_recus=1-2*res1;
        res=llr_bits_recus;
    end
    if (type==2)
        %demodObj=comm.PSKDemodulator('BitOutput',true, 'ModulationOrder', 8,'PhaseOffset',pi/8,...
        %'DecisionMethod','Log-likelihood ratio','Variance',0.81);

        demodObj=comm.PSKDemodulator('BitOutput',true, 'ModulationOrder', 8,'PhaseOffset',-pi/4,...
        'SymbolMapping','Custom','CustomSymbolMapping',[ 6,1,0,4,5,2,3,7],...
        'DecisionMethod','Log-likelihood ratio','Variance',0.81);
         llr_bits_recus=step(demodObj,symb');
         res=llr_bits_recus;%<0);
    end

    if (type==3) 
        [Constellation, BitMapping ]= DVBS2Constellation('16APSK',gamma);
        Constellation=Constellation(BitMapping+1);
        demodObj = comm.GeneralQAMDemodulator(Constellation, 'BitOutput',true, 'DecisionMethod','Log-likelihood ratio',...
         'Variance',0.81);
        res = step(demodObj,symb');
        %res=demod_16apskllr(symb,gamma);
        %res=reshape(demod_16apskllr(symb,gamma)<0,[],1);
    end


end
