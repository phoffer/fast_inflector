ifeq "$(PLATFORM)" ""
PLATFORM := $(shell uname)
endif

ifeq "$(PLATFORM)" "Linux"
UNAME = "$(shell llvm-config --host-target)"
CRYSTAL_BIN = $(shell readlink -f `which crystal`)
LIBRARY_PATH = $(shell dirname $(CRYSTAL_BIN))/../embedded/lib
LIBCRYSTAL = $(shell dirname $(CRYSTAL_BIN) )/../src/ext/libcrystal.a
LIBRUBY = $(shell ruby -e "puts RbConfig::CONFIG['libdir']")
LIBS = -levent -lpcre -lgc -lpthread -lruby -ldl -lm -lc
LDFLAGS = -L. -fstack-protector -rdynamic -Wl,-export-dynamic,-undefined,dynamic_lookup

install: all

all: shards fast_inflector.so

shards:
	crystal deps

fast_inflector.so: fast_inflector.o
	$(CC) -shared $^ -o $@ $(LIBCRYSTAL) -L$(LIBRARY_PATH) -L$(LIBRUBY) $(LIBS) $(LDFLAGS)

fast_inflector.o: init.cr
	crystal compile --cross-compile --target $(UNAME) $<

.PHONY: clean
clean:
	rm -f bc_flags
	rm -f *.o
	rm -f *.so
endif

ifeq "$(PLATFORM)" "Darwin"
CRYSTAL_FLAGS = -dynamic -bundle -Wl,-undefined,dynamic_lookup

all: shards fast_inflector.bundle

shards:
	crystal deps

fast_inflector.bundle: init.cr
	crystal $^ --release --link-flags "$(CRYSTAL_FLAGS)" -o $@

clean:
	rm -f *.bundle
endif
