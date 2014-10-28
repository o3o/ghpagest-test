NAME=ex1 
VERSION = 0.1.0

SRC = $(wildcard src/*.d)
LIB = $(wildcard ../../bin/*.a)
INCLUDES += -I../../src

DFLAGS += -debug -g
DFLAGS += -w -wi
DFLAGS += -m64
LDFLAGS =-L-lnodave 

DEFAULT: all
BIN = bin
DMD = dmd
BASE_NAME = $(basename $(NAME))

.PHONY: all clean clobber run

all: builddir $(BIN)/$(NAME)

builddir:
	@mkdir -p $(BIN)

$(BIN)/$(NAME): $(SRC) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS) $(INCLUDES) $(LDFLAGS) $(VERSION_FLAG) -of$@

run: all
	$(BIN)/$(NAME)

clean:
	-rm -f $(BIN)/*.o

clobber:
	-rm -Rf $(BIN)/*

var:
	@echo SRC:
	@echo $(SRC)
	@echo
	@echo INCLUDES:
	@echo $(INCLUDES)
	@echo
	@echo DFLAGS:
	@echo $(DFLAGS)
	@echo
	@echo VERSION:
	@echo $(VERSION_FLAG)
