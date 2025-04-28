#!/usr/bin/python3
import urllib.request
import urllib.parse
import time
import threading

class Producer(threading.Thread):
    def __init__(self,lis,event):
        super().__init__()
        self.lis=lis
        self.done=event
    
    def run(self):
        while True:
            if self.done.is_set():
                return
            self.lis.append(read_random(1,100))





def read_random(min,max,debug=False):
    if debug:
        print(urllib.parse.urlparse("https://pma.inftech.hs-mannheim.de/wsgi/rand?min="+str(min)+"&max="+str(max)))
    return int(urllib.request.urlopen("https://pma.inftech.hs-mannheim.de/wsgi/rand?min="+str(min)+"&max="+str(max)).read())



def main():
    lis=[]
    event=threading.Event()
    prods=[Producer(lis,event) for x in range(0,12)]
    start=time.time()
    for ele in prods:
        ele.start()
    while not 42 in lis and not 17 in lis:
        pass
    event.set()
    for ele in prods:
        ele.join()
    end=time.time()
    took=end-start
    print(took,"s: Zufallszahlen: ",len(lis))


if __name__ == '__main__':
    main()