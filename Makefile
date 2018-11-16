SOURCES = medgen

all: build_sources

build_sources: $(patsubst %, build-%, $(SOURCES))

build-%:
	cd sources/$* && make
