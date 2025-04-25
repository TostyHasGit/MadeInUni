# -*- coding: utf-8 -*-
""" 
% DSV -Skript 
% Bandabtastung
% Setzt sehr gute Kenntniss in  der Systemtheorie voraus!! 
% B. Wir 23.1.03/ 22.9.2011/ 23.7.2011; JoZu (Python) 14 Juni 2021
"""
import numpy as np
import scipy.signal as signal        # upfirdn()
import matplotlib.pyplot as plt


N = 32                  # Anzahl der Werte
N3 = 3*N

# Bandbegrenztes Zufallssignal erzeugen 
x = np.random.randn(N3)
Xb = np.fft.fft(x)
Xb[0:N] = 0
Xb [N3-N+1 : N3] = 0
xb = np.real(np.fft.ifft(Xb))

#  Bandabtastung
xBandabtastung = xb[0:N3:3]
XBandabtastung = np.fft.fft(xBandabtastung)

ax1 = plt.subplot(421); 
ax1.plot(xb)
ax1.axis([1, N3 ,-2, 2])
ax1.set_title('Bandsignal')

ax2 = plt.subplot(422); 
ax2.plot(np.abs(np.fft.fftshift(Xb)))       #  Nullfrequenz im Zentrum
ax2.axis([1, N3 ,0, 20])
ax2.set_title('Spektrum')

ax3 = plt.subplot(423);
plt.subplots_adjust(hspace=1.2)
ax3.plot(xBandabtastung)
ax3.axis([1, N ,-2, 2])
ax3.set_title('Bandabgetastet')

ax4 = plt.subplot(424);
X2 = np.abs(np.fft.fftshift(XBandabtastung))
                  # = # [Nullen, XBandabstastung, Nullen]
XBasisbandspektrum = np.array([np.zeros(N),X2,np.zeros(N)]).reshape(3*N)    
ax4.plot(XBasisbandspektrum)
ax4.axis([1, N3 ,0, 10])
ax4.set_title('Basisbandspektrum')

# Einfügen von Nullen (upsampling)
# upfirdn(h, x, up=1, down=1, axis=-1, mode='constant', cval=0)
xUp = signal.upfirdn([1, 0, 0], xBandabtastung, up=3, down=1)
ax5 = plt.subplot(425); 
ax5.plot(np.real(xUp))
ax5.axis([1,N3 ,-2, 2])
ax5.set_title('Einfügen von Nullen')

XUp = np.fft.fft(xUp)
ax6 = plt.subplot(426); 
ax6.plot(np.abs(np.fft.fftshift(XUp)))       
ax6.axis([1, N3 ,0, 10])
ax6.set_title('Spektrum')

# % Bandpassfilter
XUp[0:N] = 0
XUp [2*N+1 : N3] = 0
xBand = np.real(np.fft.ifft(XUp))

ax7 = plt.subplot(427); 
ax7.plot(np.real(xBand))
ax7.axis([1,N3 ,-2, 2])
ax7.set_title('Bandsignal')

ax8 = plt.subplot(428); 
ax8.plot(3*np.abs(np.fft.fftshift(XUp)))      
ax8.axis([1, N3 ,0, 20])
ax8.set_title('Spektrum')

plt.show()          # Grafikausgabe
