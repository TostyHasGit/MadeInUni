#!/usr/bin/python3
import tkinter as tk

greetings=["Hallo", "Hello", "Aloita","Oi", "Ni Hao"]
idx=0

def main():
    global greetings
    global idx
    root=tk.Tk()
    label=tk.Label(root,text=greetings[idx])
    label.pack()
    def callback():
        global idx
        global greetings
        idx=(idx+1)%len(greetings)
        label["text"]= greetings[idx]
    frame=tk.Frame(root)
    frame.pack()
    gruß=tk.Button(frame,text="Grüße",command=callback)
    gruß.pack(side=tk.LEFT)
    beende=tk.Button(frame,text="Beende",fg="red",command=root.destroy)
    beende.pack(side=tk.RIGHT)
    root.mainloop()

if __name__ == '__main__':

    main()