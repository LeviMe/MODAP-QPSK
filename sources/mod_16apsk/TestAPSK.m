clear

Nbits=64800;
Rate = 3/4;
Iteration = 50;
Type = 3; % QPSK = 1, 8PSK = 2, 16APSK = 3
Te=8;
N=10;
Ts=N*Te;
alpha=0.2; % plus tard 0.25 et 0.35 

bits = randi([0 1], Nbits*Rate,1);
gamma=gamma_dvbs2(Rate);
bits_codes=codage(Rate,bits,3)';
symboles=modulation(bits_codes,3,Rate);
%symboles = mod_16apsk(bits_codes, gamma);

dirac=[1 zeros(1,Te-1)];
filtre_RCS=rcosdesign(alpha,N,Te,'sqrt');

suite_diracs=[kron(symboles,[1,zeros(1,Ts-1)]),zeros(1,Nbits*Ts)];
signal_mis_en_forme=filter(filtre_RCS,1,suite_diracs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

signal_bruite=canal(1,signal_mis_en_forme,0.81, filtre_RCS);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


signal_recu = filter(filtre_RCS, 1, signal_bruite);

offset=Ts;
prelevement=offset+1:Ts:length(symboles)*(Ts)+offset; 
symboles_recus=signal_recu(prelevement);


llr_bits_recus=demodulation(symboles_recus,3,Rate);
%llr_bits_recus = demod_16apskllr(symboles_recus, gamma);
llr_bits_recus = llr_bits_recus(:);
bits_recus=decodage(Rate,Iteration,llr_bits_recus,3);

[bits_recus,bits];
taux_d_erreur_binaire=100*(1-sum((bits_recus==bits))/size(bits*Rate,1))
isequal(bits,bits_recus)