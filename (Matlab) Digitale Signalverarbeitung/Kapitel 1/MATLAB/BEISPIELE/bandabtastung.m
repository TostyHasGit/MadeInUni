% DSV -Skript 
% Bandabtastung
% Setzt sehr gute Kenntniss in  der Systemtheorie voraus!! 
% B. Wir 23.1.03/ 22.9.2011/ 23.7.2011

N  = 32;     % Anzahl der Werte
N3 = 3 * N;

% Bandbegrenztes Zufallssignal erzeugen 

x = randn(1,N3);
Xb = (fft(x));    
Xb(1:N) = 0;
Xb (N3-N+1 : N3) = 0;
xb = real(ifft(Xb));
axis off;

figure(1);
subplot(4,2,1);
plot(xb);
axis([1,N3,-2,2]);
title('Bandsignal')
axis off;
subplot(4,2,2);
plot(abs(fftshift((Xb))));   % Nullfrequenz im Zentrum
axis([1,N3,0,15]);
title('Spektrum');
axis off;
pause

% Bandabtastung
xBandabtastung = xb(1:3:N3);
XBandabtastung = fft(xBandabtastung);

subplot(4,2,3);
plot(xBandabtastung);
axis([1,N,-2,2]);
title('Bandabgetastet')
axis off;

subplot(4,2,4)
plot([zeros(1,N),abs(fftshift(XBandabtastung)),zeros(1,N)]); % Nullfrequenz im Zentrum
title('Basisbandspektrum');
axis([1,3*N,0,5])
axis off;
pause

% Einfügen von Nullen (upsampling)
xUp = upfirdn(xBandabtastung,[1 0 0 ],3,1)
subplot(4,2,5)
plot(real(xUp));
axis([1,3*N,-2,2]);
title('Einfügen von Nullen')
axis off;

XUp = (fft(xUp));
subplot(4,2,6)
plot(abs(fftshift(XUp)));
title('Spektrum');
axis([1,3*N,0,5])
axis off;
pause

% Bandpassfilter

XUp(1:N) = 0;  XUp(2*N+1:3*N) = 0;    % Bandpass
xBand = real(ifft(3*XUp));

subplot(4,2,7)
plot(xBand);
title('Bandsignal');
axis([1,3*N,-2,2]);
axis off;

subplot(4,2,8)
plot(abs(fftshift(XUp)));
title('Spektrum');
axis([1,3*N,0,5])
axis off;
pause

