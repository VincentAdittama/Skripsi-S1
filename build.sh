#!/bin/bash
set -e

# Create tex/ and images/ directories if they don't exist
mkdir -p tex images build

# Move .tex files (except build.sh, Dockerfile, etc.) to tex/ if not already there
for f in *.tex; do
  if [[ "$f" != "build.sh" && "$f" != "Dockerfile" && -f "$f" ]]; then
    mv "$f" tex/
  fi
done

# Change to tex directory
cd tex

# Extract variables from variables.tex
AUTHOR=$(grep '\\newcommand{\\AuthorName}' variables.tex | sed -E 's/.*\{(.*)\}/\1/')
YEAR=$(grep '\\newcommand{\\GraduationYear}' variables.tex | sed -E 's/.*\{(.*)\}/\1/')

# Create build directory inside tex/ (for latexmk output)
mkdir -p build

# Compile all required .tex files
for TEX in main.tex bab1-only.tex penutup-only.tex appendix-only.tex; do
  docker run --rm \
    -v "$(pwd)/..":/workdir \
    -w /workdir/tex \
    skripsi-latex \
    latexmk -pdf -outdir=build "$TEX"
done

# Move back to main directory
cd ..

# Make sure the build directory exists
mkdir -p build

# Copy and rename the PDFs to the main build directory
cp -f tex/build/main.pdf "build/${AUTHOR}_${YEAR}_FULL TEKS.pdf"
cp -f tex/build/bab1-only.pdf "build/${AUTHOR}_${YEAR}_BAB I.pdf"
cp -f tex/build/penutup-only.pdf "build/${AUTHOR}_${YEAR}_BAB PENUTUP.pdf"
cp -f tex/build/appendix-only.pdf "build/${AUTHOR}_${YEAR}_LAMPIRAN 1.pdf"

echo "All PDFs generated and renamed in build/ directory."
