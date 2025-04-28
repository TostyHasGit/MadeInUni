% Aufgabe: Quantisierungsrauschen
% Zeigen Sie in einer MATLAB-Simulation: Für ein weißes Zufallssignal
% (rand.m) hat das Quantisierungsrauschen eine gleichverteilte Amplitude,
% eine Leistung von (Quantisierungsstufe)/12  und das Spektrum ist weiß (pwelch.m). 
% Zeigen Sie konkret, dass eine 8-Bit Quantisierung zu 48dB SNR führt und 
% hören Sie ich Händels Halleluja mit Quantisierungsrauschen an.
% WIR 7.10.2010; 6.3.2012
clear all; close all;
%% (i) Erzeugen gleichverteilter Zufallszahlen mit dem Wertebereich [-128.5, 127.5]
%      und plotten des Amplitudenhistogramms(rand.m, hist.m). 
BIT = 8;
x = (rand(1,10000)-0.5) * 2^BIT - 0.5;  
hist(x); title('Amplitudenhistogramm d. Signals')

%% (ii) Quantisieren des Signals mit 8 Bit (round.m). 

 % x_q = round...; 

%% (iii) Plotten des Quantisierungsfehlers, dessen Amplitudenverteilung und dessen LDS 
% Wie ist die Amplitudenstatistik und der Frequenzgang des Quantisierungsfehlers (pwelch)?
% e_q = (x -x_q);

% figure(2)   ; subplot(2,2,1); plot(x(1:10)); axis([1, 10, -2^(BIT-1), 2^(BIT-1) ])
%            hold on; plot(x_q(1:10),'r--'); title('Signalausschnitt') 
%            legend('x','x_Q','location','best');
%            subplot(2,2,3); plot(e_q(1:10)); axis([1 10 -2 +2 ]);title('Quantisierungsfehler')
%            subplot(2,2,2); hist(e_q);  title('Amplitudenverteilung des Fehlers e_q');
%            xlabel('Wert'); ylabel('Häufigkeit');
%            subplot(2,2,4); pwelch(e_q,128); title('LDS(e_Q)')
%% (iv) Quantisierungsrauschen hat die Leistung Quantisierungsstufe^2/12 

% P_e =   
% P_eSkript = 1/12     % Fehler laut Skript (Quantisierungsstufe = 1)

%% (iv) 8 Bit Quantisierung führt zu SNR=48dB

% SNR_dB = 10*log10....

%% Hörprobe und Spektrogrammme des Hallelujas mit/ohne Quantisierungsrauschen 
% clear all; 
% BIT = 3
% WINDOW = 1024;
% load handel;
% whos      % welche Variablen gibt es  
% F_A = Fs  % Abtastfrequenz
% figure(3); 
% hist(y);title('Amplitudenstatistik des Halleluja')
% soundsc(y,F_A)
% figure(4);
% subplot(1,3,1); spectrogram(y,WINDOW); colorbar
% title('Spektrogramm'); drawnow;

% Quantisierung
% y_q = 
%soundsc(y_q,F_A)
% soundsc(y_q,F_A,BIT)  % macht das Gleiche
% figure(4);
% subplot(1,3,2); spectrogram(y_q,WINDOW); colorbar;
% title( [int2str(BIT) '-Bit Quantisierung']);
% subplot(1,3,3); spectrogram(y - y_q,WINDOW);colorbar;
% title('Fehler');





