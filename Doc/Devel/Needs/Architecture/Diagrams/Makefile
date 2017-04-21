TARGETS= \
  OslandiaiTown2Context.png

all: $(TARGETS)

DIA=dia --filter png --export
%.png: %.dia
	$(DIA) $@ $<

clean:
	rm -f *~
