clear all
% Affichage d'un signal reçue en 8PSK pour décider des valeurs d'échantillonages. 
Nbits=24;
Te=5;
N=10;
Ts=N*Te;
alpha=0.2; % plus tard 0.25 et 0.35

%h = modem.pskmod( 8 );
modObj=comm.PSKModulator('BitInput',true, 'ModulationOrder', 8,'PhaseOffset',pi/8);

%Generer une suite binaire
bits = randi([0 1],  Nbits,1);
%Moduler les donnees numériques
data=step(modObj,bits);

demodObj=comm.PSKDemodulator('BitOutput',true, 'ModulationOrder', 8,'PhaseOffset',pi/8);


dirac=[1 zeros(1,Te-1)];
filtre_RCS=rcosdesign(alpha,N,Te,'sqrt');


data=data';
suite_diracs=[kron(data,[1,zeros(1,Ts-1)]),zeros(1,Nbits*Ts)];
signal_mis_en_forme=filter(filtre_RCS,1,suite_diracs);


figure();
title("signal recu");


 signal_recu = filter(filtre_RCS, 1, signal_mis_en_forme);

 offset=Ts;
 prelevement=offset+1:Ts:length(data)*(Ts)+offset;

 symboles_recus=signal_recu(prelevement);
 symboles_recus= symboles_recus';

 bits_recus=step(demodObj,symboles_recus);
 isequal(bits_recus,bits)
 
plot(real(signal_recu(1:length(data)*Ts+Ts/2)));
hold on;
plot(prelevement,real(signal_recu(prelevement)),'rx');
bar(prelevement,real(signal_recu(prelevement)),0.005);
%constellation(h);
%scatterplot(symboles_recus);
%plot(real(filtre_RCS))
