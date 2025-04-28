#!/usr/bin/python3
#######################################
# Simultaion des DMC Speicherversuchs #
#                                     #
# mem_sim.py                          #
# Prof. Kurt Ackermann, HS-Mannheim   #
# V 1.0 - 2022                        #
# #####################################

from tkinter import *
from tkinter import messagebox
import random

hex_chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']

RAM = []
for i in range(2**15):
    RAM.append(0)

ROM = []
for i in range(2**13):
    ROM.append(random.randint(1,255))

LATCH = 0

#for z in range(10):
#    print(ROM[z])

# virtual oe (active low) signal for user applied data
user_data_oe_n = 1

addr = 0x0000
data = 0x00
ROM_addr_range = range(0xE000, 0x10000) # right side must be +1
RAM_addr_range = range(0, 0x8000)       # right side must be +1

root = Tk()
root.title('DMC')
root.resizable(0,0) # disable maximize window icon

# radiobutton - function call
def sel():
    global data     # direct access to global variables
    global RAM
    global LATCH
    global user_data_oe_n
    
    reproc = 0      # variable signalizes if data has changed and requires reqprocessing

    if (user_data_oe_n==1 and not((oe.get()==0 and addr in ROM_addr_range) or (oe.get()==0 and addr in RAM_addr_range) or L_oe.get()==0)):
        hex_d.config(text = '--')
        data = -1
        
    # disable data-input if data-bus is controlled by memory
    if ((oe.get()==0 and addr in ROM_addr_range) or (oe.get()==0 and addr in RAM_addr_range) or L_oe.get()==0):
        b2['state'] = DISABLED
        user_data_oe_n = 1      # take user data from bus
    else:
        b2['state'] = NORMAL
    # show ERROR on multiple access to data-bus
    if (((oe.get()==0 and addr in ROM_addr_range) or (oe.get()==0 and addr in RAM_addr_range)) and L_oe.get()==0):
        messagebox.showerror("Bus-Konflikt", "Kurzschluss auf Datenbus")
    # regular operation
    else:
        # READ ROM
        if (oe.get()==0 and addr in ROM_addr_range):
            if (ROM[addr&0x1FFF] != data):
                reproc = 1
                data = ROM[addr&0x1FFF]
                tmp = str(hex(data))
                tmp = tmp[2:]   #remove "0x" from string
                while len(tmp)<2:
                    tmp = '0'+tmp        
                hex_d.config(text = tmp.upper())
        # READ RAM
        if (oe.get()==0 and addr in RAM_addr_range):
            if (RAM[addr&0x7FFF] != data):
                reproc = 1
                data = RAM[addr&0x7FFF]
                tmp = str(hex(data))
                tmp = tmp[2:]   #remove "0x" from string
                while len(tmp)<2:
                    tmp = '0'+tmp        
                hex_d.config(text = tmp.upper())
        # READ LATCH
        if (L_oe.get()==0):
            if (data != LATCH):
                reproc = 1
                data = LATCH
                tmp = str(hex(data))
                tmp = tmp[2:]   #remove "0x" from string
                while len(tmp)<2:
                    tmp = '0'+tmp        
                hex_d.config(text = tmp.upper())
        # WRITE RAM
        if (we.get()==0):
            if (data==-1):
                messagebox.showerror("ERROR", "Ungültige Daten auf Datenbus")
            else:
                RAM[addr & 0x7FFF] = data
            # WRITE LATCH
        if (L_stb.get()==1):
            if (data==-1):
                messagebox.showerror("ERROR", "Ungültige Daten auf Datenbus")
            else:
                LATCH = data
                
    if (reproc==1):
        sel()
                    

# addr/data inputs - function calls
def apply_a():
    global addr     # access and overwrite global addr variable
    inp_str = str(e1.get()).upper();
    char_valid = 0
    for i in inp_str:
        char_valid = 0
        for j in hex_chars:
            if (i==j):
                char_valid = 1
        if char_valid==0:
            messagebox.showerror("ERROR", "Ungültige Eingabe")            
            break
    if char_valid==1:
        addr = int(inp_str,16) & 0xFFFF
        tmp = str(hex(addr))
        tmp = tmp[2:]   #remove "0x" from string
        while len(tmp)<4:
            tmp = '0'+tmp        
        hex_a.config(text = tmp.upper())
        sel()           #update everything at addr. changes

def apply_d():
    global data     # access and overwrite global variables
    global user_data_oe_n
    inp_str = str(e2.get()).upper();
    char_valid = 0
    for i in inp_str:
        char_valid = 0
        for j in hex_chars:
            if (i==j):
                char_valid = 1
        if char_valid==0:
            messagebox.showerror("ERROR", "Ungültige Eingabe")
            break
    if char_valid==1:
        user_data_oe_n = 0
        data = int(inp_str,16) & 0xFF
        tmp = str(hex(data))
        tmp = tmp[2:]   #remove "0x" from string
        while len(tmp)<2:
            tmp = '0'+tmp        
        hex_d.config(text = tmp.upper())    

# title   
Label(root, 
	    text="Laborversuch: Speicher",
            fg = "light green",
            bg = "dark green",
            font = "Helvetica 16 bold italic").pack(fill=X)

# display architecture
logo = PhotoImage(file="./mem_layout_small.png")
w1 = Label(root, image=logo).pack(side="right")

# some position calculations, relative to imagesz.
img_y_offs = 17
img_x_offs = 133
img_y_oe   = img_y_offs + logo.height() * 0.577
img_y_we   = img_y_offs + logo.height() * 0.639
img_y_Loe  = img_y_offs + logo.height() * 0.9
img_y_Lstb = img_y_offs + logo.height() * 0.958
img_y_addr = img_y_offs + logo.height() * 0.069
img_y_data = img_y_offs + logo.height() * 0.71
img_y_hexa = img_y_offs + logo.height() * 0.08
img_y_hexd = img_y_offs + logo.height() * 0.722
img_x_hex  = img_x_offs + logo.width() * 0.912


w2 = Label(root, justify=LEFT, padx=24, text="Ansteuerung", fg="green", font = "Helvetica 12 bold italic").pack(side="top")

# HEX-displays
hex_a = Label(root, text="----", fg = "blue", bg = "white", font = "Courier 16 bold")
hex_a.place(x=img_x_hex-8 , y=img_y_hexa);

hex_d = Label(root, text="--", fg = "blue", bg = "white", font = "Courier 16 bold")
hex_d.place(x=img_x_hex , y=img_y_hexd);

# 4 radiobuttons

oe = IntVar()
we = IntVar()
L_oe = IntVar()
L_stb = IntVar()

OE0 = Radiobutton(root, text="0", padx=5, pady=5, variable=oe, value=0, command=sel)
OE0.place(x= 110, y= img_y_oe)
OE1 = Radiobutton(root, text="1", padx=5, pady=5, variable=oe, value=1, command=sel)
OE1.place(x= 70, y= img_y_oe)
OE0.deselect()
OE1.select()

WE0 = Radiobutton(root, text="0", padx=5, pady=5, variable=we, value=0, command=sel)
WE0.place(x= 110, y= img_y_we)
WE1 = Radiobutton(root, text="1", padx=5, pady=5, variable=we, value=1, command=sel)
WE1.place(x= 70, y= img_y_we)
WE0.deselect()
WE1.select()

L_OE0 = Radiobutton(root, text="0", padx=5, pady=5, variable=L_oe, value=0, command=sel)
L_OE0.place(x= 110, y= img_y_Loe)
L_OE1 = Radiobutton(root, text="1", padx=5, pady=5, variable=L_oe, value=1, command=sel)
L_OE1.place(x= 70, y= img_y_Loe)
L_OE0.deselect()
L_OE1.select()

L_STB0 = Radiobutton(root, text="0", padx=5, pady=5, variable=L_stb, value=0, command=sel)
L_STB0.place(x= 110, y= img_y_Lstb)
L_STB1 = Radiobutton(root, text="1", padx=5, pady=5, variable=L_stb, value=1, command=sel)
L_STB1.place(x= 70, y= img_y_Lstb)

# BUS-inputs

e1 = Entry(root, width=8)
e2 = Entry(root, width=8)
Label(root, text="0x").place(x=81, y=img_y_addr)
Label(root, text="0x").place(x=81, y=img_y_data)
e1.place(x=98, y=img_y_addr)
e2.place(x=98, y=img_y_data)
b1 = Button(root, text='übernehmen', command=apply_a, state = NORMAL)
b1.place(x=72, y=img_y_addr+20)
b2 = Button(root, text='übernehmen', command=apply_d, state = NORMAL)
b2.place(x=72, y=img_y_data+20)


root.mainloop()
