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


.PHONY: spellcheck
spellcheck:
	# -l: print list of errors
	# -t: laTex
	# -i: encoding
	# -d: personal dictionaly (/usr/share/hunspell)
	hunspell -l \
			 -t \
			 -i utf-8 \
			 -d 'ru_RU,en_US' $(NAME)