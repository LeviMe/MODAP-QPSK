function msgDecode = decodage(Rate, Iteration, Signal_Demod,type)

if (type == 1)
    nbColumns = 2;
elseif (type == 2)
    nbColumns = 3;
elseif (type == 3)
    nbColumns = 4;
end


bits_desentrelaces = reshape(reshape(Signal_Demod,nbColumns,[])',[],1);
%bits_decode = reshape(Signal_Demod',[],1);
H = dvbs2ldpc(Rate);
dec = comm.LDPCDecoder(H, 'FinalParityChecksOutputPort', true, 'MaximumIterationCount', Iteration, ...
                       'DecisionMethod','Hard decision', 'OutputValue','Information part') ;
msgDecode = dec(bits_desentrelaces);
                   