all : beispiel1 beispiel2 beispiel3

queue_block.o : queue_block.cpp queue_block.h queue.h 
	g++ queue_block.cpp -c 

queue_sync.o : queue_sync.cpp queue_sync.h queue.h 
	g++ queue_sync.cpp queue.cpp -c 

sleep.o : sleep.cpp sleep.h
	g++ sleep.cpp -c

beispiel1: beispiel1.cpp queue.o sleep.o consumer.o producer.o queue_sync.o
	g++ beispiel1.cpp queue_sync.o queue.o sleep.o consumer.o producer.o -pthread -o beispiel1 

beispiel2: beispiel2.cpp queue.o queue_block.o consumer.o sleep.o producer.o
	g++ beispiel2.cpp queue_block.o sleep.o producer.o consumer.o queue.o -pthread -o beispiel2

beispiel3: beispiel3.cpp queue.o queue_cv.o consumer.o sleep.o producer.o
	g++ beispiel3.cpp queue_cv.o sleep.o producer.o consumer.o queue.o -pthread -o beispiel3

queue.o: queue.cpp queue.h
	g++ -c queue.cpp

producer.o:  producer.cpp queue.h sleep.h
	g++ -c producer.cpp 

consumer.o: consumer.cpp queue.h sleep.h
	g++ -c consumer.cpp

clean: 
	-rm *.o
	-rm beispiel1
	-rm beispiel2
	-rm beispiel3





