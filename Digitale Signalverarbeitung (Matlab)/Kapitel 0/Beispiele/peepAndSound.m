% Pfeifton erzeugen
% B. WIR 27.3.2020, 29.3.21, 


f_a = 8000;    % Abastfrequenz in Hz 
f_sinus = 440; % in HZ
vektor_t=0:1/f_a:5; % Zeitachse 5s
vektor_x = sin (2*pi*f_sinus*vektor_t);

plot(vektor_x(1:1000),'k' );

x1 = vektor_x; 
x1(x1>0) = 1; % aus dem Sinus ein Rechtecksignal machen 
x1(x1<0) = -1;  
hold on; plot(x1(1:1000),'r');hold off; % Rechtecksignal im Plot ergänzen

soundsc([vektor_x,x1],f_a); % Sinus und danach Rechteck anhörensoundsc(x1,f_a); % Rechteck anhören