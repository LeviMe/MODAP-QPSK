
%Modulation QPSK. Calcul Exclusif du taux d'erreur.


clear all

Nbits=30;
Te=8;
N=10;
Ts=N*Te;
alpha=0.2; % plus tard 0.25 et 0.35


modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 8,'PhaseOffset',pi/8);
bits = randi([0 1],  Nbits,1);
data=step(modObj,bits)';
demodObj=comm.PSKDemodulator('BitOutput',true, 'ModulationOrder', 8,'PhaseOffset',pi/8,...
    'DecisionMethod','Log-likelihood ratio','Variance',0.81);

dirac=[1 zeros(1,Te-1)];
filtre_RCS=rcosdesign(alpha,N,Te,'sqrt');

suite_diracs=[kron(data,[1,zeros(1,Ts-1)]),zeros(1,Nbits*Ts)];
signal_mis_en_forme=filter(filtre_RCS,1,suite_diracs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

signal_bruite=canal( 11,signal_mis_en_forme,1, filtre_RCS);

%signal_bruite=signal_mis_en_forme;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 signal_recu = filter(filtre_RCS, 1, signal_bruite);
 %Décalage originelle à reprendre après l'introduction du canal
 %offset=Ts+Ts/2;
 %prelevement=offset+Ts+1:Ts:length(data)*(Ts)+offset+1;

 %Décalage adapté à l'absence de canal
 offset=Ts;
 prelevement=offset+1:Ts:length(data)*(Ts)+offset;

 symboles_recus=signal_recu(prelevement)';
 llr_bits_recus=step(demodObj,symboles_recus);
 bits_recus=(llr_bits_recus<0);
 [bits_recus,bits]


 taux_d_erreur=100*(1-sum((bits_recus==bits))/Nbits)

figure();
title("signal recu");
plot(real(signal_recu(1:length(data)*Ts+Ts/2)));
hold on;
plot(prelevement,real(signal_recu(prelevement)),'rx');



symboles_recus;
scatterplot(symboles_recus);
