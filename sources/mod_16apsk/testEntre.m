clear all 
codeword=randi([0,9],9,1);


sig = reshape(codeword,[],3);

bits_decode = reshape(sig',[],1);