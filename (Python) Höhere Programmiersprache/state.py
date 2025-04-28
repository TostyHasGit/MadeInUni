#!/usr/bin/python3

import random
from Ratstate import Ratstate,RatstateSafe
import threading
import fractions

def runnable(ins):
    actres=RatstateSafe(1,3)
    for i in range(0,200000):
        x=random.randint(-1000,1000)
        y=random.randint(1,10)
        actres.erhoehen(RatstateSafe(x,y))
        ins.erhoehen(Ratstate(x,y))
    print(ins,actres)

def main():
    r=Ratstate(1,3)
    tr1=threading.Thread(target=runnable(r))
    tr2=threading.Thread(target=runnable(r))
    tr3=threading.Thread(target=runnable(r))
    tr4=threading.Thread(target=runnable(r))
    tr5=threading.Thread(target=runnable(r))
    tr6=threading.Thread(target=runnable(r))
    tr7=threading.Thread(target=runnable(r))
    tr8=threading.Thread(target=runnable(r))
    tr9=threading.Thread(target=runnable(r))
    tr10=threading.Thread(target=runnable(r))
    tr1.start()
    tr2.start()
    tr3.start()
    tr4.start()
    tr5.start()
    tr6.start()
    tr7.start()
    tr8.start()
    tr9.start()
    tr10.start()
    tr1.join()
    tr2.join()
    tr3.join()
    tr4.join()
    tr5.join()
    tr6.join()
    tr7.join()
    tr8.join()
    tr9.join()
    tr10.join()




if __name__ == '__main__':
    main()