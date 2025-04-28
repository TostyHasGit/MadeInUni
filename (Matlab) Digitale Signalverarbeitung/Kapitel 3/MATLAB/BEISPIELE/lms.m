
function [y,e,w] = lms(w,x,d,step)
% Adaptive LMS FIR-filter  
%
% w 		- initial coefficients (row vector -usually zero) 
% x		    - signal input (row vector)
% d         - desired sigal (reference) (row vector) 
% y         - filter output (row vector) 
% e		    - error output  (row vector)	
% ver. 1.0/ 3.4.97  1.0/2.8.12 
% by Bernhard Wirnitzer  Bosch FV/FLI

y = zeros(size(x));
e = zeros(size(x));

N = length(w); 
x_d = [zeros(1,N-1),x]; % delay and zero
w = fliplr(w); 

for k = 1:length(x)
    x_   =  x_d(k:k+(N-1));      % signal vector
    y(k) =  w  * x_' ;           % filter
	e(k) = d(k) - y(k);          % fehler   
    w    = 	w  + step * e(k)* x_ ;% LMS					 
end

w = fliplr(w);
