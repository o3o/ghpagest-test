#makefile release 0.2.0
NAME = libdinodave.a
PROJECT_VERSION = 0.2.0

ROOT_SOURCE_DIR = src
BIN = bin
SRC = $(getSources)
BASE_NAME = $(basename $(NAME))

#############
# Packages  #
#############
ZIP = $(BIN)/$(NAME)
ZIP_SRC = $(ZIP) $(SRC) dub.json README.md CHANGELOG.md makefile $(SRC_TEST)
ZIP_PREFIX = $(BASE_NAME)-$(PROJECT_VERSION)

#############
# Test      #
#############
TEST_SOURCE_DIR = tests
SRC_TEST = $(filter-out $(ROOT_SOURCE_DIR)/App.cs, $(SRC))
SRC_TEST += $(shell find $(TEST_SOURCE_DIR) -name "*.d")

getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")

#############
## commands #
#############
DUB = dub
DSCAN = $(D_DIR)/Dscanner/bin/dscanner
MKDIR = mkdir -p
RM = -rm -f
UPX = upx --no-progress

<<<<<<< HEAD
## flags
DUBFLAGS = -q --combined

.PHONY: all release force run test pkgall pkg pkgtar pkgsrc tags style syn loc clean clobber

DEFAULT: all

all:
	$(DUB) build $(DUBFLAGS)

release:
	$(DUB) build -brelease $(DUBFLAGS)

force:
	$(DUB) build --force $(DUBFLAGS)

run:
	$(DUB) run $(DUBFLAGS)

test:
	$(DUB) test $(DUBFLAGS)

upx: $(BIN)/$(NAME)
	$(UPX) $@

pkgdir:
	@mkdir -p pkg

pkgall: pkg pkgtar pkgsrc

pkg: pkgdir | pkg/$(ZIP_PREFIX).zip

pkg/$(ZIP_PREFIX).zip: $(ZIP)
	zip $@ $(ZIP)

pkgtar: pkgdir | pkg/$(ZIP_PREFIX).tar.bz2

pkg/$(ZIP_PREFIX).tar.bz2: $(ZIP)
	tar -jcf $@ $^

pkgsrc: pkgdir | pkg/$(ZIP_PREFIX)-src.tar.bz2

pkg/$(ZIP_PREFIX)-src.tar.bz2: $(ZIP_SRC)
	tar -jcf $@ $^
=======
BITS ?= $(shell getconf LONG_BIT)
DCFLAGS += -m$(BITS)

getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")

# Version flag
# use: make V=x
# -----------
VERSION_FLAG += $(if $(V), -version=$(V), )

.PHONY: all clean clobber test testv run pkg pkgsrc tags syn style loc var ver help release

all: builddir $(BIN)/$(NAME_DEBUG)
release: builddir $(BIN)/$(NAME_REL)

builddir:
	@$(MKDIR) $(BIN)

$(BIN)/$(NAME_DEBUG): $(SRC) $(LIB)| builddir
	$(DC) $^ $(VERSION_FLAG) $(DCFLAGS) $(DCFLAGS_IMPORT) $(DCFLAGS_LINK) $(DCFLAGS_J) $(OUTPUT)$@

$(BIN)/$(NAME_REL): $(SRC) $(LIB)| builddir
	$(DC) $^ $(VERSION_FLAG) $(DCFLAGS_REL) $(DCFLAGS_IMPORT) $(DCFLAGS_LINK) $(DCFLAGS_J) $(OUTPUT)$@
ifdef COMPRESS
	$(UPX) $@
endif


run: all
	$(BIN)/$(NAME_DEBUG)

## with unit_threaded:
## make test T=test_name
test: build_test
	@$(BIN)/$(NAME_TEST) $(T)

testv: build_test
	@$(BIN)/$(NAME_TEST) -d $(T)

build_test: $(BIN)/$(NAME_TEST)

$(BIN)/$(NAME_TEST): $(SRC_TEST) $(LIB_TEST)| builddir
	$(DC) $^ $(VERSION_FLAG) $(DCFLAGS_TEST) $(DCFLAGS_IMPORT_TEST) $(DCFLAGS_LINK) $(DCFLAGS_J) $(OUTPUT)$@

pkgdir:
	$(MKDIR) pkg

pkg: $(PKG) | pkgdir
	tar -jcf pkg/$(NAME)-$(PROJECT_VERSION).tar.bz2 $^
	zip pkg/$(NAME)-$(PROJECT_VERSION).zip $^

pkgsrc: $(PKG_SRC) | pkgdir
	tar -jcf pkg/$(NAME)-$(PROJECT_VERSION)-src.tar.bz2 $^
>>>>>>> d6e563c6b9ab3f7f459cf29e350061db468c6853

tags: $(SRC)
	$(DSCAN) --ctags $^ > tags

style: $(SRC)
	$(DSCAN) --styleCheck $^

syn: $(SRC)
	$(DSCAN) --syntaxCheck $^

loc: $(SRC)
	$(DSCAN) --sloc $^

clean:
<<<<<<< HEAD
	$(DUB) clean

clobber: clean
	$(RM) $(BIN)/$(NAME)
=======
	$(RM) $(BIN)/*.o
	$(RM) $(BIN)/*.log
	$(RM) $(BIN)/__*
	$(RM) $(BIN)/$(NAME_TEST)

clobber: clean
	$(RM) $(BIN)/$(NAME_REL)
	$(RM) $(BIN)/$(NAME_DEBUG)
>>>>>>> d6e563c6b9ab3f7f459cf29e350061db468c6853

ver:
	@echo $(PROJECT_VERSION)

var:
<<<<<<< HEAD
	@echo NAME:       $(NAME)
	@echo PRJ_VER:    $(PROJECT_VERSION)
	@echo BASE_NAME:  $(BASE_NAME)
	@echo
	@echo ==== dir ===
	@echo D_DIR: $(D_DIR)
	@echo BIN:   $(BIN)
	@echo ROOT_SOURCE_DIR: $(ROOT_SOURCE_DIR)
	@echo TEST_SOURCE_DIR: $(TEST_SOURCE_DIR)
	@echo
	@echo ==== zip ===
	@echo ZIP: $(ZIP)
	@echo ZIP_SRC: $(ZIP_SRC)
	@echo ZIP_PREFIX: $(ZIP_PREFIX)
	@echo 
	@echo ==== src ===
	@echo SRC:   $(SRC)
=======
	@echo
	@echo NAME:       $(NAME)
	@echo NAME_DEBUG: $(NAME_DEBUG)
	@echo NAME_REL:   $(NAME_REL)
	@echo TARGET:     $(TARGET)
	@echo COMPRESS:   $(COMPRESS)
	@echo PRJ_VER:    $(PROJECT_VERSION)
	@echo
	@echo D_DIR: $(D_DIR)
	@echo BIN:   $(BIN)
	@echo SRC:   $(SRC)
	@echo LIB:   $(LIB)
	@echo
	@echo DC:      $(DC)
	@echo DCFLAGS: $(DCFLAGS)
	@echo DCFLAGS_LINK: $(DCFLAGS_LINK)
	@echo DCFLAGS_IMPORT: $(DCFLAGS_IMPORT)
	@echo VERSION: $(VERSION_FLAG)
	@echo
	@echo ==== test ===
	@echo NAME_TEST: $(NAME_TEST)
	@echo SRC_TEST: $(SRC_TEST)
	@echo DCFLAGS_IMPORT_TEST: $(DCFLAGS_IMPORT_TEST)
	@echo LIB_TEST: $(LIB_TEST)
	@echo
	@echo T: $(T)
>>>>>>> d6e563c6b9ab3f7f459cf29e350061db468c6853

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
<<<<<<< HEAD
	@echo "... release Compiles in release mode"
	@echo "... force  Forces a recompilation"
	@echo "... test Executes the tests"
	@echo "... run Builds and runs"
	@echo "... clean Removes intermediate build files"
	@echo "... clobber"
	@echo "... pkg Zip binary"
	@echo "... pkgtar Tar binary"
	@echo "... pkgsrc Tar source"
	@echo "... pkgall Exewcutes pkg, pkgtar, pkgsrc"
	@echo "... tags Generates tag file"
	@echo "... style Checks programming style"
	@echo "... syn Syntax check"
=======
	@echo "... test"
	@echo "... testv Runs unitt_threded test in verbose (-debug) mode"
	@echo "... run"
	@echo "... clean"
	@echo "... clobber"
	@echo "... pkg Generates a binary package"
	@echo "... pkgsrc Generates a source package"
	@echo "... tags Generates tag file"
	@echo "... style Checks programming style"
	@echo "... syn"
>>>>>>> d6e563c6b9ab3f7f459cf29e350061db468c6853
	@echo "... upx Compress using upx"
	@echo "... loc Counts lines of code"
	@echo "... var Lists all variables"
