function msgDecode = decodage(Rate, Iteration, Signal_Demod)



bits_decode = reshape(Signal_Demod',[],1);
H = dvbs2ldpc(Rate);
dec = comm.LDPCDecoder(H, 'FinalParityChecksOutputPort', true, 'MaximumIterationCount', Iteration, ...
                       'DecisionMethod','Hard decision', 'OutputValue','Information part') ;
msgDecode = dec(bits_decode);
                   