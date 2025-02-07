
DESTDIR =
PREFIX  = /usr/local

CFLAGS = -g -O0 -Wall -Wextra -Wpedantic -pedantic-errors -DDEBUG
LFLAGS = -g

all: build

build: nowrap

install:
	install -m 0755 nowrap $(DESTDIR)/$(PREFIX)/bin/nowrap

uninstall:
	rm -f $(DESTDIR)/$(PREFIX)/bin/nowrap

clean:
	rm -f nowrap.o
	rm -f nowrap

nowrap.o: nowrap.c
	cc -c -o nowrap.o nowrap.c $(CFLAGS)

nowrap: nowrap.o
	cc -o nowrap nowrap.o $(LFLAGS)

# vim: noet
# end of file
