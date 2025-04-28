#!/usr/bin/python3
import sys

def main(args):
    lis={}
    for ele in args:
        if ele not in lis:
            lis[ele]=1
        else:
            lis[ele]+=1
    print(lis)
    erg=list(lis.items())
    erg.sort(key=lambda t: t[1])
    occs = erg[-1][1]
    print([k for k in lis if lis[k] == occs])



if __name__ == '__main__':
    main(sys.argv[1:])