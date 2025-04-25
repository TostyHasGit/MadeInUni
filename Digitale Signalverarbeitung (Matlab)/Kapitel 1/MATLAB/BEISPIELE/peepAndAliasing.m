%% Demostration von Aliasing durch ein Chirpsignal
% (i) Bei einer Abtastfrequenz von 2kHz kann ein Chirp-Signal
%     bis 1kHz ohne Aliasing abgetastet werden
% (ii)Reduziert man die Abtastfrequenz auf 1kHz (ohne vorherigen
%     Tiefpass mit fg = 500Hz) so tritt bei 500Hz Aliasing auf. 
%     Die linear steigende Frequenz des Chirp fällt scheinbar, was natürlich
%     nicht stimmt.  
%     Fazit: Ein Tiefpass mit fg=500Hz würde die Spiegelfrequenz vermeiden,  
% B. WIR 18.2.2022 

%(i)
f_a = 2000;    % Abastfrequenz in Hz 
vektor_t=0:1/f_a:4; % Zeitachse 4s 

F0 = 0; %Hz
T1 = 4; %s;
F1 = f_a/2;
y = chirp(vektor_t,F0,4,F1);


subplot(2,2,1)
plot(y(1:1000),'k' ); title('Audiodemo Aliasing')
xlabel(' Auschschnitt aus Audiosignal')
subplot(2,2,2)
spectrogram(y,256,250,256,2E3,'yaxis');   % Display the spectrogram
soundsc(y,f_a); % Sinus 

pause(5)

%% Abtastung bei f_a/2
y_aliasing = y(1:4:end);

subplot(2,2,3)
plot(y(1:1000),'k' );
subplot(2,2,4)
spectrogram(y_aliasing,256,250,256,1E3,'yaxis');   % Display the spectrogram
soundsc(y_aliasing,f_a/2); % Sinus 