all : beispiel1 beispiel2

queue_sync.o : queue_sync.cpp queue_sync.h queue.h queue.cpp
	g++ queue_sync.cpp queue.cpp -c 

sleep.o : sleep.cpp sleep.h
	g++ sleep.cpp -c

beispiel1: beispiel1.cpp queue.h queue.o sleep.h sleep.o producer.h producer.o
	g++ beispiel1.cpp queue.o sleep.o producer.o -pthread -o beispiel1 

beispiel2: beispiel2.cpp queue.o queue_sync.o sleep.o producer.o
	g++ beispiel2.cpp queue_sync.o sleep.o producer.o queue.o -pthread -o beispiel2

queue.o: queue.cpp queue.h
	g++ -c queue.cpp

producer.o:  producer.cpp queue.h sleep.h
	g++ -c producer.cpp 

clean: 
	-rm *.o
	-rm beispiel1
	-rm beispiel2





