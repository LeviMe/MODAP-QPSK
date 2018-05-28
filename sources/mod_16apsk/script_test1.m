



bits=randi([0,1],18,1)


for k = 1:1
   symb=modulation(bits,k)
   
   bits_rec=demodulation(symb,k)
   
end
