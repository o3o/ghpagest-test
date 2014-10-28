getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")

# unit-threaded
# -----------
#LIB_TEST += $(D_DIR)/unit-threaded/libunit-threaded.a
#INCLUDES_TEST += -I$(D_DIR)/unit-threaded/source

# dunit
# -----------
#LIB_TEST =  $(D_DIR)/dunit/libdunit.a
#INCLUDES_TEST += -I$(D_DIR)/dunit/source

# dmocks-revived
# -----------
#LIB_TEST += $(D_DIR)/DMocks-revived/libdmocks-revived.a
#INCLUDES_TEST += -I$(D_DIR)/DMocks-revived

# test 
# -----------
LIB_TEST += $(LIB)
INCLUDES_TEST += $(INCLUDES)
