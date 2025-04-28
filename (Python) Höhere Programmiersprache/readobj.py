#!/usr/bin/python3
import sys
from PIL import Image 
from PIL import ImageDraw 

def objread(datei):
    lis=[]
    lis3=[]
    with open(datei) as datei:
        for line in datei:
            if not line[0]=='#' and not line=='\n' and not line[0]=='f':
                lis2=[]
                tmp=line.strip(' ')
                tmp=tmp.strip('\n')
                tmp=tmp[1:]
                tmp=tmp.split()
                lis.append(tuple(tmp))
            if not line[0]=='#' and not line=='\n' and not line[0]=='v':
                lis2=[]
                tmp=line.strip(' ')
                tmp=tmp.strip('\n')
                tmp=tmp[1:]
                tmp=tmp.split()
                lis3.append(tuple(tmp))   
    return (lis,lis3)

def machebild(punkte, name="bild", mode="xy"):
    im = Image.new("1", (400,400))
    im2= Image.new("1", (400,400))
    im3= Image.new("1", (400,400))
    draw= ImageDraw.Draw(im)
    draw2= ImageDraw.Draw(im2)
    draw3= ImageDraw.Draw(im3)
    for ele in punkte[1]:
        draw.polygon([(int(float(punkte[0][int(ele[0])-1][0])),int(float(punkte[0][int(ele[0])-1][1]))),
        (int(float(punkte[0][int(ele[1])-1][0])),int(float(punkte[0][int(ele[1])-1][1]))),
        (int(float(punkte[0][int(ele[2])-1][0])),int(float(punkte[0][int(ele[2])-1][1])))],outline=128)
        draw2.polygon([(int(float(punkte[0][int(ele[0])-1][0])),int(float(punkte[0][int(ele[0])-1][2]))),
        (int(float(punkte[0][int(ele[1])-1][0])),int(float(punkte[0][int(ele[1])-1][2]))),
        (int(float(punkte[0][int(ele[2])-1][0])),int(float(punkte[0][int(ele[2])-1][2])))],outline=128)
        draw3.polygon([(int(float(punkte[0][int(ele[0])-1][1])),int(float(punkte[0][int(ele[0])-1][2]))),
        (int(float(punkte[0][int(ele[1])-1][1])),int(float(punkte[0][int(ele[1])-1][2]))),
        (int(float(punkte[0][int(ele[2])-1][1])),int(float(punkte[0][int(ele[2])-1][2])))],outline=128)
    im=im.rotate(180)
    im2=im2.rotate(180)
    im3=im3.rotate(180)
    if mode=="None":
        return
    if mode=="xy" or mode=="all":
        im.save(name+"_xy.png")
    if mode=="xz" or mode=="all":
        im2.save(name+"_xz.png")
    if mode=="yz" or mode=="all":
        im3.save(name+"_yz.png")

                    

def main(args):
    machebild(objread("dreiecke.obj"),"dreiecke","all")
    

if __name__ == '__main__':
    main(sys.argv[1:])