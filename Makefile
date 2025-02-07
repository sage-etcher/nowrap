

# install flags
DESTDIR =
PREFIX  = /usr/local

CFLAGS = -std=c89 -Wall -Wextra -Wpedantic -pedantic-errors \
         -O0 -g -DDEBUG
LFLAGS = -g

# release flags
YEAR    = 2025
NAME    = nowrap
VERSION = 0.2-beta
RELEASE = $(NAME)-$(VERSION)

RELEASE_DIR      = release
RELEASE_DATA     = $(RELEASE_DIR)/$(RELEASE)
RELEASE_ARCHIVES = $(RELEASE_DIR)/distributables
RELEASE_TAR      = $(RELEASE_ARCHIVES)/$(RELEASE).tar

all: build

build: nowrap

install:
	install -m 0755 nowrap $(DESTDIR)$(PREFIX)/bin/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/nowrap

clean:
	rm -f help.h
	rm -f version.h
	rm -f nowrap.o
	rm -f nowrap
	rm -rf $(RELEASE_DIR)

genrelease: help.h version.h
	mkdir -p $(RELEASE_DATA)
	install -m 644 LICENSE           $(RELEASE_DATA)/
	install -m 644 README.md         $(RELEASE_DATA)/
	install -m 644 help.h            $(RELEASE_DATA)/
	install -m 644 version.h         $(RELEASE_DATA)/
	install -m 644 nowrap.c          $(RELEASE_DATA)/
	install -m 644 Makefile.release  $(RELEASE_DATA)/Makefile

	mkdir -p $(RELEASE_ARCHIVES)
	tar -cf $(RELEASE_TAR) $(RELEASE_DATA)/
	-plzip -k9 $(RELEASE_TAR)
	-gzip  -k9 $(RELEASE_TAR)
	-bzip2 -k9 $(RELEASE_TAR)

nowrap: nowrap.o
	cc -o nowrap nowrap.o $(LFLAGS)

nowrap.o: nowrap.c help.h version.h
	cc -c -o nowrap.o nowrap.c $(CFLAGS)

# find and replace variables in template, then
# use xxd to embed it into a C header
%.h: %.template
	cat $*.template | \
		sed -e 's,@@NAME@@,$(NAME),g' | \
		sed -e 's,@@VERSION@@,$(VERSION),g' | \
		sed -e 's,@@YEAR@@,$(YEAR),g' \
		> $*.template.$$ 
	xxd -i -n embeded_$*_msg $*.template.$$  $*.h
	rm -f $*.template.$$ 



# vim: noet
# end of file
