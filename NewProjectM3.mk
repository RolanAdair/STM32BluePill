######################################################################
#  Project.mk is used for creating new FreeRTOS projects. See the
#  associated README.md file in this directory for usage info.
######################################################################

# Edit this variable if your release differs from what is shown here:

FREERTOS	?= FreeRTOSv10.2.1

######################################################################
#  Internal variables
######################################################################

PROJECT		?= newproject
TOP_DIR         :=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
RTOSDIR 	:=$(TOP_DIR)include/rtos
FREERTOSDIR	:= $(abspath $(RTOSDIR)/$(FREERTOS))
OPENCM3_DIR 	:= $(TOP_DIR)include/libopencm3

.PHONY:	rsrc all setup license

print-%:
	@echo $*=$($*)

all:	check rsrc license \
	 setup \

	@echo "****************************************************************"
	@echo "Your project in subdirectory $(PROJECT) is now ready."
	@echo
	@echo "1. Edit FreeRTOSConfig.h per project requirements."
	@echo "2. Edit Makefile SRCFILES as required. This also"
	@echo "   chooses which heap_*.c to use."
	@echo "3. Edit stm32f103c8t6.ld if necessary."
	@echo "4. make"
	@echo "5. make flash"
	@echo "6. make clean or make clobber as required"
	@echo "****************************************************************"

check:
	@if [ "$(PROJECT)" = "newproject" ] ; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		echo "Please supply PROJECT='<projectname>' on the" ; \
		echo "make command line." ; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		exit 2 ; \
	fi
	@if [ -d $(PROJECT) ] ; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		echo "Subdirectory $(PROJECT) already exists!" ; \
		echo "Cowardly refusing to delete/update it." ; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		exit 2 ; \
	fi

setup:
	cp $(TOP_DIR)include/libopencm3Files/main.cpp src/$(PROJECT)/main.cpp
	cp $(TOP_DIR)include/libopencm3Files/Makefile src/$(PROJECT)/.


rsrc:	
	@if [ ! -d $(OPENCM3_DIR) -o ! -f $(OPENCM3_DIR)/Makefile ] ; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		echo "Directory $(OPENCM3_DIR) is missing or incomplete. Make sure that" ; \
		echo "the git submodule is checked out and a make has been performed" ; \
		echo "there." ; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		exit 2; \
	fi
	@if [ ! -f $(OPENCM3_DIR)/lib/libopencm3_stm32f1.a ] ; then \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		echo "Directory $(OPENCM3_DIR) exists but the library file " ; \
		echo "$(OPENCM3_DIR)/lib/libopencm3_stm32f1.a  has not been created. " ; \
		echo "Please change to the ./libopencm3 and type make to build that " ; \
		echo "git submodule. " ; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" ; \
		exit 2; \
	fi
	mkdir -p "src/$(PROJECT)" ; \

license:
	cp $(OPENCM3_DIR)/COPYING.LGPL3 src/$(PROJECT)/COPYING.LGPL3


# End
