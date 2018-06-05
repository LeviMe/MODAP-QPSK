

clear all;
figure()
for M=[4,8,16]
    capaTab=[];
    for SNR=2:40
        nbsymb=10000;
        indice=randi([0,M-1],nbsymb,1);
        symboles=exp(2*pi*1j*indice/M);

        Eb_N0=10^(SNR/10);
        sigma_n=sqrt(1/(2*Eb_N0/10));
               
        symboles_bruite=symboles+sigma_n*(randn(nbsymb,1)+1j*randn(nbsymb,1));
        %scatterplot(symboles_bruite);

        ent=[];
        const=unique(symboles);
         for k=1:nbsymb
             res=exp(-abs(symboles_bruite(k)-symboles(k))^2/(2*sigma_n^2));
             res=res/sum(exp(-abs(symboles_bruite(k)-const).^2/(2*sigma_n^2)));
             res=log2(res);
             ent=[ent res];
         end
        %[mean(ent) entropie_cond(symboles,symboles_bruite,const,sigma_n)]
        capa=log2(M)+mean(ent);%mean(ent);
        capaTab=[capaTab capa];

    end

plot(capaTab)
hold on;

end
