


%Tester la bonne version de la capacité. Commencer par les exemples le plus simples. Confirmer calcul de la variance. Retirer les calculs de l'entropie conditionnelle qui ne sert à rien.


clear all;

Nbits=64800;
Rate = 2/3;
Iteration = 50;
 % QPSK = 1, 8PSK = 2, 16APSK = 3
Te=8;
N=10;
Ts=N*Te;
alpha=0.2; % plus tard 0.25 et 0.35

codage_active=0;

 %*Rate

 %BER sera une matrice qui contiendra les taux d'erreurs binaires des trois
 %modulations, chacune répartie sur une ligne différente. A une colonne
 %fixé se trouve un SNR fixé.

 Type=["QPSK", "8PSK", "16APSK"];
 type_plage=2:2;
 SNR_plage=1:0.2:20;
 trials=1;
 BerTrialTab=zeros(size(type_plage,1),size(SNR_plage,1),trials);
 capaciteTrialTab=zeros(size(type_plage,1),size(SNR_plage,1),trials);


 BerTab=zeros(size(type_plage,1),size(SNR_plage,1));
 capaciteTab=zeros(size(type_plage,1),size(SNR_plage,1));

for indexType=type_plage
    indexSNR=0;

    for SNR=SNR_plage
        indexSNR=indexSNR+1

         for indexTrial=1:trials
            Ordre_Modulation=2^(indexType+1);
            bits = randi([0 1],  Nbits*Rate,1);

            if (codage_active)
                bits_codes=codage(Rate,bits,indexType)';
                symboles=modulation(bits_codes,indexType,Rate);
            else
                symboles=modulation(bits,indexType,Rate);
            end

            dirac=[1 zeros(1,Te-1)];
            filtre_RCS=rcosdesign(alpha,N,Te,'sqrt');

            suite_diracs=[kron(symboles,[1,zeros(1,Ts-1)]),zeros(1,Nbits*Ts)];
            signal_mis_en_forme=filter(filtre_RCS,1,suite_diracs);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            signal_bruite=canal( SNR,signal_mis_en_forme,1, filtre_RCS);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

             signal_recu = filter(filtre_RCS, 1, signal_bruite);
             offset=Ts;
             prelevement=offset+1:Ts:length(symboles)*(Ts)+offset;

             symboles_recus=signal_recu(prelevement);
             llr_bits_recus=demodulation(symboles_recus,indexType,Rate);
             llr_bits_recus = llr_bits_recus(:);
             if (codage_active)
                 bits_recus=decodage(Rate,Iteration,llr_bits_recus,indexType);
             else
                 bits_recus = llr_bits_recus<0;
             end

             BER_calc=100*(1-sum((bits_recus==bits))/size(bits,1));

             const=unique(symboles);
             sigma = sqrt(1 / (2 * 10^(SNR/10) ));
             HXsY=entropie_cond(symboles,symboles_recus,const,sigma);

             BerTab(indexType,indexSNR)= BER_calc;
             capaciteTab(indexType,indexSNR)=log2(Ordre_Modulation)-HXsY;

           % scatterplot(symboles_recus);
         end
         BerTrialTab(indexType,indexSNR,indexTrial)=BerTab(indexType,indexSNR);
         capaciteTrialTab(indexType,indexSNR,indexTrial)=capaciteTab(indexType,indexSNR);
    end

    BerAvgTab=mean(BerTrialTab,3);
    capaciteAvgTab= mean(capaciteTrialTab,3);

%     figure();
%     plot( SNR_plage,BerAvgTab(indexType,:));
%     xlabel("SNR (dB)");
%     title("BER pour une modulation "+Type(indexType));

    figure();
    plot( SNR_plage,capaciteAvgTab(indexType,:));
    xlabel("SNR (dB)");
    title("Capacite pour une modulation "+Type(indexType));
end
