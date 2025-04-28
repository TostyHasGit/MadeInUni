%% Filterentwurf mit MATLAB 
%
%% (i) Bandpass mit Parks-McClellen
%  Entwerfen Sie für ein digitales System mit der Abtastfrequenz 8kHz einen
%  linearphasigen Bandpass im Frequenzbereich 2 bis 3 kHz mit minimaler
%  Abweichung vom Sollfrequenzgang (firpm.m). Wie groß ist die Welligkeit
%  für ein Filter mit 100 Koeffizienten?
%  (c) DS Institut, Jorge Zuniga, WS 2011/12; Vers. 1.0 Vers. 1.1 B. Wir
%   August 2019 Update B. WIR
clear all; close all;      
%% Eingaben
fa=8000;                     % Abtastfrequenz
fn=fa/2;                     % Nyquistfrequenz (= pi)
fd1=2000;                    % Untere Grenzfrequenz
fd2=3000;                    % Obere Grenzfrequenz
N=100;                       % Anzahl von Koeffizienten
%% Entwurf mit firpm.m
% firpm simuliert ein linearphasiges FIR Filter mit Hilfe des Parks-McClellan
% Algorithmus. firpm.m liefert die Koeffizienten bo,b1,b2,... 
% Die Funktion firpm benötigt für den Entwurf folgende Daten:
% Ein Vektor mit den norm. Frequenzen (f), die dazugehörige
% Amplituden in eigenem Vektor (a).
% Außerdem benötigt man die Anzahl von Koeffizienten minus eins (N-1).
% fd1n=fd1/fn;                  % Norm. Frequenz fd1n=0.5
% fd2n= ......;                 % Norm. Frequenz fd2n=0.75
% f=[0  .......           1]; % Frequenzvektor 
% a=[0  0     1   1   0   0];   % Amplitudenvertor
% b=firpm(N-1,f,a);             % Filterentwurf
%% Grafische Ausgabe
% Ideales (gefordertes) und entworfenes Filter
% [h,w]=freqz(b,1,1024);       % [h,w] = Amplituden und Frequenzen
% figure(1); plot(f,a,'o',w/pi,abs(h));
% legend('Ideal','firpm Entwurf','Location','Best')
%% Bestimmung der Welligkeit
% Der Durchlassbereich wird gezoomt und dann mit den Werkzeue von MATLAB
% gemessen
% figure(2);
% plot(f,a,'o',w/pi,abs(h));
% text(0.1,1.01,'Welligkeit=0,008');
% axis([0 1 0.95 1.05])
%% Darstellung in dB
% Die Verstärkung wird in dB dargestellt: 
% $$ 10log(P_{out}/P_{in})^2:=10log(U_{out}/U_{in})^2=20log(U_{out}/U_{in}) $$
% ACHTUNG:  
% MATLAB berechnet die Eckfrequenz fc bei -6dB. Sie ist die Frequenz, bei der die 
% normierte Verstärkung = 0,5 beträgt.  Diese Frequenz lässt sich folgendermaßen 
% ausrechnen 
% fc1=fs1n+(fd1n-fs1n)/2.    
% Wobei fs1n und fd1n die normierten Sperr-/ und Durchlass-Frequenzen sind.                                       
% Hier: fc1=0,45+(0,5-0,45)/2=0,475 (hier 1900Hz) und fc2=0,775 (3100Hz). 
% Sonst ist fc als die Frequenz definiert, bei der die Verstärkung um 0,707 (-3 dB) 
% abgesunken ist. 

% figure(3);semilogy(w/pi,abs(h));
% plot(w/pi,20*log10(abs(h)),w/pi,-6);xlabel('\omega/\pi'),ylabel('|G(\omega)|/dB')
% legend('20log|G(\omega)|','Location','NorthWest');


%% (ii) Vergleich der Methoden
% Für ein digitales System mit der Abtastfrequenz f = 2kHz soll
% ein Tiefpass mit der Grenzfrequenz 500 Hz und einer Sperrdämpfung
% von 70 dB für Frequenzen oberhalb von 530Hz entworfen werden.
% Verwenden Sie das Programm filtdemo.m um folgende
% Fragen zu beantworten:
%
%  (a) Welche Filterordnung muss ein FIR-Filter haben, wenn der
%      Entwurf nach dem Verfahren von Parks und Mc Clellan erfolgt?
%      (Antw. N=127) 
%
%  (b) Welche Filterordnung muss ein IIR-Filter haben
%      für einen Cauer- (Antw. 9) und welche für ein
%      Tschebyscheff-Entwurf 2.Art (Antw. 20)?
%
%  (c) Ein Tiefpass (f_G =500 Hz) soll mit möglichst wenig
%      Rechenaufwand realisiert werden. Die Sperrdämpfung bei 800 Hz muss 
%      mindestens 48 dB sein. Welchen Filtertyp und welches Entwurfsverfahren
%      schlagen Sie vor? Wie viele Additionen und wie viele Multiplikationen 
%      benötigt das Filter je Abtastwert? Geben Sie die Filterkoeffizienten 
%      für das Filter.
% Hinweis: In MATLAB unter APPS finden Sie den Filter Designer. Eine mächtige 
% Anwendung die schnell viel Zeit kostet.

% clear all; close all;
% filtdemo    % Paremater einstellen; Fenster offen lassen 
% pause       % weiter mit RETURN
% [b,a] = filtdemo('getfilt')
% figure(20); 
% zplane(b,a); title('PN-Diagramm des gewählten Filters')
%            % !!!!!! filtdemo.m schließen vor nächsten Aufruf


