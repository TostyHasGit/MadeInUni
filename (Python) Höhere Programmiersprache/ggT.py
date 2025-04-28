#!/usr/bin/python3

from functools import reduce
import sys

def ggT(x,y):
    if y>x:
        x,y=y,x
    while x>y and x%y!=0:
        x=x%y
        if y>x:
            x,y=y,x
    return y

def ggTl(x,y,*pos):
    return reduce(ggT, list(pos), ggT(x,y))

def ggTr(x,y):
    if x==0:
        return y
    if x>=y:
        return ggTr(x-y,y)
    else:
        return ggTr(y,x)
    return 1

def main():
    lines=[] 
    erg=[] 
    i=0
    for line in open("ggts.dat"):
        lines.append(int(line))
    for ele in lines:
        if i%2==0:
            erg.append(ggT(lines[i],lines[i+1]))
    avr=0
    for ele in erg:
        avr=avr+ele
    avr=avr/len(erg)
    print(avr)
    #print(ggTr(x,y))
    #print(ggT(x,y))
    #print(ggTl(x,y,z,w))

if __name__ == '__main__': 
    main()

