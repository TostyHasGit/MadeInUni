%% Schnelle Faltung 
%% (i) Falten der Signale mithilfe der FFT 

x_k = [ 1 0 0 2 0 0]
g_k = [ 1 2 3 0 0 0]
y = conv(x_k,g_k)

X = fft(x_k);
G = fft(g_k);
Y = X .* G;
y_f = ifft(Y);

%% (ii) Falten ohne Zero-Padding 

x_k = x_k(1:4)
g_k = g_k(1:4)

X = fft(x_k);
G = fft(g_k);
Y = X .* G;
y_f = ifft(Y);

%% (iii) Rechenzeitvorteil der schnellen Faltung (Frequenzbereichsfaltung)
% Die FFT benötigt ca. \( Nlog_2N \) Rechenoperation.
% Schätzen Sie ab, ab welcher Filterordnung \( N\) die Faltung mithilfe der FFT 
% schneller als ein digitales Filter ist. 
% Für M Signalwerte und N Filterkoef.

N = 1:100;
M = 1024 

% zeit_filter = .....
% zeit_fft = ....  ;
% 
% plot(N,zeit_filter,N,zeit_fft); title('Schnelle Faltung'), legend('Filter','FFT-Faltung');
%                                 xlabel('Filterordnung');   

% Antwort: 
% Offen:  