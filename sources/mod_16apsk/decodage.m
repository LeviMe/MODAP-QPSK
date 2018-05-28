function msgDecode = decodage(Rate, Iteration, Signal_Demod)


H = dvbs2ldpc(Rate);
dec = comm.LDPCDecoder(H, 'FinalParityChecksOutputPort', true, 'MaximumIterationCount', Iteration, ...
                       'DecisionMethod','Hard decision', 'OutputValue','Information part') ;
msgDecode = dec(Signal_Demod);
                   