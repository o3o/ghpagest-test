NAME = e0
VERSION = 0.1.0

ROOT_SOURCE_DIR = src
SRC = $(getSources) 
SRC_TEST = $(SRC)

# Compiler flag
# -----------
DCFLAGS += -debug #compile in debug code
#DCFLAGS += -g # add symbolic debug info
#DCFLAGS += -w # warnings as errors (compilation will halt)
DCFLAGS += -wi # warnings as messages (compilation will continue)
DCFLAGS += -m64
DCFLAGS_TEST += -unittest
# DCFLAGS_TEST += -main -quiet

# Linker flag
# -----------
# DCFLAGS_LINK += 
# DCFLAGS_LINK += -L-L/usr/lib/

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

# dinodave
# -----------
LIB += $(D_DIR)/dinodave/bin/libdinodave.a
DCFLAGS_IMPORT += -I$(D_DIR)/dinodave/src
DCFLAGS_LINK =-L-lnodave 


include common.mk
