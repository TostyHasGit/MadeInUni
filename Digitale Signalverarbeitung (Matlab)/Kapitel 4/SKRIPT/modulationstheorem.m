%% Modulationstheorem
% (c) HSM B.Wir  
%
%% Simulation der Störung
N = 64 %... Werte

figure(1)
% Signal
x = ecg(N);
x = filter([1 1 1],[1 -0.96],x); % etwas glätten
x = x/max(x);
X = fft(x);
% Modulation
n = 1:N;
mod = (-1).^n;
x_m = x.*mod;

% 1/f-Rauschen

r = 1.5 * randn(1,N);
R = fft(r);
f = 1:N/2;
F_filter = [1./f, 2/N, fliplr(1./(f(2:end)))];
r_f = real(ifft(R.*F_filter))
R_f = fft(r_f);


% Signal mit Rauschen
y = x + r_f;
Y = fft(y);

y_m = x_m + r_f;
Y_m = fft(y_m);

figure(1); subplot(5,2,1); plot(x); title(' Signal x');xlim([1 N]);
           subplot(5,2,2); plot(abs(X)); title('|DFT(x)|');xlim([1 N]);
           subplot(5,2,3); plot(r_f); title('1/f- Rauschen');xlim([1 N]);
           subplot(5,2,4); plot(abs(R_f)); title('|DFT(...)|');xlim([1 N]);

           subplot(5,2,5); plot(y,'r'); title('Signal mit 1/f- Rauschen');xlim([1 N]);
           subplot(5,2,6); plot(abs(Y),'r'); title('|DFT(...)|');xlim([1 N]);

           subplot(5,2,7); plot(y_m,'r'); title('Moduliertes Signal mit 1/f- Rauschen');xlim([1 N]);
           subplot(5,2,8); plot(abs(Y_m),'r'); title('|DFT(...)|');xlim([1 N]);

           
 %% Signalrekonstruktion
 
 % Filteruung
 Y_m(1:22) = 0;
 Y_m(N-20:N) = 0;
 x_r = ifft(Y_m);
 x_r = x_r.*mod;
 
 subplot(5,2,9); plot(x_r,'k'); title('Rekonstruiertes Signal');xlim([1 N]);ylim([0 1]);
           subplot(5,2,10); plot(abs(Y_m),'k'); title('Filterung');xlim([1 N]);
