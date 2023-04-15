#!/bin/sh
Rscript -e 'rmarkdown::render("main.Rmd")'
Rscript -e 'pagedown::chrome_print("main.html", "slides-tmp.pdf")'
pdftk slides-tmp.pdf cat 3-5 output slides.pdf && rm slides-tmp.pdf
