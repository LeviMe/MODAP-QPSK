



bits=logical(randi([0 1], 64800, 1));
R= 2/3 ;  
H = dvbs2ldpc(R) ;  
enc = comm.LDPCEncoder('ParityCheckMatrix',H) ;   
dec = comm.LDPCDecoder(H) ;

step(enc,bits)