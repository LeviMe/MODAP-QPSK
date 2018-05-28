function codeword = codage(Rate, Data) 
 
H = dvbs2ldpc(Rate);
enc = comm.LDPCEncoder(H) ;   
codeword = enc(Data);

%N = 64800;
%R= 3/5 ; 
%bits=logical(randi([0 1], NBits*Rate, 1));


   