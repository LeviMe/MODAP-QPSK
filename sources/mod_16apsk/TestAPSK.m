clear

Rate = 2/3;
Nbits = 64800;

bits = randi([0 1], Nbits,1);
symboles=modulation(bits,1,Rate);


llr_bits_recus=demodulation(symboles,1,Rate);

bits_recus = llr_bits_recus<0;

[bits_recus,bits];
isequal(bits,bits_recus)