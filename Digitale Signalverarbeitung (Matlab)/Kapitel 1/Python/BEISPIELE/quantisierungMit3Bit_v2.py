# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 14:37:02 2021

@author: Jorge Zuniga Le-Bert (Python) Rev. WIR 8.Nov.21
"""

""" Quantisierung mit 3 Bit
%  Mit 3 Bit können die ganzen Zahlen von -4 bis 3 dargestellt werden.
%  Die Rauschleistung des Quantisierungsfehlers ist 1/12=0.083 pro
%  Abtastwert, das SNR ist 17.1dB. Das Quantisierungsrauschen hat eine 
%  gleichverteilte Amplitudenstatistik (rechts oben). Für die spezielle 
%  Signalform ist das Rauschspektrum jedoch nicht weiß (rechts unten).  
%  WIR 19.7.2012; 20.10.20 Kommentare ergänzt; Leckeffekt behoben
"""
import numpy as np
import matplotlib.pyplot as plt

#%% Signalerzeugung
BIT = 3
D = 0.0001
x = np.arange(-2**(BIT-1), (2**(BIT-1)-1)+D, D) # Quantisierung mit Delta=0.0001   

#Quantisierung und Berechnung von Rauschleistung und SNR
x_q = np.round(x) # Quantisieren mit Delta = 1
e_q = x - x_q

rauschleistung = np.sum(e_q**2)/(np.size(e_q))   #  np.size(e_q)= (length(e_q)
SNR_dB = 10*np.log10(np.sum(x**2)/np.sum(e_q**2))
#%% Ausgabe
print('SNR/dB = ',SNR_dB)
print('Rauschleistung = ',rauschleistung)
ax1 = plt.subplot(121); 
ax1.grid(True)
ax1.axis([-4.0, 4 ,-4.0, 4])
ax1.set_title('Quantisierung 3-Bit')
ax1.set_xlabel('Eingang')
ax1.set_ylabel('Quantisierung und Fehler')
ax1.plot(x,x, x, x_q,'r', x, e_q,'k--' )
ax1.legend(['Signal', 'Quantisierung','Fehler'])

ax2 = plt.subplot(222)
plt.subplots_adjust(hspace=0.8,left=-0.3)         # Abstand zwischen den Subplots 
ax2.grid(True)
ax2.set_title('LDS(e_Q)')
ax2.psd(e_q)   #, window='hann')

# mit Strg+1 nächsten Block auskommentieren, um das Histogram vom e_q zu zeichnen
ax3 = plt.subplot(224)
plt.subplots_adjust(hspace=0.7,left=-0.7) 
ax3.grid(True)
ax3.set_title('Statist des Rauschens e_Q')
ax3.set_ylabel('Häufigkeit')
ax3.set_xlabel('Wert')
ax3.hist(e_q, bins =11, facecolor='g')
plt.show()
