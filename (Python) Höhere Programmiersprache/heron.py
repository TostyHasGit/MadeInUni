#!/usr/bin/python3
import sys

def heron(x,epsilon):
    x=float(x)
    epsilon=float(epsilon)
    a0=(1+x)/2
    a1=(a0+(x/a0))/2
    while abs(a0-a1>epsilon):
        a0=a1
        a1=(a0+(x/a0))/2
    return a1



def main(args):
    print("Hier Ihr Code")
    print(heron(args[0],args[1]))

if __name__ == '__main__':
    main(sys.argv[1:])    