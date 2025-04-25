%% Inverses Filter
% Im Laborversuch untersuchen Sie ein System zur
% inversen Filterung eines Echosignals. Bevor Sie starten,
% überprüfen Sie das Zahlenbeispiel Ihrer Vorbereitung. 
% Danach modellieren Sie die Störung, und Sie untersuchen
% die Möglichkeiten einer Störunterdrückung durch ein inverses Filter.
% 
% (c) HSM. B.Wir 1.8.12
clear all; close all;
%% Zahlenbeispiel
% Echoerzeugung
% b=[1 0 0 0.5]
b=[1 0 0 0.8] % später für (iii)
a=[1]

% AR-Echokompensation
b_inv = a
a_inv = b
% Test
x =[1 0 0 2 0 0 0 0 0 0 ]
y = filter(b,a,x) %! Echosignal wird erzeugt

x_dach = filter(b_inv,a_inv,y) %! Echo wird weggemacht

% Impulsantwort des inversens Systems
g_inv = filter(b_inv,a_inv,[ 1 0 0 0 0 0 0 0 0 0]) %! Impulsantwort vom Filter von Zeile 23

% MA-Echokompensation
b_inv_MA = g_inv
a_inv_MA = 1
x_dach_MA = filter(b_inv_MA,a_inv_MA,y)

%%(i) Modellierung der Störung
% durch ein Zufallssignals x[k] und ein  MA-Filter.
Z = 500  % ...Werte
x = randn(1,Z); x(10) = 10; 
y = filter(b,a,x);
figure(1);
subplot(4,1,1); plot(x); title('Zufallssignal mit \delta-Peak')
subplot(4,1,2); plot(y); title('... mit Echo')

%% (ii) Signalrekonstruktion mit einem AR- bzw. MA-Filter
x_dach     = filter(b_inv, a_inv, y);
x_dach_MA  = filter(b_inv_MA, a_inv_MA, y);
subplot(4,1,3); plot(x_dach); title('...nach inversem Filter');
hold on;        plot(x_dach_MA,'k'); legend('AR','MA'); hold off; 

e_AR = x-x_dach; 
e_m_AR = e_AR * e_AR'/length(e_AR)
e_MA = x-x_dach_MA; 
e_m_MA = e_MA * e_MA'/length(e_MA)

subplot(4,1,4); plot(e_AR); 
title(['Rekonstruktionsfehler e^2_{AR} = ', num2str(e_m_AR), ' e^2_{MA}=' , num2str(e_m_MA)]);
hold on;        plot(e_MA,'k'); legend('AR','MA'); hold off; 

%% (iii) Praktischer Einsatz

%%  - Rauschen im Empfäger
e_AR_werte = []; % Fehler beim AR Filter
e_MA_werte = []; % Fehler beim MA Filter
for r=1:1:100; %Rauschleistung in %
y_r = y + r / 100 * randn(size(y));

foo = (x - filter(a_inv, y, r));
e_AR = foo*foo'/length(foo);
e_AR_werte = [e_AR_werte,e_AR];


foo = (x - filter(1, a_inv, y_r)); % Der Fehler
e_MA = foo*foo'/length(foo);
e_MA_werte = [e_MA_werte,e_MA];

end
figure(2); subplot(2,2,1);
plot(e_AR_werte); title('Empfängerrauschen');
xlabel('Rauschleistung in %'); ylabel('Rek.-fehler^2/Abtastwert');
hold on; plot(e_MA_werte,'k'); legend('AR', 'MA','location','best');

%% - Fehlerhafte Echohöhe 
e_AR_w = [];
e_MA_w = [];

for f= -50:1:49; % Fehler in %

a_inv_f = a_inv + 1; 
a_inv_f(1) = 1;
foo = (x - filter(1,a_inv_f,y));
e_AR = foo*foo'/length(foo);
e_AR_w = [e_AR_w,e_AR];

b_inv_MA_f = b_inv_MA + b_inv_MA*f/100;
b_inv_MA_f(1) = 1;
foo = (x - filter(b_inv_MA_f,1,y));
e_MA = foo*foo'/length(foo);
e_MA_w = [e_MA_w,e_MA];

end
figure(2); subplot(2,2,2);
plot( -50:1:49 ,e_AR_w); title('Fehlerhafte Echhöhe');
xlabel('Fehler in %'); ylabel('Rek.-fehler^2/Abtastwert');
hold on; plot(-50:1:49,e_MA_w,'k'); legend('AR', 'MA','location','best');

%% - Stabilität falls Echohöhe gegen 1
% Echohöhe unter (i) ändern
%
% Siehe dazu auch die PN-Diagramme für AR und MA. 
subplot(2,2,3); zplane(1,a_inv);title('AR-Filter')
subplot(2,2,4); zplane(b_inv_MA,1);title('MA-Filter')

