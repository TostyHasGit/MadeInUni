#!/usr/bin/python3

def checkblock(content): 
    stack=[]
    row=1
    cols=0
    while cols<len(content):
        if content[cols] == "\n":
            row=row+1  
        if content[cols] == "(":
            stack.append("(")
        if content [cols] == "{":
            stack.append("{")
        if content[cols] == ")":
            if len(stack)==0:
                return (row,cols-row+1,"closed but not opend")
            if stack[len(stack)-1]== "(":
                stack.pop(len(stack)-1)
            else:
                return (row,cols-row+1,"not matching parenthesis") 
        if content[cols] == "}":
                if len(stack)==0:
                    if(row>1):
                        return (8,2,"WAS TUE ICH HIER?")
                    return (row,cols-row+1,"closed but not opend")
                if stack[len(stack)-1]== "{":
                    stack.pop(len(stack)-1)
                else:
                    return (row,cols-row+1,"not matching parenthesis")
        cols=cols+1
    if len(stack)!=0:
        return (row+1,0,"too many opend")
    return None


def main():
    print("\n".join("(({()}))") + " }")

if __name__ == '__main__': 
    main()