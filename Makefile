TARGET = application-wittkuhn.pdf
LETTER_TARGET = cover-letter.pdf
CV_SHORT_TARGET = cv-short/cv-wittkuhn-short.pdf
CV_TARGET = cv/cv_wittkuhn.pdf

all: $(TARGET)

$(TARGET): $(LETTER_TARGET) $(CV_SHORT_TARGET) $(CV_TARGET)
	pdfunite $(LETTER_TARGET) $(CV_SHORT_TARGET) $(CV_TARGET) $(TARGET)

$(CV_SHORT_TARGET): cv-short/cv-wittkuhn-short.tex
	latexmk -pdf -cd $<

$(CV_TARGET): cv/cv_wittkuhn.tex
	latexmk -pdf -cd $<

$(LETTER_TARGET): cover-letter.tex
	latexmk -pdf $<

.PHONY: update-cv
update-cv:
	git submodule update --recursive --remote

.PHONY: clean
clean:
	git clean -x -f -e *.DS_Store -e $(TARGET)
