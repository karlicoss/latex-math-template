NAME      := demo.tex
BUILD_DIR := build

ARGS = -outdir=$(BUILD_DIR) -shell-escape -pdf

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
	latexmk -outdir=$(BUILD_DIR) -c


.PHONY: wipe
wipe:
	latexmk -outdir=$(BUILD_DIR) -C


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