SUBDIRS = Grundlagen Prozesse Scheduling Speicher Synchronisation

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ 

clean:
	for d in $(SUBDIRS); \
	do \
	make -C $$d clean; \
	done
	-rm Beispiele.zip

.PHONY: clean $(SUBDIRS) moodle

Beispiele.zip: clean
	zip Beispiele.zip -r $(SUBDIRS) -x "*~"
	
moodle: Beispiele.zip
	mv Beispiele.zip ../moodle
