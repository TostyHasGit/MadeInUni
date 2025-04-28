%% aFaltung.m: Interpretation der Faltung
% Geben Sie fünf Möglichkeiten um eine Faltung zu interpretieren 
% und zeigen Sie diese am Beispiel [ 1 2 3] * [ 1 0 0 0 2] 
% 23.7.2012 (c) HSM B. Wir

g_k = [1 2 3] 
x_k = [ 1 0 0 0 2]


%% (i) Addition verschobener Signale 

y1_k =  1 * [ x_k   0   0   ] + ...
        2 * [  0   x_k  0   ] + ...
        3 * [  0    0  x_k  ]

%% (ii) Faltung

y2_k = conv(x_k,g_k)

%% (iii) FIR-Filter

y3_k = filter(g_k,1,[x_k 0 0])

%% (iv) Impulsantwort
y4_k = [ 1 2 3 0 0 0 0 ] + ...
       [ 0 0 0 0 2 4 6 ]
         
%% (v) Skalarprodukt

y5_k = [ [1 0 0]* g_k', [0 1 0]* g_k' , [0 0 1]* g_k', ...
         [0 0 0]* g_k', [2 0 0]* g_k' , [0 2 0]* g_k',[0 0 2]* g_k'] 
% Deutlicheres Beispiel:
x_k = [1 -2 3 -4] 
y_k = conv(x_k,g_k)
y_k = [ [ 1 0  0]* g_k', [-2 1 0]* g_k' , [3 -2  1]* g_k', ...
        [-4 3 -2]* g_k', [0 -4 3]* g_k' , [0  0 -4]* g_k']
     
y_k =([ 1  0 0 ;
       -2  1 0 ;
        3 -2 1 ;
       -4  3 -2 ;
        0 -4 3 ;
        0  0 -4 ] * g_k')'
    


