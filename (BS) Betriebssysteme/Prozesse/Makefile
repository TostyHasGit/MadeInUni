SUBDIRS = adoption fork_fun fork_wait pthreads zombie

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ 

clean: 
	for d in $(SUBDIRS); \
	do \
	make -C $$d clean; \
	done


.PHONY: clean $(SUBDIRS)
