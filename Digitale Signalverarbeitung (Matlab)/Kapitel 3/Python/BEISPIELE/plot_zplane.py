# -*- coding: utf-8 -*-
#
# Copyright (c) 2011 Christopher Felton
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# The following is derived from the slides presented by
# Alexander Kain for CS506/606 "Special Topics: Speech Signal Processing"
# CSLU / OHSU, Spring Term 2011.
"""
The zplane function takes the numerator and denominator polynomial representation of a transfer function and plots the complex z-plane poles and zeros.

 

H(z) = \frac{b_0 + b_1z^{-1} + ... + b_Nz^{-N}}{a_0 + a_1z^{-1} + ... + a_Nz^{-N}}

 

For those unfamiliar with a numerical computing package, polynomials are usually represented least order coefficient to the highest order coefficient.  An array assignment might look like the following, where *N* is the polynomial order.

b\_array = [b_0, b_1, ..., b_{N-2}, b_{N}]

The function below will plot a complex zplane given an array of b and a coefficients, numerator and denominator respectively. 

This code requires the following packages:

    matplotlib (plotting routines)
    numpy  (array object and roots)

Example usage:

H(z) = \frac{z^{-1} + z^{-2}}{1 + \frac{1}{4}z^{-1} - \frac{3}{8}z^{-2}}


>>> import numpy as np
# If the code is in a file called plot_zplane.py
>>> from plot_zplane import zplane 
>>> b = np.array([0, 1, 1])
>>> a = np.array([1, 1/4., -3/8.])
>>> zplane(b,a)

"""
import numpy as np
import matplotlib.pyplot as plt
from  matplotlib import patches
from matplotlib.figure import Figure
from matplotlib import rcParams
    
def zplane(b,a,filename=None):
    """
Plot the complex z-plane given a transfer function.
The function below will plot a complex zplane given an array of b 
and a coefficients, numerator and denominator respectively. 

This code requires the following packages:

matplotlib (plotting routines)
numpy  (array object and roots)

Beispiel:
import numpy as np
# If the code is in a file called plot_zplane.py
>>> from plot_zplane import zplane 
>>> b = np.array([0, 1, 1])
>>> a = np.array([1, 1/4., -3/8.])
>>> [z,p,k] = zplane(b,a)
Quelle:https://www.dsprelated.com/showcode/244.php"""


    # get a figure/plot
    ax = plt.subplot(111)

    # create the unit circle
    uc = patches.Circle((0,0), radius=1, fill=False,
                        color='black', ls='dashed')
    ax.add_patch(uc)

    # The coefficients are less than 1, normalize the coeficients
    if np.max(b) > 1:
        kn = np.max(b)
        b = b/kn     #b = b/float(kn)
    else:
        kn = 1

    if np.max(a) > 1:
        kd = np.max(a)
        a = a/kd     #a = a/float(kd)
    else:
        kd = 1
        
    # Get the poles and zeros
    p = np.roots(a)
    z = np.roots(b)
    k = kn/kd       #k = kn/float(kd)
    
    # Plot the zeros and set marker properties    
    t1 = plt.plot(z.real, z.imag, 'go', ms=10)
    plt.setp( t1, markersize=10.0, markeredgewidth=1.0,
              markeredgecolor='k', markerfacecolor='g')

    # Plot the poles and set marker properties
    t2 = plt.plot(p.real, p.imag, 'rx', ms=10)
    plt.setp( t2, markersize=12.0, markeredgewidth=3.0,
              markeredgecolor='r', markerfacecolor='r')

    ax.spines['left'].set_position('center')
    ax.spines['bottom'].set_position('center')
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)

    # set the ticks
    r = 1.5; 
    plt.axis('scaled'); 
    plt.axis([-r, r, -r, r])
    ticks = [-1, -.5, .5, 1]; 
    plt.xticks(ticks); 
    plt.yticks(ticks)

    if filename is None:
        plt.show()
    else:
        plt.savefig(filename)
    

    return z, p, k

def meinFIR(x,b,zi):
    N=np.size(b)
    x_=np.zeros(N)
    x_[0]=x
    x_[1:]=zi
    zf=x_[0:-1]
    yk=np.dot(b,np.reshape(x_, (N,1)))    
    return yk,zf



# def meinFIR (x, b, zi):
#    """
# Created on Mon May 10 15:20:31 2021
#         MA Filterfunktion
#         Filtert nach der Differenzengleichung
        
#         y[k] = bo x[k] +b1 x[k-1]+b2 x[k-3]+...+bN-1 x[k-(N-1]
                                                          
# Aufruf:         [yk,zf] = meinFIR(xk,b,zi)

# Eingangsparam:  xk  : momentaner x-Wert, x[k] (Skalar)
#                  b  : N-Koeffizienten [bo, b1, b2,...bN-1]
#                  zi : N-1 vergangene Werte x[k-1], x[k-2],...x[k-(N-1)]
# Ausgansparam :  yk  : momentaner y-Wert y[k] (Skalar)
#                 zf  : neuer Buffer, nach dem Filtern            
# @author: Jorge Zuniga Le-Bert"""
# def meinFIR (x,b,zi):
    
#     x_ = np.array(ndim=np.size(b))
#     x_ = [x,zi]
#     y = x_*b(,1)
#     return yk,Zf
