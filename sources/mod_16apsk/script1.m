Nbits=30
Te=10

%Generer une suite binaire
bits = randi([0 1], 1, Nbits)
%Nsuites = Nsuites + 1;


 dirac=[1]+ [0]*(Te-1)
 suite_diracs_ponderes=kron(bits,dirac)


%Codage Canal
%bits_code = Codage(bits, generator, L, puncture);

%Modulation du signal
[sig_I, sig_Q] = Modulation(bits, alpha, Ts, Te, n_T);

%Passage dans le canal AWGN
%[sig_bI, sig_bQ] = Canal(dB, sig_I, sig_Q); 

%Demodulation du signal
%[sig_bI, sig_bQ] = Demodulation(sig_bI, sig_bQ, alpha, Ts, Te, n_T);



function res=Modulation(bits, alpha, Ts, Te, n_T)
b = rcosdesign(alpha,n_t,n_t*Ts,'sqrt')

res=filter(1,;

end



%
%
%%
comm.Pskmodulator(bit=input, 
bits=randint
data=step(h,bits)