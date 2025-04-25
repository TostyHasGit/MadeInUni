SUBDIRS = Deadlock Mutex Producer ProducerConsumer

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ 

clean: 
	for d in $(SUBDIRS); \
	do \
	make -C $$d clean; \
	done


.PHONY: clean $(SUBDIRS)
