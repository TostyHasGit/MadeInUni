# -*- coding: utf-8 -*-

"""   Störunterdruckung
durch einen adaptiver Prädiktor
Ein Reporter macht ein Interview an einer stark befahrenen
Straße. Skizzieren Sie ein adaptives System (\(<5 \) Blöcke) zur
Kompensation des Straßenlärms und beschreiben Sie es in 2 bis 3
Sätzen.
 (c) HSM, B. Wir 2.8.2012, 
     Jorge Zuniga Le-Bert, Hochschule Mannheim 24.09.2021 (Matlab2Python)
"""

import numpy as np
from adaptivfilter import lms
import scipy.signal as signal                           # signal.decimate
import matplotlib.pyplot as plt
import scipy.io.wavfile as wavfile
# https://stackoverflow.com/questions/16719453/how-to-read-and-write-24-bit-wav-file-using-scipy-or-common-alternative
# https://im-coder.com/schreiben-der-wav-datei-in-python-mit-wavfile-schreiben-von-scipy.html
#import wave
# https://new.pythonforengineers.com/blog/audio-and-digital-signal-processingdsp-in-python/

#%% Signale
""" Störung """
Z = 40000                                       #  Abtastwerte
f_s, x_r = wavfile.read('road.wav')
x_r = np.asarray(x_r,dtype=np.float16)/30000.
x_r = x_r.reshape(2*len(x_r),1)
x_r = signal.decimate(x_r,4,n=80,ftype='fir',axis=0)
f_s = int(f_s/4)
x_r = x_r[0:Z]
wavfile.write('road_4.wav',f_s,x_r)   # Kann mit Media Player abgespielt werden
x_r = x_r[0:Z]
""" Nutzsignal"""
f_s, x_n = wavfile.read('speech_dft.wav')
f_s = int(f_s/2)
x_n = np.asarray(x_n,dtype=np.float16)/np.max(x_n)
x_n = signal.decimate(x_n,2,n=80,ftype='fir',axis=0)
x_n = x_n[0:Z]
wavfile.write('speech_dft_4.wav',f_s,x_n)       # mit Media Player abgespielen
x_n = x_n.reshape(len(x_n),1)

plt.figure(1)
plt.subplots_adjust(hspace=.5)
plt.subplot(211)
plt.plot(x_r)
plt.title('Hintergrundgeräusch')
plt.subplot(212)
plt.plot(x_n)
plt.title('Sprecher')

#%% Simulation der Störung
D     = 0.5                        # Distanz der Mikrophone in m
A     = 4                          # Mischfaktor der Störung im Nutzsignal
B     = 0.2                        # Mischfaktor des Nutzsignals in der Störung
delay = int(np.round((D/330)*f_s)) # ... in Abtasttakten
y_n   = x_n[delay-2:-1] + A * x_r[0:-1-(delay-2)]
wavfile.write('speech_y_n.wav',f_s,y_n) # Mit Media Player anhören
y_r   = B * x_n[0:-1-(delay-2)] + x_r[delay-2:-1]
wavfile.write('speech_y_r.wav',f_s,y_r) # Mit Media Player anhören

#%% Signalrekonstruktion
N = 30                              # Filterordnung
w = np.zeros((N,1))
STEP = 0.07

x_n_dach, e, w = lms(w, y_r, y_n, STEP)     # Adaptiv filtern
wavfile.write('sprecher.wav',f_s,e)         # Mit Media Player anhören 
wavfile.write('beatle.wav',f_s,x_n_dach)    # Mit Media Player anhören

plt.figure(2)
plt.subplots_adjust(hspace=.5)
plt.subplot(221)
plt.plot(y_n[0:9999])
plt.title('Sprecher(t)+Alpha*Hintergrund(t-dt)')

plt.subplot(223)
plt.subplots_adjust(hspace=.5)
plt.plot(y_r[0:9999])
plt.title('Hintergrund(t)+Beta*Sprecher(t-dt)')

plt.subplots_adjust(hspace=.5)
plt.subplot(222)
plt.plot(e[0:9999])
plt.title('Sprecherschätzung (t)')

plt.subplot(224)
plt.subplots_adjust(hspace=.5)
plt.plot(w)
plt.title('Filterkoeffizienten')


