hello : hello.o
	ld hello.o -o hello

hello.o : hello.asm
	as hello.asm -o hello.o

clean:	
	-rm hello.o
	-rm hello

run: hello
	./hello
