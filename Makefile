prefix := $(HOME)

bindir := $(prefix)/bin

all:

D = $(DESTDIR)

install:
	install -d -m 755 $(D)$(bindir)/
	install -m 755 git-branch-list $(D)$(bindir)/git-branch-list

.PHONY: all install
