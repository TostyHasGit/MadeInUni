%% Overlap-Add-Methode 
% (c) HSM, B. Wir 20.8.2012
%
% Falten Sie die Signale  x_k = [ 1 , 2 , 3 , 4, 5,  6 ,7, 8 ]   und 
% g_k = [ 1 1] mit der Overlap-Add-Methode, wobei die Blocklänge L=4 ist. 
% Verwenden Sie dabei statt der FFT und IFFT die zklische Faltung im 
% Zeitbereich. 

L =4;
N = 2;
M = L + N -1

x_k = [ 1 2 3 4 5 6 7 8]
g_k = [ 1 1 ]

%% Blöcke bilden und Nullen ergänzen

x1= [x_k(1:L),0]
x2 = [x_k(L+1:2*L),0]

g  = [ g_k, 0, 0, 0]

%% Zyklische Faltung 
% == Faltung wegen Nullen
y1 = filter(g,1,x1)
y2 = filter(g,1,x2)

y = [ y1 , 0 , 0,  0,  0  ] + ...
    [ 0 ,  0 , 0,  0,  y2 ]
    
y = conv(x_k,g_k)    

%% FFT-Faltung

y1 = ifft(fft(x1).*fft(g));
y2 = ifft(fft(x2).*fft(g));

y_fft = [ y1 , 0 , 0,  0,  0  ] + ...
        [ 0 ,  0 , 0,  0,  y2 ]
