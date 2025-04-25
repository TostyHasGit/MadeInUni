%% aZkylischeFaltung
% (i) Berechnen Sie die Faltung und die zyklische Faltung
% [1, 0, 0, 2] *(z) [1, 2, 3 ] 
% für die Signallängen N=4 und N=8. 
% (ii() Berechnen Sie die zyklische
% Faltung mit MATLAB. 
% (iii) Unter welcher Voraussetzung haben die
% zyklische Faltung und die Faltung das gleiche Ergebnis?
% 
% HSM, B. Wir 3.5.2012, 20.8.12
clear all; close all;
%% (i) Berechnen Sie die Faltung und die Zyklische Faltung
%      ( mit Hilfe der FFT) von 

 x = [1 0 0 2];
 g = [ 1 2 3];
 
 y   = conv(x,g)
 % N = 4;
 y_z4 = ifft (fft(x).* fft([g,0]))
 % N = 8;
 y_z8 = ifft (fft([x, 0, 0, 0, 0    ] ).* ...
              fft([g, 0, 0, 0, 0, 0 ] ) );
 
%% (ii) Unter welcher Voraussetzung haben die Faltung und die zyklische
% Faltung das gleiche Ergebnis?
%
% Antwort: Zero-Padding auf Länge 
% L = N+M-1 mit  N,M Länge von g und x.