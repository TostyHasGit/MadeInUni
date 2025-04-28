#!/usr/bin/python3
import sys
import PIL.Image as Image

def heller(value,img,cols,rows):
    value = int(value)
    tmp=rows
    if value > 100 or value < -100:
        return
    while cols >=0:
        while rows >=0:
            v = img.getpixel((cols-1,rows-1)) + value/100 * 255
            img.putpixel((cols-1,rows-1), int(v))
            rows=rows-1
            #print(rows)
        rows=tmp
        cols=cols-1    
        #print(cols)


def gamma(value,img,cols,rows):
    value = float(value)
    tmp=rows
    if value > 10.0 or value < 0.0:
        return
    while cols >=0:
        while rows >=0:
            v = 255 * ((img.getpixel((cols-1,rows-1))/255)**value)
            img.putpixel((cols-1,rows-1), int(v))
            rows=rows-1
            #print(rows)
        rows=tmp
        cols=cols-1    
        #print(cols)

def getmax(img):
    cols2, rows2 = img.size
    tmp=rows2
    tmp2=0
    while cols2 >=0:
        while rows2>=0:
            v=img.getpixel((cols2-1,rows2-1))
            if v > tmp2:
                tmp2=v
            rows2=rows2-1
        cols2=cols2-1
    return tmp2

def getmin(img):
    cols1, rows1 = img.size
    tmp=rows1
    tmp2=255
    while cols1 >=0:
        while rows1>=0:
            v=img.getpixel((cols1-1,rows1-1))
            if v < tmp2:
                tmp2=v
            rows1=rows1-1
        cols1=cols1-1
    return tmp2


def spreizen(value,img,cols,rows):
    value = int(value)
    tmp=rows
    a=getmin(img)
    b=getmax(img)
    if value > 100 or value < 0:
        return
    while cols >=0:
        while rows >=0:
            if(value<100):
                a=a*((100-value)/100)
                b=b+(255-b)*(value/100)
            v = 255 * ((img.getpixel((cols-1,rows-1)) - a)/(b-a))
            #print(v)
            #print(img.getpixel((cols-1,rows-1)))
            img.putpixel((cols-1,rows-1), int(v))
            rows=rows-1
            #print(rows)
        rows=tmp
        cols=cols-1    
        #print(cols)

def binarisieren(value,img,cols,rows):
    value = int(value)
    tmp=rows
    if value > 255 or value < 0:
        return
    while cols >=0:
        while rows >=0:
            v=img.getpixel((cols-1,rows-1))
            if(v>=value):
                img.putpixel((cols-1,rows-1), 255)
            else:
                img.putpixel((cols-1,rows-1), 0)
            rows=rows-1
            #print(rows)
        rows=tmp
        cols=cols-1    
        #print(cols)

def main(args):
    img= Image.open(args[2])
    cols, rows = img.size
    if args[0]=="heller":
        heller(args[1],img,cols,rows)
    elif args[0]=="gamma":
        gamma(args[1],img,cols,rows)
    elif args[0]=="spreizen":
        spreizen(args[1],img,cols,rows)
    elif args[0]=="binarisieren":
        binarisieren(args[1],img,cols,rows)
    img.save(args[3])


if __name__ == '__main__':
    main(sys.argv[1:])    