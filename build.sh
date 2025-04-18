#!/bin/bash
mkdir -p build
docker build -t skripsi-latex .
docker run --rm \
  -v "$(pwd)":/workdir \
  -w /workdir \
  skripsi-latex \
  latexmk -pdf -outdir=build main.tex
