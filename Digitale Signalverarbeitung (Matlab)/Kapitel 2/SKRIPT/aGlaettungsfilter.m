%% aGlaettungsfilter.m
% Ein FIR-Filter mit den Koeffizienten \( b = [ 1, 1, 1] \)
% wird zweimal hintereinander auf ein verrauschtes Sinussignal angewandt. 
% (i)   Welcher Gesamtimpulsantwort entspricht diese Verarbeitung und 
%       welche Wirkung hat das Filter?
% A:    
% (ii)  Welche Impulsantwort hat ein IIR-Filter mit den Koeffizienten 
%       \(b_0 = 1 \) und \( a_1 = -0.9 \)?
%       Welche Wirkung hat das Filter? 
% (iii) Beantworten Sie die Fragen (i) und (ii) für ein Rechtecksignal.

close all; clear all;
%% Verrauschter Sinus
T_A = 0.001         % [s] 
F = 50            % [Hz]

t = (0:T_A:0.1-T_A); % 0.1 s,
x_k  = sin (2*pi*F*t);

% Später für Aufgabe (iii)
x_k(x_k>0) = 1;
x_k(x_k<0) = -1;

xr_k = x_k + 0.4 * randn(size(x_k));

figure(1); subplot(3,1,1); 
plot(x_k); ; hold on; plot(xr_k,'r'); title('x_k / mit Rauschen'); hold off;

%% (i) Gesamtimpulsantwort von zweimal [1 1 1 ]
% y = filter(b, a, x)
% b: Die Koeffizienten des Zählers (Nummerator) des Filters. Diese bestimmen, wie...
%       ...die aktuellen und vergangenen Eingangswerte gewichtet werden. (Eingangsgewichte)
% a: Die Koeffizienten des Nenners (Nenner) des Filters. Diese bestimmen, wie...
%       ...die vergangenen Ausgabewerte (Feedback) gewichtet werden (Rückkoplungswerte, erste Zahl ist der direkte Ausgang).
% x: Das Eingangssignal, das gefiltert werden soll.
% y: Das resultierende Ausgangssignal nach der Filterung.

b = [ 1, 1, 1]              % Die Gewichte der aktuellen und Vergangenen Werte
impuls = [ 1 0 0 0 0 0]     % Das Eingangssignal
y = filter(b,1,impuls);     % Filterergebnis wird in y gespeichert
g_g = filter(b,1,y)         % Filter wird nochmal drüber gelegt
%g_g = conv(b,b)   % gleiches Ergebnis (Faltung von zwei Vektoren)

% Wirkung des Filters

yr_k  = filter(g_g,1,xr_k); % 

figure(1); subplot(3,1,2); 
plot(x_k); hold on; plot(yr_k/9,'r'); title('... nach FIR Filter'); hold off;

%% (ii) IIR-Filter
b = 1 ;
a = -0.5;
imulsantort = filter(b,[1 a],impuls)        % Filter mit den gewichten 1, -0.5 auf den Impuls
yr_k  = filter(b,[1 a],xr_k);               % Filter mit den Gewichten 1, -0.5 auf das Rechtecksignal

% Trick für Nullphasige IIR Filter:
yr_k  = fliplr(filter(b,[1 a],fliplr(yr_k))); % siehe auch filtfilt.m 
 
figure(1); subplot(3,1,3); 
plot(x_k); hold on; plot(yr_k/(2/(1+a)),'r'); title('... nach IIR Filter'); hold off;

%% (iii) Rechtecksiganl
%  entsteht aus Sinus durch Schwellwertoperation

x_k(x_k>0) = 1;
x_k(x_k<0) = -1;


%% (iv) Verzögerung
b = [1, 0, 0, 0, -1];
a = -1;
imulsantort = filter(b,[1 a],impuls)        % Filter mit den gewichten 1, -0.5 auf den Impuls
yr_k  = filter(b,[1 a],xr_k);

figure(2); subplot(3,1,1); 
plot(x_k); hold on; plot(yr_k/(2/(1+a)),'r'); title('... nach IIR Filter'); hold off;
