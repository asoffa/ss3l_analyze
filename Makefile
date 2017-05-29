
UTIL_SOURCES = $(shell test -d util && ls util)
UTILS        = $(foreach s, $(UTIL_SOURCES), bin/$(basename $(s)))


.PHONY : all bin bin/ lib lib/ link util util/ clean

all : lib link util

bin : $(UTILS)

bin/ : bin

lib : lib/libRoot.a

lib/ : lib

link : lib/root_link.cr

util : $(UTILS)

util/ : util


lib/libRoot.o : lib/libRoot.cxx
	@echo "Making ./lib/libRoot.o ..."
	@g++ -c $^ -o $@ `root-config --cflags`


lib/libRoot.a : lib/libRoot.o
	@echo "Making ./lib/libRoot.a ..."
	@ar crs lib/libRoot.a lib/libRoot.o


# To make a shared, dynamic library, use the following instead of the above lib/libRoot.o, lib/libRoot.a.
# This route requires setting the `LD_LIBRARY_PATH` environment variable to /path/to/lib
#lib/libRoot.so : lib/libRoot.cxx
#	@echo "Making ./libRoot.so ..."
#	@g++ -fpic -shared $^ -o $@ `root-config --cflags`


lib/project_dir.sh :
	@chmod +x lib/project_dir.sh


lib/root_link.cr : lib/project_dir.sh
	@echo "Making ./lib/root_link.cr ..."
	@echo "@[Link(ldflags: \"`root-config --libs` -L`lib/project_dir.sh`/lib -lRoot\")]" >  lib/root_link.cr
	@echo "@[Link(ldflags: \"$${CRYSTAL_DIR}/embedded/lib/libpcre.a\")]"                 >> lib/root_link.cr
	@echo "lib LibRoot" >> lib/root_link.cr
	@echo "end"         >> lib/root_link.cr


# hack to work around `make` not being able to handle multiple `%`s in dependency list:
.SECONDEXPANSION : 
bin/% : OBJECT 	     = $(notdir $(basename $@))
bin/% : DEPENDENCIES = $(wildcard util/$(OBJECT).cr util/$(OBJECT)/$(OBJECT).cr) $(shell test -d src && find src -name *.cr) lib/libRoot.a lib/root_link.cr
bin/% : $$(DEPENDENCIES) 
	@echo "Making ./bin/$(OBJECT) ..."
	@crystal build $< -o $@ --release


clean :
	@rm -f bin/* lib/root_link.cr lib/libRoot.a lib/libRoot.o


