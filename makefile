NAME = libdinodave.a
VERSION = 0.1.0

ROOT_SOURCE_DIR = src
SRC = $(getSources) 
SRC_TEST = $(SRC)

# Libraries
# -----------
include libraries.mk

# Compiler flag
# -----------
DFLAGS += -lib
DFLAGS += -debug #compile in debug code
#DFLAGS += -g # add symbolic debug info
#DFLAGS += -w # warnings as errors (compilation will halt)
DFLAGS += -wi # warnings as messages (compilation will continue)
DFLAGS += -m64

DFLAGS_TEST += -main -quiet -unittest

# Linker flag
# -----------
LDFLAGS =-L-lnodave 
#LDFLAGS += 
#LDFLAGS += -L-L/usr/lib/
# VERSION_FLAG = -version=use_gtk

# Packages
# -----------
PKG = $(wildcard $(BIN)/$(NAME))
PKG_SRC = $(PKG) $(SRC) makefile

###############
# Common part
###############
DEFAULT: all
BIN = bin
DMD = dmd
BASE_NAME = $(basename $(NAME))
NAME_TEST = $(BASE_NAME)-test 
DSCAN = $(D_DIR)/Dscanner/bin/dscanner

# Version flag
# use: make VERS=x
# -----------
VERSION_FLAG += $(if $(VERS), -version=$(VERS), )

.PHONY: all clean clobber test run pkg pkgsrc tags

all: builddir $(BIN)/$(NAME)

builddir:
	@mkdir -p $(BIN)

$(BIN)/$(NAME): $(SRC) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS) $(INCLUDES) $(LDFLAGS) $(VERSION_FLAG) -of$@

run: all
	$(BIN)/$(NAME)

## se si usa unit_threaded
## make test T=nome_test
test: $(BIN)/$(NAME_TEST)
	@$(BIN)/$(NAME_TEST) $(T)

$(BIN)/$(NAME_TEST): $(SRC_TEST) $(LIB_TEST)| builddir
	$(DMD) $^ $(DFLAGS_TEST) $(INCLUDES_TEST) $(LDFLAGS) $(VERSION_FLAG) -of$@

pkgdir:
	@mkdir -p pkg

pkg: $(PKG) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION).tar.bz2 $^
	zip pkg/$(BASE_NAME)-$(VERSION).zip $^

pkgsrc: $(PKG_SRC) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION)-src.tar.bz2 $^

tags: $(SRC)
	$(DSCAN) --ctags $^ > tags

style: $(SRC)
	$(DSCAN) --styleCheck $^

syn: $(SRC)
	$(DSCAN) --syntaxCheck $^

loc: $(SRC)
	$(DSCAN) --sloc $^

clean:
	-rm -f $(BIN)/*.o
	-rm -f $(BIN)/__*

clobber:
	-rm -f $(BIN)/*

var:
	@echo $(D_DIR):$($(D_DIR))
	@echo SRC:$(SRC)
	@echo INCLUDES: $(INCLUDES)
	@echo
	@echo DFLAGS: $(DFLAGS)
	@echo LDFLAGS: $(LDFLAGS)
	@echo VERSION: $(VERSION_FLAG)
	@echo
	@echo NAME_TEST: $(NAME_TEST)
	@echo SRC_TEST: $(SRC_TEST)
	@echo INCLUDES_TEST: $(INCLUDES_TEST)
	@echo T: $(T)

