#!/usr/bin/python3
import sys

def compute(v1, op, v2):
    v1=float(v1)
    v2=float(v2)
    x=0
    print(v1)
    print(op)
    print(v2)
    if op=="+":
        x=v1+v2
    elif op=="-":
        x=v1-v2
    elif op=="x":
        x=v1*v2
    elif op=="/":
        x=v1/v2
    return x
        

def main(args):
    print("Hier Ihr Code")
    print(compute(args[0],args[1],args[2]))

if __name__ == '__main__':
    main(sys.argv[1:])    