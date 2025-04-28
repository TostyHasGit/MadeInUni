#!/usr/bin/python3
import threading
import time
import random

class Producer(threading.Thread):
    def __init__(self,queue,char,event):
        super().__init__()
        self.char=char
        self.queue=queue
        self.done=event
    
    def run(self):
        while True:
            if self.done.is_set():
                return
            x=random.randint(0,100)/1000
            time.sleep(x)
            self.queue.append(self.char)

class Consumer(threading.Thread):
    def __init__(self,count,queue,event):
        super().__init__()
        self.queue=queue
        self.done=event
        self.count=count
        self.dic={}
    
    def run(self):
        while True:
            if self.count in list(self.dic.values()):
                self.done.set()
            if self.done.is_set():
                for ele in self.dic:
                    if self.dic[ele]==self.count:
                        print(ele)
                return
            if self.queue:
                tmp=self.queue.pop(0)
                self.dic.setdefault(tmp,0)
                self.dic[tmp]+=1



def main():
    queue=[]
    event=threading.Event()
    lis=[Producer(queue,chr(x),event) for x in range(97,123)]
    for ele in lis:
        ele.start()
    con=Consumer(100,queue,event)
    con.start()
    for ele in lis:
        ele.join()
    con.join()

if __name__ == '__main__':
    main()