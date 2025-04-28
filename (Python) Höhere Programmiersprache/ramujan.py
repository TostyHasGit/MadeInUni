#!/usr/bin/python3

def ramanujan(grenze):
    lis1=list(range(1,grenze))
    lis2=list(range(1,grenze))
    lis1=list(map(lambda x: x**3 ,lis1))
    lis2=list(map(lambda x: x**3 ,lis2))
    #print(lis1)
    #print(lis2)
    erg=[x+y for x in lis1 for y in lis2 if x>=y] 
    i=0
    ergfin=[x+y for x in lis1 for y in lis2 if x>=y] 
    lis1=list(range(1,grenze))
    lis2=list(range(1,grenze))
    erg2=[]  
    for ele in erg:
        if not ele in erg2:
            erg2.append(int(ele))
    erg2.sort()
    #print(erg2)
    for ele in erg2:
        ergfin.remove(int(ele))
    for x in range(0,len(lis1)):
        for y in range(0,len(lis2)):
            if i>=len(erg):
                break
            if x>=y and erg[i] in ergfin :
                print(lis1[x],"³ +",lis2[y],"³ =",erg[i])
                i+=1
            if x>=y:
                i+=1
    return ergfin

def main():
    print(ramanujan(15))


if __name__ == '__main__': 
    main()