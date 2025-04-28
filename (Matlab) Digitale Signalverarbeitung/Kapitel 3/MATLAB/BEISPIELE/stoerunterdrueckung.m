%% St�runterdr�ckung
%  durch einen adaptiver Pr�diktor
% Ein Reporter macht ein Interview an einer stark befahrenen
% Stra�e. Skizzieren Sie ein adaptives System (\(<5 \) Bl�cke) zur
% Kompensation des Stra�enl�rms und beschreiben Sie es in 2 bis 3
% S�tzen.
% (c) HSM, B. Wir 2.8.2012 10.5.21 audioread statt wavread
clear all; close all;

%% Signale

% St�rung
Z = 40000; %... Abtastwerte

[x_r,f_s] = audioread('road.wav');
x_r = resample(x_r,1,4); f_s = f_s/4;
x_r = x_r(1:Z);
f_s
soundsc(x_r,f_s);
disp('WEITER mit Taste')
pause

% Nutzsignal
[x_n,f_s
    ] = audioread('speech_dft.wav');
x_n = resample(x_n,1,2); f_s = f_s/2;
x_n = x_n(1:Z)'; 
f_s
NBITS
soundsc(x_n,f_s)
disp('WEITER mit Taste')
pause

figure(1); subplot(2,1,1);
plot( x_r); title('Hintergrundger�usch');
            subplot(2,1,2); 
plot(x_n); title('Sprecher');


%% Simulation der St�rung
D  = 0.5;     % Distanz der Mikrophone in m
A  = 4        % Mischfaktor der St�rung im Nutzsiganl 
B = 0.2       % Mischfaktor des Nutzsignals in der St�rung
delay = round((D/330)*f_s) % ... in Abtasttakten

y_n =      x_n(delay:end)   + A * x_r(1:end-delay+1);
y_r =  B * x_n(1:end-delay+1) +     x_r(delay:end);

figure(2); subplot(2,2,1);
plot( y_n(1:10000)); title('Sprecher (t) + \alpha \cdot Hintergrund (t-dt)');
            subplot(2,2,3); 
plot(y_r(1:10000)); title('Hintergrund (t) + \beta \cdot Sprecher (t-dt)');

soundsc(y_n,f_s)
disp('WEITER mit Taste')
pause
soundsc(y_r,f_s)
disp('WEITER mit Taste')

pause

%% Signalrekonstruktion
N = 30;   % Filterordnung
w = zeros(1,N);
STEP = 0.07;

[x_n_dach,e,w] = lms(w,y_r,y_n,STEP); 

soundsc(e,f_s)

subplot(2,2,2); plot(e(1:10000)); title('Sch�tzung von Sprecher (t)');
subplot(2,2,4); plot(w); title('Filterkoeffizienten')


