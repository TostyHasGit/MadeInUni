% Testataufgabe WS24
%
% Adaptives Filter
% Testumgebung für die Filterfunktion "FIR_LMS"
% Aufruf:       [yk,zf,wf,ek] = FIR_LMS(xk,dk,wi,zi,mu)
% Eingangsparameter:
%                   wi: N Koeffizienten [w(0),w(1),...w(N-1)]
%                   xk: Eingangswert x[k]
%                   dk: desired Wert d[k]
%                   zi: Gedächtnis (x[k-1], x[k-2],...,x[k-N+1])
%                   mu: Schrittweite
% Ausgangswerte:
%                   yk: Ausgangwert (y[k])
%                   zf: Gedächtnis nach dem Filtern
%                   wf: adaptierte Filterkoeffizienten
%                   ek: aktueller Fehler
% 
% Siehe DSV-Skriptes (wir)
%
% Jorge /Zuniga Le-Bert (JoZu) 
% 13.1.25 WIR ergänzt 
%
% AUFGABEN
%  1. ERSETZEN SIE DIE FUNKTION FILTER() in Zeile 48
%  2. STELLEN SIE Sie an den Stellen % ??`sinnvolle Parameter ein
%  3. ERSETZTEN SIE DIE Funktion FIR_LMS durch ihre Funktion   
%  
%% 1. Systemidentifikation; Adaptives Erkennen eines unbekannten Systems (d); 
% Rauschen (xr) wird durch das (unbekannte)FIR geschickt, dessen Ausgang (d)
% das erwünschte (desired) Signal für das Adaptive Filter erzeugt.
% xr ist gleichzeitig Eingang des adaptiven Filters.
% Die Filterkoeffizienten w(k) des adapt. Filters entsprechen dann den
% Koeffizienten des unbekannten Systems.

%---------------------------------------------------
close all;clear all; clc
%---------------------------------------------------

N=200;
xr=randn(1,N);                      % Testsignal (Rauschen)
mu = 0.2;                           % Schrittweite
M = 7;                              % Anzahl Koeff 
wi = zeros(1,M);                    % Koeff Adaptives Filter
zi = zeros(1,M-1);                  % Gedächtnis
%--------------------------------------------------- 
d = filter([1 0 0 0 0.5], 1, xr);   % Unbekanntes System
d1 = d ;
d1 = filter([1 0 0 0 0.5], 1, xr);  % Ihre Filterfunktion 
figure(1)
plot(d); hold on, plot(d1); 

figure(2) 
for k=1:N
    % Hier komnmt Ihre Funktion:
    [yk,zf,wf,ek] = FIRFilterT(xr(k),wi,zi,d(k),mu,1);  %xr(k),zi,wi,d(k),mu,1
    % Ende
    zi = zf;
    wi = wf;
    stem(wi,'ro'); drawnow; grid on; title('unbekanntes System (wi)');
end
%