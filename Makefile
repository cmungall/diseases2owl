SOURCES = omim
TARGET=target
all: build_sources

build_sources: $(patsubst %, build-%, $(SOURCES))

$(TARGET):
	mkdir -p $@

build-%: $(TARGET)
	cd sources/$* && make
