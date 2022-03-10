# Check for executables dependency
EXECUTABLES = docker
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

DOT=docker run --rm -it -v $(shell pwd):/app -w /app minidocks/graphviz dot

.SUFFIXES: .gv .svg

TARGETS= \
  Tools_Formats_bipartite_graph_UML_activity_like.svg

all: $(TARGETS) 

.gv.svg:
	$(DOT) -Tsvg $*.gv -o $@

clean:
	rm -f $(TARGETS) 
