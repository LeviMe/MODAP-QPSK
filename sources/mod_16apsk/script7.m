


%entropie sans canal.





clear all;

Nbits=64800;
Rate = 2/3;
Iteration = 50;
 % QPSK = 1, 8PSK = 2, 16APSK = 3
Te=8;
N=10;
Ts=N*Te;
alpha=0.2; % plus tard 0.25 et 0.35

codage_active=1;

 %*Rate

 %BER sera une matrice qui contiendra les taux d'erreurs binaires des trois
 %modulations, chacune répartie sur une ligne différente. A une colonne
 %fixé se trouve un SNR fixé.

 Type=["QPSK", "8PSK", "16APSK"];
 type_plage=2:2;
 SNR_plage=1:1:20;
 trials=6;
 BerTrialTab=zeros(size(type_plage,1),size(SNR_plage,1),trials);
 capaciteTrialTab=zeros(size(type_plage,1),size(SNR_plage,1),trials);


 BerTab=zeros(size(type_plage,1),size(SNR_plage,1));
 capaciteTab=zeros(size(type_plage,1),size(SNR_plage,1));

for indexType=type_plage
    indexSNR=0;

    for SNR=SNR_plage
        indexSNR=indexSNR+1;

         for indexTrial=1:trials
            Ordre_Modulation=2^(indexType+1);
            bits = randi([0 1],  Nbits*Rate,1);
            symboles=modulation(bits,indexType,Rate);
            symboles_bruite=canal( SNR,symboles,1, 1);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


             const=unique(symboles);
             sigma = sqrt(1 / (2 * 10^(SNR/10) ));
             HXsY=entropie_cond(symboles_bruite,symboles,const,sigma);

             capaciteTab(indexType,indexSNR)=log2(Ordre_Modulation)-HXsY;

           % scatterplot(symboles_recus);
         end

         capaciteTrialTab(indexType,indexSNR,indexTrial)=capaciteTab(indexType,indexSNR);
    end

    capaciteAvgTab= mean(capaciteTrialTab,3);


    figure();
    plot( SNR_plage,capaciteAvgTab(indexType,:));
    xlabel("SNR (dB)");
    title("Capacite pour une modulation "+Type(indexType));
end
