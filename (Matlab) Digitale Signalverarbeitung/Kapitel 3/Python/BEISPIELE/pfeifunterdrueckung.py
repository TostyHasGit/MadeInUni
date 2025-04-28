# -*- coding: utf-8 -*-
""" Pfeifunterdrückung
    durch einen adaptiver Prädiktor 
   (c) HSM, B. Wir 2.8.2012, 
   Jorge Zuniga Le-Bert, Hochschule Mannheim 30.7.2021 (MATLAB to Python)
"""
import numpy as np
from adaptivfilter import lmsPredictor
import scipy.signal as signal       # signal.lfilter()
from plot_zplane import zplane
import matplotlib.pyplot as plt

#%% Sinuston
F_A  = 4000                         # Abtastfrequenz in Hz
T_A = 1/F_A                         # Abtastabstand in s
WINDOW = 64                         # Fenster für Spektrogramm
F = 400                             # Sinus-Frequenz in Hz
t = np.arange(0,5000*T_A,T_A)       # column vector
x = np.sin (2*np.pi*F*t)            # Sinuston der Frequenz F  (col vector)
r = np.random.randn(np.size(t));
x_r = x + 0.5*r;
plt.figure(1)
plt.subplots_adjust(hspace=.1)
plt.subplot(411)
plt.plot(t[0:400],x_r[0:400])
plt.title('Zufallssignal + Sinus')

#%% Pfeifunterdrückung

N = 80                              # Filterordnung+1
DELAY = 5
STEP = 0.01/N
#  adaptive filtering
w = np.zeros(N)
y,e,w = lmsPredictor(w,DELAY, STEP,x_r)
plt.subplot(412)
plt.subplots_adjust(hspace=1)
plt.plot(t[1:400],y[1:400])
plt.title('Filterausgang -->Sinus')
plt.subplot(413)
plt.subplots_adjust(hspace=1)
plt.plot(t[1:400],e[1:400],'g')
plt.title('Fehlersignal-->Sprache')
plt.figure(2)
f, T, Sxx = signal.spectrogram(e,F_A)#, nperseg=WINDOW)
#plt.pcolormesh(T, f, Sxx,shading='gouraud')
plt.pcolormesh(T, f, Sxx,shading='nearest')
plt.ylabel('Frequency [Hz]')
plt.xlabel('Time [sec]')
plt.title('Spektrogramm e()')
plt.show()

plt.figure(3)
a = np.zeros(N)
a[0]=1
plt.title('Bandpass')
plt.grid(True)
zplane(w,a)
plt.figure(4)
plt.title('|G(f)|')
plt.grid(True)
f, G =signal.freqz(w,1,512)
plt.plot(f/np.pi,np.abs(G))
plt.show()
