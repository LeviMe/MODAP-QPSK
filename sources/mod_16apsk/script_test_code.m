NBits = 64800;
R= 2/3 ; 
bits=1:9;




bits_codes = reshape(bits,[],3);
%Le reshape fait passer un vecteur ligne ou colonne en empilement par
%lecture sur colonnes puis lignes et non l'inverse. 

%[(1:3); (4:6) ; (7:9)]

bits_decodes = reshape(bits_codes,1,[]);
%Pour décoder correctement il suffit d'un simple reshape comme ce qui 
%précéde que le vecteur de départ soit ligne ou colonne. Il est entendu
%qu'une permutation  des deux paramêtres transforme l'un en l'autre en 
%sortie

%[bits, bits_decode];

reshape_reussi=isequal(bits,bits_decodes);


Rate=2/3;

%%%%%
%%%%%% Procédure d'entrelacement à N colonnes, le nombre de bits doit 
%%%%% être multiple de N. 
N=3;
bits=randi([0,30],1,10*N);
bits_codes=reshape(reshape(bits,[],N)',1,[]);
bits_decodes=reshape(reshape(bits_codes,N,[])',1,[]);


entrelacement_reussi=isequal(bits,bits_decodes);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data=randi([0,1], NBits*R ,1);
cod=codage(2/3, Data, 1);
llr = 1-2*cod;
decode = decodage(R,50,llr,1);
isequal(Data,decode)






