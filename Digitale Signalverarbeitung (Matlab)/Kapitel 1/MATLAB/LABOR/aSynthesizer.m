%% Aufgabe: Synthesizer
% (i) Untersuchen Sie, wie sich das Quadrieren der Signalamplitude sowie 
% Quantisierungsfehler auf das Spektrum eines Sinustons auswirken. Welchen
% Einfluss hat die Fensterbreite auf die spektrale Schätzung? 
% (ii) Synthetisieren Sie ein Musikstück durch Sinus-Töne. Beachten Sie: 
% Der Kammerton a'==44OHz und eine Oktave tiefer a==a'/2 = 220Hz. 
% Die zwölf Halbtöne zwischen einer Oktave unterschieden sich jeweils um 
% den Faktor 2^1/12 in der Frequenz. Maskieren Sie die Töne  mit einer 
% Exponentialfunktion.  
% (iii) Erzeugen Sie Obertöne und untersuchen Sie den Einfluss von 
% Quantisierungsrauschen. 
% 
% Quelle: M. Werner: DSV mit MATLAB
% B. Wir 18.7.2012
clear all; close all;
%% (i) a-Sinuston von 2 Sekunden, Obertöne und Quantisierungsrauschen
F_A = 8000   % Abtastfrequenz in Hz
T_A = 1/F_A  % Abtastabstand in s
WINDOW = 512;  % Fenster für Spektrogramm
A = 220;     % Frequenz in Hz

t = 0:T_A: 2.000-T_A;
x = sin (2*pi*A*t);
figure(1); subplot(1,3,1)
spectrogram(x,WINDOW); colorbar;title('Spektrogramm/dB')

% Quadrieren der Amplitudes
% x_o = ......);
% subplot(1,3,2)
%spectrogram(x_o,WINDOW);colorbar;title('Obertöne')

% Quantisierungsrauschen
% BIT = 4 
% x_q  = round ...... );
% subplot(1,3,3)
% spectrogram(x_q,WINDOW);colorbar;title('3-Bit Quantisierung')


%% (ii) Synthesizer
% Die Tonhöhen in Hertz
% Halbton == 2^(1/12)
A_    = 440;  % Kammerton a'
A     = A_/2; % a   
B     = A*2^(1/12) ; H = A*2^(2/12); % b
C_     = A*2^(3/12) ; %c'
GIS   = A*2^(-1/12); G = A*2^(-2/12);
FIS   = A*2^(-3/12); F = A*2^(-4/12);
E     = A*2^(-5/12);
DIS   = A*2^(-6/12); D = A*2^(-7/12);
CIS   = A*2^(-8/12); C = A*2^(-8/12);

T4 = 0.3;  % .. s 
BIT =4 ;
% % Musikstück 
song     = [ A    B  A  G  F  G  A    C_  B  A  G  B  C_];
duration = [T4    T4 T4 T4 T4 3*T4 T4 T4 T4 T4 T4 3*T4 T4];

music = [];    % Feld anlegen 

% for k=1:length(song)
%  t =[0: T_A : duration(k)]; %... nicht zeitoptimal     
%  x = sin (2*pi*t*song(k));
%  profil = exp(-t*5);
%  x = x.*profil;
%  music = [music x];
%end

% soundsc(music,F_A);
% figure(2);
% subplot(1,2,1); spectrogram(music,WINDOW);title('Spektrogramm/dB'); colorbar

%% (iii) Obertöne 
% music = music + ...........;
% x = x/max(x); 
% x_v  = round(...); x = x/max(x); %Quantisierungsrauschen
% soundsc(music,F_A);
% figure(2);
% subplot(1,2,2); spectrogram(music,WINDOW);title('Verarbeitet'); colorbar
% 
    

