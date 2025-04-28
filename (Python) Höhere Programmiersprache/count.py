#!/usr/bin/python3

def count_words(lis):
    word=[]
    for ele in lis:
        print(ele[:-1])
        if ele[:-1]:
            word.append(ele[:-1])
        for char in ele[:-1]:
            if char==" ":
                word.append(" ")
    return len(word)
                
                
def count_chars(lis):
    word=[" "]
    for ele in lis:
        for chars in ele[:-1]:
            if chars!=" ":
                word.append(chars)
    return len(word)


def main():
    lis=[]
    with open("test.dat","r") as datei:
        for ele in datei:
            lis.append(ele)
    print(count_words(lis))
    print(count_chars(lis))


if __name__ == '__main__': 
    main()