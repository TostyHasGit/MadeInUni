#!/usr/bin/python3

class Set:
    "Eine Klasse Menge"
    def __init__(self,seq=[]):
        self.men=list(seq)
        self.men.sort()
    
    def add(self,ele):
        if not ele in self.men:
            self.men.append(ele)
        self.men.sort()
        #print(self)
    
    def union_update(self,seq):
        for ele in seq:
            self.add(ele)
    
    def union(self,seq):
        s = Set()
        for ele in self:
            if ele in seq:
                s.add(ele)
        return s

    def remove(self,ele):
        if ele in self:
            self.men.remove(ele)
        self.men.sort()

    def difference_update(self, seq):
        for ele in seq:
            self.remove(ele)

    def difference(self,seq):
        s=Set()
        for ele in self:
            if ele not in seq:
                s.add(ele)
        return s

    def clear(self):
        self.men.clear()

    def size(self):
        return len(self.men)

    __len__=size

    def __getitem__(self,seq):
        return self.men[seq]
    
    def __repr__(self):
        return str(self.men)

    def __eq__(self,seq):
        return self.men==seq
    
    def __ne__(self,seq):
        return self.men!=seq

    def __add__(self,seq):
        for ele in seq:
            self.add(ele)
        return self

    __radd__=__add__

    def __sub__(self,seq):
        for ele in seq:
            self.remove(ele)


            

if __name__ == '__main__':
    main()