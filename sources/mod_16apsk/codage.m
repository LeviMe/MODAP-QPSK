function bits_codes = codage(Rate, Data, type) 
%Data in doit avoir Rate * NBits  bits pour le codage LDPC
%Type est QPSK(1), 8PSK(2) ou 16APSK(3)
%Rate est le LDPC Rate
%L'entrelancement varie selon le type


H = dvbs2ldpc(Rate);
enc = comm.LDPCEncoder(H) ;   
codeword = enc(Data);

if (type == 1)
    nbColumns = 2;
elseif (type == 2)
    nbColumns = 3;
elseif (type == 3)
    nbColumns = 4;
end

bits_codes = reshape(codeword,[],nbColumns);



%N = 64800;
%R= 2/3;
%Data in doit avoir Rate * NBits  bits pour le codage LDPC
%bits=logical(randi([0 1], NBits*Rate, 1));


   