#!/usr/bin/python3
import fractions
import threading

class Ratstate(fractions.Fraction):

    def __init__(self,val,val2):
        self.bruch=fractions.Fraction(val,val2)
    
    def erhoehen(self,val):
        self.bruch+val.__call__
        return self

    def __sub__(self,val):
        return self.bruch-val

    def __call__(self):
        return self.bruch

class RatstateSafe(threading.Thread):

    def __init__(self,val,val2):
        threading.Thread.__init__(self)
        self.lock=threading.Lock()
        with self.lock:
            self.bruch=fractions.Fraction(val,val2)

    def erhoehen(self,val):
        with self.lock:
            self.bruch+val.__call__
            return self
    
    def __sub__(self,val):
        with self.lock:
            return self.bruch.__sub__(val)

    def __call__(self):
        with self.lock:
            return self.bruch





def main():
    pass


if __name__ == '__main__':
    main()