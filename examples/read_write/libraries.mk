getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")

# dinodave
# -----------
LIB += $(D_DIR)/dinodave/bin/libdinodave.a
INCLUDES += -I$(D_DIR)/dinodave/src
LDFLAGS =-L-lnodave 

# test 
# -----------
LIB_TEST += $(LIB)
INCLUDES_TEST += $(INCLUDES)
