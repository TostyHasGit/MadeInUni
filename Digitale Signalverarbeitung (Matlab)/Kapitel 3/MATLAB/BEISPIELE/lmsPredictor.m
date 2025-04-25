
function [y,e,w] = lmsPredictor(w,delay,step,x)
% Adaptive predictor using LMS adaptation and a  
% FIR filter
%
% w 		- initial coefficients (row vector -usually zero) 
% delay		- signal delay before adaptation
% step		- speed of adaptation (< 1/N*signalpower)
% x		    - signal input (row vector)
% y         - filter output (row vector) 
% e		    - error output  (row vector)	
% ver. 1.0/ 3.4.97  1.0/2.8.12 
% by Bernhard Wirnitzer  Bosch FV/FLI

y = zeros(size(x));
e = [];
N = length(w); 
x_d = [zeros(1,N+delay-1),x]; % delay and zero
w = fliplr(w); 

for k = 1:length(x)
    x_   =  x_d(k:k+(N-1));      % signal vector
    y(k) =  w  * x_' ;           % filter
	e(k) = x(k) - y(k);          % fehler   
    w    = 	w  + step * e(k)* x_ ;% LMS					 
end

w = fliplr(w);
