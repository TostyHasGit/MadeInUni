# -*- coding: utf-8 -*-
"""
Created on Fri Sep 24 12:36:33 2021

@author: Jorge Zuniga Le-Bert
"""
import numpy as np   

def lmsPredictor(W,delay,step,x):
   """
********************************************************************
* Desctiption: lmsPredictor() 
*     Adaptive predictor using LMS adaptation and a FIR Filter
********************************************************************
 Aufruf:       y,e,W = lmsPredictor(W,delay,step,x)
                    
                W           - initial coefficients (column vector -usually zero) 
                delay       - signal delay before adaptation
                step        - speed of adaptation (< 1/N*signalpower)
                x           - signal input (column vector)
                y           - filter output (column vector) 
                e           - error output  (column vector)	
                W           - final coefficients (column vector)
 ver. 1.0/ 3.4.97  1.0/2.8.12;  
 by Bernhard Wirnitzer  Bosch FV/FLI
 Version 1.0/ 20/07/2021 (Python) by Jorge Zuniga Le-Bert; DS Institut HS MA
   """

   y        = np.zeros(np.size(x),dtype='float32')
   e        = np.zeros(np.size(x),dtype='float32')
   N        = np.size(W)
   nullen   = np.zeros(N+delay-1)
   x_d      = np.concatenate((nullen,x), axis=0)
   W        = np.flipud(W)                   # Reihenfolge umkehren

   for k in range(0,np.size(x)):
       x_   = x_d[k:k+(N)]                # signal vector mit N Werte

       x_T    = np.reshape(x_, (N,1))
       y[k]   = np.dot(W,x_T)   

       e[k] = x[k] - y[k]                   # error
       W    = W + 2*step*e[k]*x_              # LMS
   W    = np.flipud(W)
   return y,e,W




def lms(W, x, d, step):
   """
********************************************************************
* Desctiption: lms() 
*     Adaptive predictor using LMS adaptation and a FIR Filter
********************************************************************
 Aufruf:       y,e,W = lms(W, x, d, step)
                    
                W       - initial coefficients (column vector -usually zero) 
                x       - signal input (column vector)
                d       - desired sigal (reference) (column vector)
                step    - speed of adaptation (< 1/N*signalpower)                
                y       - filter output (column vector) 
                e       - error output  (column vector)	
                W       - final coefficients (column vector)
 ver. 1.0/ 3.4.97  1.0/2.8.12;  
 by Bernhard Wirnitzer  Bosch FV/FLI
 Version 1.0; 24/09/2021 (Python) by Jorge Zuniga Le-Bert; DS Institut HS MA
   """

   y        = np.zeros((np.size(x),1),dtype='float32')
   e        = np.zeros((np.size(x),1),dtype='float32')
   N        = np.size(W)
   nullen   = np.zeros(N-1 ,dtype='float32')
   nullen   = nullen.reshape(len(nullen),1) 
   x_d      = np.concatenate((nullen,x), axis=0)  # verzögertes x
   
   W        = np.flipud(W)                   # row2col
   for k in range(0,np.size(x)):
       x_   = x_d[k:k+(N)]                   # signal vector (N Wete)

       y[k]   = np.dot(W.T,x_)              # Zeile x Spalte = 1 Wert

       e[k]   = d[k] - y[k]                   # error
       W      = W + 2*step*e[k]*x_            # LMS
       
   W    = np.flipud(W)
   return y,e,W
