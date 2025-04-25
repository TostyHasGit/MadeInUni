# -*- coding: utf-8 -*-
"""
Created on Thu Jul 15 12:47:22 2021

@author: Jorge Zuniga Le-Bert  (Python) Rev. WIR 8.11.21
"""
"""
 JitterSNR

 Ein EKG-Messgerät arbeitet mit der Abtastfrequenz f_a = 400Hz und einem
 16-Bit AD-Wandler. Aus ungeklärten Gründen schwankt der Abtastzeitpunkt 
 im rms-Mittel (root mean square) um 0,01ms (==> 100khz).
 (i) Welches SNR erwarten Sie für ein Sinus-Testsignal mit der Frequenz
 100Hz und bzw. 10Hz. Schätzen Sie den Einfluss durch Jitter  
 (Phasenrauschen)und durch Quantisierungsrauschen getrennt voneinander ab.    
 (ii) Simulieren Sie den Frequenzgang des Phasenrauschens, falls ein 100Hz
 und 10 Hz Signal mit Jitter abgtastet wird. 
 B. WIR 22.10.2020; JoZu 15.07.2021 (Python)
"""
import numpy as np
#import scipy.signal as signal                  # upfirdn()
import matplotlib.pyplot as plt


# (i) Theorie SNR des Jitter
f_a = 400                                       # Hz
f_in_100 = 100                                  # Hz
f_in_10  = 10                                   # HZ
t_j = 1e-6                                      # s

SNR_j_100 = - 20*np.log10(2*np.pi*f_in_100*t_j) # siehe Skript
SNR_j_10 = - 20*np.log10(2*np.pi*f_in_10*t_j)
# print('SNR_j bei 100Hz :',SNR_j_100)            # Jitter stärker bei Hohen f
# print('SNR_j bei 10Hz :',SNR_j_10)
"""
 SNR durch Quantisierung
 SNR_16BIT = 16 * 6   % grob 6dB/Bit; im Detail 6.02 dB/Bit + 1,77 siehe Skript

 Fazit: Das durch Quantsierung verursachte Rauschen ist vernachlässigbar.
 Es wirkt sich jeweils nur das Jitter-Rauschen aus. Das Jitter-SNR verschlechtert 
 sich mit 20dB/Dekade bezogen auf die Frequenz des Eingangssignals.  
"""
# %% (ii) Simulation
f_sim = f_a*100 # in Hz ; Abtastung für die Simulation
t = np.arange(0, (60-1/f_sim)+1/f_sim, 1/f_sim ) # Zeitachse
f_10  = 10                                     #Hz
f_100 = 100                                    #Hz
X_10  = np.sin(2*np.pi*f_10*t)
X_100 = np.sin(2*np.pi*f_100*t)

ax1 = plt.subplot(331);
plt.subplots_adjust(hspace=1)         # Abstand zwischen den Subplots 
ax1.plot(t[0:10000],X_10[0:10000])
#ax1.axis([1, N3 ,-2, 2])
ax1.set_title('(quasi analoge) Testsignale)')
plt.ylabel( 'y = sin(t)')
plt.xlabel('Sekunde')
ax1.plot(t[0:10000],X_100[0:10000])

# Abtastung mit Jitter
rms_jitter = 1.0e-6
t_a = t[0:np.size(t):np.int(f_sim/f_a)]
t_jitter = t_a + rms_jitter*np.random.randn(np.int(np.size(t_a)))

X_10_j  = np.sin(2*np.pi*f_10*t_jitter)
X_100_j = np.sin(2*np.pi*f_100*t_jitter)
X_10_a  = np.sin(2*np.pi*f_10*t_a)
X_100_a = np.sin(2*np.pi*f_100*t_a)

ax4 = plt.subplot(334); 
ax4.plot(t_a[0:100],X_10_j[0:100])
ax4.set_title('abgetastet mit Jitter')
plt.xlabel('Sekunde')
ax4.plot(t_a[0:100],X_100_j[0:100])

ax7 = plt.subplot(337); 
ax7.plot(t_a[0:100],X_10_a[0:100])
ax7.set_title('abg. ohne Jitter')
plt.xlabel('Sekunde')
ax7.plot(t_a[0:100],X_100_a[0:100])

#%%  Die Funktion snr() vom MATLAB gibt es nit im Python








