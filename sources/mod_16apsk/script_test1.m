

clear all


bits=randi([0,1],180,1);

symb=modulation(bits,1);
bits_rec=demodulation(symb',1);
%bits_rec=reshape(de2bi(bits_rec),[],1);

%[bits,bits_rec]
 %taux_d_erreur=100*(1-sum((bits_rec==bits))/40)

