clear all

Nbits=64800;
Rate = 2/3;
Iteration = 50;
Type = 1; % QPSK = 1, 8PSK = 2, 16APSK = 3
Te=8;
N=10;
Ts=N*Te;
alpha=0.2; % plus tard 0.25 et 0.35 

codage_active=1;

 %*Rate
bits = randi([0 1],  Nbits*Rate,1);

if (codage_active)
    bits_codes=codage(Rate,bits,Type)';
    symboles=modulation(bits_codes,Type,Rate);
else
    symboles=modulation(bits,Type,Rate);
end

dirac=[1 zeros(1,Te-1)];
filtre_RCS=rcosdesign(alpha,N,Te,'sqrt');

suite_diracs=[kron(symboles,[1,zeros(1,Ts-1)]),zeros(1,Nbits*Ts)];
signal_mis_en_forme=filter(filtre_RCS,1,suite_diracs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

signal_bruite=canal( 12,signal_mis_en_forme,1, filtre_RCS);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 signal_recu = filter(filtre_RCS, 1, signal_bruite);

 offset=Ts;
 prelevement=offset+1:Ts:length(symboles)*(Ts)+offset; 

 symboles_recus=signal_recu(prelevement);

 llr_bits_recus=demodulation(symboles_recus,Type,Rate);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 llr_bits_recus = llr_bits_recus(:);
 if (codage_active)
     bits_recus=decodage(Rate,Iteration,llr_bits_recus,Type);
 else
     bits_recus = llr_bits_recus<0;
 end
 [bits_recus,bits]

% taux_d_erreur_symbole=100*(1-sum((symboles_recus==symboles))/size(bits,1))
 taux_d_erreur_binaire=100*(1-sum((bits_recus==bits))/size(bits,1))
 
symboles_recus;
scatterplot(symboles_recus);

