%% JitterSNR
%
% Ein EKG-Messgerät arbeitet mit der Abtastfrequenz f_a = 400Hz und einem
% 16-Bit AD-Wandler. Aus ungeklärten Gründen schwankt der Abtastzeitpunkt 
% im rms-Mittel (root mean square) um 0,01ms (==> 100khz).
% (i) Welches SNR erwarten Sie für ein Sinus-Testsignal mit der Frequenz
% 100Hz und bzw. 10Hz. Schätzen Sie den Einfluss durch Jitter  
% (Phasenrauschen)und durch Quantisierungsrauschen getrennt voneinander ab.    
% (ii) Simulieren Sie den Frequenzgang des Phasenrauschens, falls ein 100Hz
% und 10 Hz Signal mit Jitter abgtastet wird. 
% B. WIR 22.10.2020
clear all; close all;
%% (i) Theorie
%  SNR des Jitter
f_a  = 400  % Hz
f_in_100 = 100 % Hz
f_in_10 = 10 % HZ 
t_j = 1e-5; % s
SNR_j_100 = - 20*log10(2*pi*f_in_100*t_j)% lt skript
SNR_j_10 = - 20*log10(2*pi*f_in_10*t_j) % 


% SNR durch Quantisierung
SNR_16BIT = 16 * 6   % grob 6dB/Bit; im Detail 6.02 dB/Bit + 1,77 sieh skript

% Fazit: Das durch Quantsierung verursachte Rauschen ist vernachlässigbar.
% Es wirkt sich jeweils nur das Jitter-Rauschen aus. Das Jitter-SNR verschlechtert 
% sich mit 20dB/Dekade bezogen auf die Frequenz des Eingangssignals.  

%% (ii) Simulation
% 
  f_sim = f_a*100;  % in Hz ; Abtastung für die Simulation ; 
  t     = 0:1/f_sim:60-1/f_sim; % Zeitachse
  f_10  = 10; %Hz
  f_100 = 100; %Hz
  X_10  = sin(2*pi*f_10*t);
  X_100 = sin(2*pi*f_100*t);
  
figure(1); subplot(3,3,1);
plot(t(1:10000),X_10(1:10000)); title('(quasi analoge) Testsignale');xlabel('s')
hold on;
plot(t(1:10000),X_100(1:10000)); 
hold off;

% Abtastung mit Jitter
rms_jitter = 1.0e-4;
t_a = t(1:f_sim/f_a:end);
t_jitter = t_a + rms_jitter*randn(size(t_a));
%t_jitter = t_a + rms_jitter*sin(2*pi*1110*t_a).^2;


X_10_j  = sin(2*pi*f_10*t_jitter);
X_100_j = sin(2*pi*f_100*t_jitter);
X_10_a  = sin(2*pi*f_10*t_a);
X_100_a  = sin(2*pi*f_100*t_a); 
%%
% 

figure(1); subplot(3,3,4);
plot(t_a(1:100),X_10_j(1:100)); title('abgetastet mit Jitter');xlabel('s');
hold on;
plot(t_a(1:100),X_100_j(1:100)); 

figure(1); subplot(3,3,7);
plot(t_a(1:100),X_10_a(1:100)); title('abgetastet ohne Jitter');xlabel('s')
hold on;
plot(t_a(1:100),X_100_a(1:100)); 
hold off;

% Brechnung des SNR
subplot(3,3,5)
snr(X_10_j,400)
subplot(3,3,6)
snr(X_100_j,400)
subplot(3,3,8)
snr(X_10_a,400)
subplot(3,3,9)
snr(X_100_a,400)


