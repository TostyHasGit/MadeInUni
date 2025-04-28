%% LABOR: (i) Erzeugen Sie ein Testsignal aus Pfeifen und überlagertem Rauschen.
% (ii) Optional, falls Sie neugiewrig sind, können Sie auch ihre eigene 
%       Sprache aufnehmen und zum Pfeifen addieren.
% (c)HSM B. WIR 29.3.2021, 18.2.22 

%% (i) peepAndSound.m aus dem Order SKRIPT zeigt wie man Pfeifen erzeugt
%      und als Audiosignal ausgibt.Verwenden Sie die Funktion rand.m um
%      rauschen zu addieren. 
clear all; close all;

f_a = 16000; %Hz 
f_sinus = 200; %HZ
vektor_t=0:1/f_a:3; %3 s
% vektor_x = sin (...........);  % ab hier sind Sie gefragt

% .... 

%%  Rauschen dazu

help rand %  hier die Beschreibung von rand.m

% x_r = vektor_x + 0.5* rand(....) 
% plot(x_r(1:1000),'r');
% soundsc(x_r,f_a); 


%% (ii) Jetzt noch Sprache dazu
% ..erst aufnehmen
 help soundsc; % mal sehen ob da ganz unten ein Hinweis auf eine Audioaufnahme kommt 

%   ..... ab hier sind Sie gefragt  
    
