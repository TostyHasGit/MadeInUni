#!/usr/bin/python3
import sys

def argument(arg):
    vor=arg[0]
    vor2=0
    lis=[arg[0]]
    count=[0]
    for idx in range(0,len(arg)):
        if arg[idx]!=vor:
            lis.append(arg[idx])
            count.append(1)
            vor2+=1
            vor=arg[idx]
        else:
            count[vor2]+=1
    erg=''
    for idx,ele in enumerate(lis):
        erg+=ele
        erg+=str(count[idx])
    return erg

def main(args):
    for ele in args:
        print(argument(ele))

if __name__ == '__main__':
    main(sys.argv[1:])