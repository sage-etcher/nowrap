
DESTDIR =
PREFIX  = /usr/local

CFLAGS = -O0 -g -DDEBUG -Wall -Wextra -Wpedantic -pedantic-errors
LFLAGS = -g

NAME    = nowrap
VERSION = 0.2-beta

RELEASE_DATA     = release/data
RELEASE_ARCHIVES = release/archives
RELEASE_TAR = $(RELEASE_ARCHIVES)/$(NAME)-$(VERSION).tar

all: build

build: nowrap

install:
	install -m 0755 nowrap $(DESTDIR)/$(PREFIX)/bin/

uninstall:
	rm -f $(DESTDIR)/$(PREFIX)/bin/nowrap

clean:
	rm -f help.h
	rm -f version.h
	rm -f nowrap.o
	rm -f nowrap
genrelease: help.h version.h
	mkdir -p $(RELEASE_DATA)
	install -m 644 LICENSE           $(RELEASE_DATA)/
	install -m 644 README.md         $(RELEASE_DATA)/
	install -m 644 help.h            $(RELEASE_DATA)/
	install -m 644 version.h         $(RELEASE_DATA)/
	install -m 644 nowrap.c          $(RELEASE_DATA)/
	install -m 644 Makefile.release  $(RELEASE_DATA)/

	mkdir -p $(RELEASE_ARCHIVES)
	tar -cf $(RELEASE_TAR) $(RELEASE_DATA)/
	-plzip -k9 $(RELEASE_TAR)
	-gzip  -k9 $(RELEASE_TAR)
	-bzip2 -k9 $(RELEASE_TAR)

help.h: help_msg.txt
	xxd -i -n HELP_MSG help_msg.txt help.h

version.h: version_msg.txt
	xxd -i -n VERSION_MSG version_msg.txt version.h

nowrap.o: nowrap.c help.h version.h
	cc -c -o nowrap.o nowrap.c $(CFLAGS)

nowrap: nowrap.o
	cc -o nowrap nowrap.o $(LFLAGS)

# vim: noet
# end of file
