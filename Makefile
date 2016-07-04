NAME        := demo.tex
OUTPUT_NAME := demo_gerasimovd

BUILD_DIR := build
BASE_ARGS := -outdir=$(BUILD_DIR) -jobname=$(OUTPUT_NAME)
ARGS      := $(BASE_ARGS) -shell-escape -pdf

ifdef TRAVIS
	ARGS += -halt-on-error
endif

all: build

.PHONY: build # latexmk does the job for us
build: 
	latexmk $(ARGS) $(NAME)


.PHONY: preview # latexmk does the job for us
preview:
	latexmk $(ARGS) -pvc $(NAME)


.PHONY: clean
clean:
	latexmk $(BASE_ARGS) -c $(NAME) # latexmk requires name even for clean for some reason


.PHONY: wipe
wipe:
	latexmk $(BASE_ARGS) -C $(NAME) # latexmk requires name even for clean for some reason


.PHONY: export
export: build
	zip demo.zip $(NAME) build/demo.pdf


ASPELL_ARGS := --mode=tex --home-dir=aspell
# TODO : encoding, specific dictionaries

# misc:
# --tex-check-comments, --dont-tex-check-comments
#        Check TeX comments.

# --add-tex-command=<list>, --rem-tex-command=<list>
#        Add or Remove a list of TeX commands.


.PHONY: aspelli
aspelli:
	aspell  \
			$(ASPELL_ARGS) \
			-c $(NAME)


.PHONY: aspell
aspell:
	aspell list \
		   $(ASPELL_ARGS) \
		   < $(NAME) # aspell list wants piped input