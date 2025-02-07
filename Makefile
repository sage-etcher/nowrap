
DESTDIR =
PREFIX  = /usr/local

CFLAGS = -g -O0 -Wall -Wextra -Wpedantic -pedantic-errors -DDEBUG
LFLAGS = -g

all: build

build: nowrap

install:
	install -m 0755 ./nowrap $(DESTDIR)/$(PREFIX)/bin/nowrap

uninstall:
	rm -f $(DESTDIR)/$(PREFIX)/bin/nowrap

clean:
	rm -f help.h
	rm -f version.h
	rm -f nowrap.o
	rm -f nowrap

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
