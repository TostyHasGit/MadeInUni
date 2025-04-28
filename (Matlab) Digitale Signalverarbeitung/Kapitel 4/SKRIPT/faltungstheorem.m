% faltungstheorem.m
% Skript SMU_02
%
% B.Wir 20.9.02, 18.8.2012
%
%  Fortgeschrittene,effiziente Programmierung ohne Schleifen

close all
clear
clc

N =600;   % ... Werte
M = 100;    % ... Experimente

x=randn(M,N);
y=[1 0 0 0.5];

z =conv2(x,y,'same');

% oder auch so
% zk=filter2(y,x);

figure(1)

subplot(2,2,1)
plot(x(1,:));hold on; plot(sum(x)/M,'r*'); legend('1 Exp.', 'Summe vieler Exp.')
title('Zufallssignal x')

X = fft(x')'; %...'' entlang der Zeilen
subplot(2,2,2)
plot(abs(X(1,:)));hold on; plot(sum(abs(X))/M,'r*');
title('abs(fft(x)')

subplot(2,2,3)
plot(z(1,:)); hold on; plot(sum(z)/M,'r*');
title('Echo: z = conv(x,[1 0 0 0.5])') 

Z = fft(z')';
subplot(2,2,4)
plot(abs(Z(1,:)));hold on; plot(sum(abs(Z))/M,'r*');
title('abs(fft(z))')

