% MATLAB-Skript zum Plotten des Amplitudengangs
% b-Koeffizienten
b = [0, 1, -2, 1];
b1 = [1, -2, 1];

% a-Koeffizienten (Standardwert für ein FIR-System)
a = 1;

% Berechnung der Frequenzantwort
[H, w] = freqz(b, a, 1024);
[H1, w1] = freqz(b1, a, 1024);

% Plot des Amplitudengangs
figure;

% Plot für die ersten b-Koeffizienten
subplot(2, 1, 1);
plot(w/pi, 20*log10(abs(H)));
grid on;
title('Amplitudengang für b = [0, 1, -2, 1]');
xlabel('Normierte Frequenz (\omega/\pi)');
ylabel('Amplitude (dB)');

% Plot für die zweiten b1-Koeffizienten
subplot(2, 1, 2);
plot(w1/pi, 20*log10(abs(H1)));
grid on;
title('Amplitudengang für b1 = [1, -2, 1]');
xlabel('Normierte Frequenz (\omega/\pi)');
ylabel('Amplitude (dB)');