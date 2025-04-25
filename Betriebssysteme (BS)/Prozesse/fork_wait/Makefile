all : parent child

parent : parent.cpp
	g++ parent.cpp -o parent

child :	child.cpp
	g++ child.cpp -o child

clean :
	-rm parent
	-rm child

run : parent child
	./parent ./child child


