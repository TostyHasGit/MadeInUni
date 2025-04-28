#!/usr/bin/python3
import urllib.request
import urllib.parse


URL="https://pma.inftech.hs-mannheim.de/wsgi/chat"

def chat_get():
    return urllib.request.urlopen(URL).read().decode("UTF-8")

def chat_post(msg):
    data=msg.encode("UTF-8")
    resp=urllib.request.Request(URL,data=data)
    #resp.add_header("n3004128","text/plain")
    resp.add_header("Content-Type","text/plain")
    res = urllib.request.urlopen(resp)
    return res

def main():
    chat_post("test2")
    print(chat_get())


if __name__ == '__main__':
    main()