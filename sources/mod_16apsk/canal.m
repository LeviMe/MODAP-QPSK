
function [ signalBruite]= canal( dB, signal,sigma_s, shaping_filter)
%CANAL simule l'ajout du bruit lors du passage du signal a travers le canal AWGN
%   Addition du bruit au signal avec le dB specifie

sum_h2=sum(shaping_filter.^2);

%Calcul de la puissance du bruit : sigma_s = 1 (variance des symboles),
%et somme du carre de h... = 1 car on a norme
%Es=2*Eb donc sigma^2 = 1./(4.*Eb/N0)
% et Eb/N0dB = 10log(Eb/N0) d'ou Eb/n0 = 10^(dB/10)
Eb_N0 = 10^(dB/10);
sigma = sum_h2*sigma_s^2 / (2 * 10 ^ (Eb_N0 / 10));
%sigma = sum_h2*sigma_s^2 / (2 * Eb_N0 );
real_signal =real(signal) +     sqrt(sigma) * randn(1, length(signal));
imag_signal= imag(signal) +     sqrt(sigma) * randn(1, length(signal));

signalBruite = real_signal+1j*imag_signal;

end