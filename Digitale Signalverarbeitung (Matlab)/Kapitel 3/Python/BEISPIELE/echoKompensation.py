# -*- coding: utf-8 -*-
"""
 Echokompensation
 durch einen adaptiver Prädiktor 
 (c) HSM, B. Wir 2.8.2012, 
     Jorge Zuniga Le-Bert, Hochschule Mannheim 20.7.2021, (MATLAB to Python)
"""
import numpy as np
from adaptivfilter import lmsPredictor
import scipy.signal as signal               # signal.lfilter()
import matplotlib.pyplot as plt

#%% Simulation der Störung

Z = 4000                                    # Anzahl von Werte
x = np.random.randn(Z)
x[-50] = 8                                  # MATLAB: x(end-50) = 8                             
t = np.arange(0,100,1)                      # 100 k-Werte
y = signal.lfilter([1., 0, 0, 0, 0.8],1,x)
plt.figure(1)
plt.subplot(311)
plt.subplots_adjust(hspace=.8)
plt.plot(t,y[-100:], t, x[-100:],'r')
plt.title('Zufallssignal: rot, mit Echo: blau');
plt.xlabel('K -->')


#%% Echounterdrückung
"""
 Theorie: G(z)[1 - z^{-Delay)(W(z)] = 1

 für      G(z) = (1 + 0.8 z^-3) und Delay = 2

  ==>     W(z) =  0.8 z^-1  - 0.64 z^-4   + 0.5 z^-7  - .....

  ==>     w[k] =  [0  0.8  0  0  -0.64 0 0 0.5 ....]  
"""
#%% Adaptiver Prädiktor
N = 11                     # Filterordnung+1
DELAY = 2
STEP = 0.001    # 0.001
w = np.zeros(N)
echo_dach,e,w = lmsPredictor(w, DELAY, STEP, y)

plt.subplot(312)
plt.subplots_adjust(hspace=1.2)
plt.plot(t,e[-100:],'b', t, x[-100:]-e[-100:],'g')
#plt.text(0,5,'Echokompensation:blau, Rekonstruktionsfehler:grün');
plt.title('Echokompensation:blau, Rekonstruktionsfehler:grün');
plt.xlabel('K -->')
plt.subplot(313)
plt.stem(w)
plt.title('Koeffizienten w')
plt.xlabel('N -->')
print('Koeffizienten w = ',w)




