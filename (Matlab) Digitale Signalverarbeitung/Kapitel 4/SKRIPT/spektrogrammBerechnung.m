% spectrogrammBerschnung.m
%  B. wir 

clear all;
figure(1)
subplot(2,1,1);
hold on;
x = 0.5*sin(2*pi*[0:0.001:0.499].^2*100).^2
plot(x)
axis off
plot(hann(128))

subplot(2,1,2)
specgram(x,128)

