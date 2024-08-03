.PHONY: all install uninstall clean

PREFIX := $(HOME)
BINDIR := $(PREFIX)/bin

PROGRAM := hostctl
MAIN := cmd/hostctl/main.go

VERSION := $(shell jq -r .version hostctl.json)+yt

ENV := GO111MODULE=on CGO_ENABLED=0
LDFLAGS := -s -w -X github.com/guumaster/hostctl/cmd/hostctl/actions.version=$(VERSION)

UID := 0
GID := 0

all: clean $(PROGRAM)

$(PROGRAM):
	$(ENV) go build -o $(PROGRAM) -ldflags "$(LDFLAGS)" $(MAIN)

install:
	@mkdir -p $(BINDIR)
	@cp -f $(PROGRAM) $(BINDIR)/
	@sudo chown $(UID):$(GID) $(BINDIR)/$(PROGRAM)
	@sudo chmod u+s $(BINDIR)/$(PROGRAM)

uninstall:
	@sudo rm $(BINDIR)/$(PROGRAM)

clean:
	@rm -rf $(PROGRAM)
