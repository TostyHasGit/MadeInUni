#!/usr/bin/python3
import sys

def chars(lis):
    count=0
    for ele in lis:
        if "\n" in ele:
            count-=1
        for char in ele:
            if char!=" ":
                count+=1
    return count

def lines(lis):
    return len(lis)

def words(lis):
    count=1
    for ele in lis:
        if "\n" in ele and len(ele)>2:
            count+=1
        for char in ele:
            if char==" ":
                count+=1
    return count
                

def main(args):
    lis=[]
    with open("test.dat","r") as datei:
        for ele in datei:
            lis.append(ele)
    print(lines(lis) ," Zeilen") 
    print(words(lis)," Wörter")  
    print(chars(lis)," Zeichen")     
    print(lis)
        

if __name__ == '__main__':
    main(sys.argv[1:])