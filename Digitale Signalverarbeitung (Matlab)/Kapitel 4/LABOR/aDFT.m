% DFT
%=====
% (c) HSM, B. Wir 88.8.2012
%
%% (i) Berechnung der DFT mit fft.m 
x_k = [ 0 0 1 0 0 0 1 0 ]

% X_v = fft(.....);
% 
% figure(1); 
% subplot(2,2,1); plot(real(X_v)); title('REAL(FFT(x_k))'); 
% subplot(2,2,3); plot(imag(X_v)); title('IMAG(FFT(x_k))');
% subplot(2,2,2); plot(abs(X_v)); title('ABS(FFT(x))');
% subplot(2,2,4); plot(angle(X_v)); title('ANGLE(FFT(x_k))');
% %% (ii) Ergänzen von Nullen auf die Länge N=256
% N =256; 
% 
% X_v = fft(......);
% 
% figure(2); 
% subplot(2,2,1); plot(real(X_v)); title('REAL(FFT_{256}(x_k))'); 
% subplot(2,2,3); plot(imag(X_v)); title('IMAG(FFT_{256}(x_k))');
% subplot(2,2,2); plot(abs(X_v)); title('ABS(FFT_{256}(x))');
% subplot(2,2,4); plot(angle(X_v)); title('ANGLE(FFT_{256}(x_k))');
% 
% %% (iii) Berechnung der DFT von
% 
% x_k = [ 0 0 0 1 0 0 0 1];
% 
% N =256; 
% 
% X_v = fft(.....);
% 
% figure(2); 
% subplot(2,2,1); hold on; plot(real(X_v),'r');  legend('x_k','x_{k-1}'); 
% subplot(2,2,3); hold on; plot(imag(X_v),'r');  legend('x_k','x_{k-1}');
% subplot(2,2,2); hold on; plot(abs(X_v),'r');   legend('x_k','x_{k-1}');
% subplot(2,2,4); hold on; plot(angle(X_v),'r'); legend('x_k','x_{k-1}');
% 
% %% Zweimalige Fouriertransformation
% foo = fft(fft(x_k));
% 
% figure(3); subplot(2,1,1); stem(x_k);title('x_k');
%            subplot(2,1,2); stem(foo);title('fft(fft(x_k)');
% 
%