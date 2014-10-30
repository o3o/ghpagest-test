NAME = libdinodave.a
VERSION = 0.2.0

ROOT_SOURCE_DIR = src
SRC = $(getSources) 

SRC_TEST = $(SRC)
SRC_TEST += $(wildcard tests/*.d)

# Compiler flag
# -----------
DFLAGS += -lib
DFLAGS += -debug #compile in debug code
#DFLAGS += -g # add symbolic debug info
#DFLAGS += -w # warnings as errors (compilation will halt)
DFLAGS += -wi # warnings as messages (compilation will continue)
DFLAGS += -m64

#DFLAGS_TEST += -unittest
# DFLAGS_TEST += -main -quiet

# Linker flag
# -----------
LDFLAGS =-L-lnodave 
#LDFLAGS += 
#LDFLAGS += -L-L/usr/lib/

# Version flag
# -----------
# VERSION_FLAG = -version=use_gtk

# Packages
# -----------
PKG = $(wildcard $(BIN)/$(NAME))
PKG_SRC = $(PKG) $(SRC) makefile

# -----------
# Libraries
# -----------

# unit-threaded
# -----------
LIB_TEST += $(D_DIR)/unit-threaded/libunit-threaded.a
INCLUDES_TEST += -I$(D_DIR)/unit-threaded/source

include common.mk
