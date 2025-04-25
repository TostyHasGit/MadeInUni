%%  Quantisierung im 1.7 Format (Lösung)
%  Beim 1.7 Festkommaformat (-> 1 Vorkomma und 7 Nachkomma) (Integer) wird der Wertebereich von -1 bis +1 (eigentlich 0,9999999) in
%  (2^{8}-1) gleiche Bereiche unterteilt. Die 8 Bits bedeuten beginnend mit dem MSB 
%  (most significant bit): -1, 2^{-1}, 2^{-2}, ... 2^{-7). 
% 
%  (i)Welche Bit-Folgen codieren die Zahlen 0.5; 0.75; -0.75.
% 
%  (ii)Simulieren Sie die Quantisierung für
%  Zahlen von -1 bis 1-2^{-7}und berechnen Sie den Quantisierungsfehler, 
%  das SNR und das Leistungsdichtespektrum (LDS) des Rauschens (pwelch.m). 
%   ver. 2.0 WIR 19.10.20 Kommentare ergänzt, Leckeffekt korrigiert;
%   ver. 2.1 Kosmetik 
clear all; close all;

%% Lösung zu (i) 

% 0.5   == b# 0.100 0000;           2^{-1}

% 0.75  == b# 0.110 0000;           2^{-1} + 2^{-2}

% -0.75 == b# 1.010 0000;   -1 +           + 2^{-2}


%% Lösung zu (ii) Signalerzeugung
BIT = 8;
delta = 2^(-(BIT-1)) %Quantisierungsstufe bei 1.7 Format
x = [-1:0.00001:(1-delta)]; %  feiner quantisiert als späteres 1.7 Format


%% Quantisierung und Berechnung von Rauschleistung und SNR
x_q = round(x*2^(BIT-1))/2^(BIT-1);
e_q = x - x_q;

rauschleistung = (e_q*e_q')/(length(e_q))
theorie =delta^2/12

SNR_dB = 10*log10((x*x')/(e_q*e_q')) 
%% Darstellung
figure(1);subplot(2,2,[1 3]); plot(x,x); grid on; axis([ -1,1 ,-1, 1]); 
hold on; plot(x,x_q,'r'); plot(x,e_q,'k--'); hold off;
title(['Quantisierung mit ', int2str(BIT),'-Bit']);xlabel('Eingang'); ylabel('Quantisierung und Fehler'); 
legend('Signal', 'Quantisierung','Fehler', 'location','best');

subplot(2,2,2); hist(e_q); title('Amplitudenstatistik des Rauschens e_Q');
xlabel('Wert'); ylabel('Häufigkeit');
window = hamming(1024);
subplot(2,2,4); pwelch(e_q,window); title('LDS(e_Q)');

%% Hinweis für Masterkurs
% ohne Fenster geht die Schätzung nicht, wegen Leckeffekten!! 
% Verstehen wir später 

% subplot(2,2,4); plot(abs(fft(e_q))); title('|FOU(e_Q)|');
% figure(2)
% pwelch(e_q); title('LDS(e_Q) mit Leckeffekt'); %geht nicht!!