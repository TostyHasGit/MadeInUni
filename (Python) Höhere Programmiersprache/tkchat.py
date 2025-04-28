#!/usr/bin/python3
import tkinter as tk
import urllib.request
import urllib.parse


URL="https://pma.inftech.hs-mannheim.de/wsgi/chat"

class Chat(tk.Frame):

    def __init__(self, master=None):
        tk.Frame.__init__(self,master)
        self.create_widgets()
        self.grid()

    def create_widgets(self):
        btn_frame=tk.Frame(self)
        btn_frame.grid()
        submit=tk.Button(btn_frame,text="Submit",command=self.chat_post)
        submit.grid(row=0,column=0,sticky=tk.NW)
        update=tk.Button(btn_frame,text="Update",command=self.chat_get)
        update.grid(row=0,column=1,sticky=tk.NW)
        autoupdate=tk.Button(btn_frame,text="Auto-Update")
        autoupdate.grid(row=0,column=2,sticky=tk.NW)
        self.msgChat=tk.Label(btn_frame,text="test",bg="red")
        self.msgChat.grid(row=1,column=0,sticky=tk.W+tk.E,columnspan=3,rowspan=10)
        self.entry=tk.Entry(btn_frame,bg="white",fg="black")
        self.entry.grid(row=12,column=0,sticky=tk.SW,columnspan=3)

    def chat_post(self):
        msg=self.entry.get()
        data=msg.encode("UTF-8")
        resp=urllib.request.Request(URL,data=data)
        #resp.add_header("n3004128","text/plain")
        resp.add_header("Content-Type","text/plain")
        res = urllib.request.urlopen(resp)
        self.msgChat["text"]=urllib.request.urlopen(URL).read().decode("UTF-8")
        self.entry.delete(0,tk.END)
        return res

    def chat_get(self):
        self.msgChat["text"]=urllib.request.urlopen(URL).read().decode("UTF-8")

def main():
    root=tk.Tk()
    text=Chat(root)
    root.mainloop()

if __name__ == '__main__':
    main()