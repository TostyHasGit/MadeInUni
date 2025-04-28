all: pthread thread async

pthread:  pthread.c
	gcc pthread.c -pthread -o pthread 

thread:  thread.cpp
	g++ thread.cpp -pthread -o thread

async: async.cpp
	g++ async.cpp -pthread -o async

clean: 
	-rm thread
	-rm pthread
	-rm async

run: thread
	./thread

