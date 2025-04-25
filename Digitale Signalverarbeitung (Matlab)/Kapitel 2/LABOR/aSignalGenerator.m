%% Aufgabe: Signalgenerator
% (i) Bauen Sie mithilfe eines Digitalen Filters einen Signalgenerator 
%  mit einstellbaren Periode P und einer Pulsform FORM. Erzeugen Sie damit
%  Rechteckpulse mit der Periode 16.  
% (ii) Detektieren Sie die Pulsflanken mit einem Differenzierer mit der
%  Impulsantwort [1 -1].
% (iii) Detektieren Sie die Pulse durch Faltung mit der gespiegelten 
%  Pulsform (signalangepasstes Filter == Matched Filter == Korrelator).
% (iv) Addieren Sie Rauschen zum Signal und wiederholen Sie (ii) und (iii).
clear all; close all;
%% (i) Signalgenerator
P = 16;
FORM = [1 1 1 1 1 1 1 ];
delta = [zeros(1,9),1, zeros(1,49)];
 
a = [1 0 0 0 0 0 0 0 0 0 0 0 -1]; 
x = filter(FORM,a,delta);
figure(1); subplot(3,2,1)
plot(x); title('Pulse'), ylim([-2, 2]);

%% (ii) Flankendetektion mit [1 -1]
b = [ 1 -1];
y = filter(b,1,x); 
figure(1); subplot(3,2,3); 
plot(y,'r'); title('Flankendetektion'), ylim([-2, 2]);
hold on; plot(x,'b.');hold off;

%% (iii) Pulsformdetektion
y2 = filter(fliplr(FORM)/sum(abs(FORM)),1,x);

figure(1); subplot(3,2,5);
plot(y2,'r'); title('Pulsformdetektion');  ylim([-2, 2]);
hold on; plot(x,'b.');hold off;

%% (iv) Flankendetektion und Pulsformfilter bei Rauschen
R = 0.5;
% R = 0.15;
x_r = x + R*randn(size(x));

figure(1); subplot(3,2,2); 
plot(x_r);title('... mit Rauschen');ylim([-2, 2]);

% b = [x_r];
y_r = filter(b, 1, x_r);
figure(1); subplot(3,2,4); 
plot(y_r,'r'); title('Flankendetektion bei Rauschen'); ylim([-2, 2]);
hold on; plot(x,'b.');

y2_r = filter(fliplr(FORM)/sum(abs(FORM)),1,x_r);

figure(1); subplot(3,2,6);
plot(y2_r,'r'); title('Pulsformdetektion bei Rauschen');  ylim([-2, 2]);
hold on; plot(x,'b.');hold off;

%% Beliebige Pulsform
FORM = [ 0 1 2 0 -1 5 12 5 -4 0 1 2 1 0 0 0 0 ]/7;