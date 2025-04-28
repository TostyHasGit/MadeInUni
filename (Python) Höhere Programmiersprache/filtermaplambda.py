#!/usr/bin/python3

print(list(filter(lambda x: list(filter(lambda y: x%y==0, range(2,x)))==[] ,range(10000,10101))))