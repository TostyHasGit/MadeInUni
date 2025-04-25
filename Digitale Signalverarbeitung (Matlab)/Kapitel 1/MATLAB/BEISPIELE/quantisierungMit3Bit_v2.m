%% Quantisierung mit 3 Bit
%  Mit 3 Bit können die ganzen Zahlen von -4 bis 3 dargestellt werden.
%  Die Rauschleistung des Quantisierungsfehlers ist 1/12=0.083 pro
%  Abtastwert, das SNR ist 17.1dB. Das Quantisierungsrauschen hat eine 
%  gleichverteilte Amplitudenstatistik (rechts oben). Für die spezielle 
%  Signalform ist das Rauschspektrum jedoch nicht weiß (rechts unten).  
%  WIR 19.7.2012; 20.10.20 Kommentare ergänzt; Leckeffekt behoben

clear all; close all;
BIT = 3;
%% Signalerzeugung
x = [-2^(BIT-1):0.0001:2^(BIT-1)-1]; % Quantisierung mit Delta=0.0001   

%% Quantisierung und Berechnung von Rauschleistung und SNR
x_q = round(x); % Quantisieren mit Delta = 1
e_q = x - x_q;

rauschleistung = (e_q*e_q')/(length(e_q))
SNR_dB = 10*log10((x*x')/(e_q*e_q')) 
%% Darstellung
figure(1);subplot(2,2,[1 3]); plot(x,x); grid on; axis([ -4,4 ,-4, 4]); 
hold on; plot(x,x_q,'r'); plot(x,e_q,'k--'); hold off;
title('Quantisierung mit 3-Bit');xlabel('Eingang'); ylabel('Quantisierung und Fehler'); 
legend('Signal', 'Quantisierung','Fehler', 'location','best');


subplot(2,2,2); hist(e_q); title('Amplitudenstatistik des Rauschens e_Q');
xlabel('Wert'); ylabel('Häufigkeit');
subplot(2,2,4); plot(abs(fft(e_q))); title('|FOU(e_Q)|');
window = hamming(1024);
subplot(2,2,4); pwelch(e_q,window); title('LDS(e_Q)');

figure(2)
pwelch(e_q); title('LDS(e_Q) mit Leckeffekt (nur für BIT=8 deutlich sichtbar '); 