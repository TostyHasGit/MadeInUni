#!/usr/bin/python3

import sys
import threading
import random
import time

class Particle(threading.Thread):
    pos=[]
    @classmethod
    def test(cls,x):
        cls.pos.append(x)
    @classmethod
    def test2(cls,x):
        return cls.pos
    def __init__(self):
        super().__init__()
        self.x=random.randint(4,6)*0.1
        self.y=random.randint(4,6)*0.1
        self.paus=threading.Event()
        self.stopi=threading.Event()
        self.lock=threading.Lock()
        self.pause()
        self.start()
        self.test(self)
    def run(self):
        amx=random.randint(1,10)*0.001
        amy=random.randint(1,10)*0.001
        testx=True
        testy=True
        while not self.stopi.is_set():
            #print(self.x,self.y)
            if not self.paus.is_set():
                #print(self.x,self.y)
                with self.lock:
                    for ele in self.test2(self):
                        if ele!=self:
                            if ele.x-0.015<self.x<ele.x+0.015 and ele.y-0.015<self.y<ele.y+0.015:
                                testx=not testx
                                testy=not testy
                    if testx:
                        self.x-=amx
                        if self.x<=0:
                            self.x+=amx
                            testx=False
                    else:
                        self.x+=amx
                        if self.x>=1:
                            self.x-=amx
                            testx=True
                    if testy:
                        self.y-=amy
                        if self.y<=0:
                            self.y+=amy
                            testy=False
                    else:
                        self.y+=amy
                        if self.y>=1:
                            self.y-=amy
                            testy=True
                    for ele in self.test2(self):
                        if ele!=self:
                            if ele.x-0.015<self.x<ele.x+0.015 and ele.y-0.015<self.y<ele.y+0.015:
                                testx=not testx
                                testy=not testy
                    print(self.x,self.y)
                    #print(amx,amy)
            time.sleep(0.1)
                     
                
    def get_position(self):
        with self.lock:
            return float(self.x),float(self.y)
    def pause(self):
        self.paus.set()
    def cont(self):
        self.paus.clear()
    def stop(self):
        self.stopi.set()

