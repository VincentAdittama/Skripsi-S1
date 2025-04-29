#!/bin/bash
set -e

# Define directories and file relative to the script's location
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PARENT_DIR=$(dirname "$SCRIPT_DIR") # This should be Skripsi-S1
KLM_DIR_NAME=$(basename "$SCRIPT_DIR") # This should be tugas-KLM
BUILD_DIR="build" # Build directory is now relative to the script
TEX_FILE="tugas-1.tex"
PDF_FILE="${TEX_FILE%.tex}.pdf" # Get the PDF filename

# Output PDF name as per instructions
NOMOR_PRESENSI="74"
NAMA="Vincent Nuridzati Adittama"
OUTPUT_PDF="KLM_QUIZ_${NOMOR_PRESENSI}_${NAMA}.pdf"

# Create the build directory if it doesn't exist
mkdir -p "$BUILD_DIR"

# Compile the KLM TeX file using Docker
echo "Compiling $TEX_FILE..."
docker run --rm \
  -v "$PARENT_DIR":/workdir \
  -w "/workdir/$KLM_DIR_NAME" \
  skripsi-latex \
  latexmk -pdf -outdir="$BUILD_DIR" "$TEX_FILE"

echo "PDF generated in $BUILD_DIR directory."

# Move and rename the generated PDF to the script directory (tugas-KLM)
echo "Moving $BUILD_DIR/$PDF_FILE to $SCRIPT_DIR/$OUTPUT_PDF..."
mv "$BUILD_DIR/$PDF_FILE" "$SCRIPT_DIR/$OUTPUT_PDF"

# Optional: Clean up auxiliary files if needed (uncomment the line below)
# docker run --rm -v "$PARENT_DIR":/workdir -w "/workdir/$KLM_DIR_NAME" skripsi-latex latexmk -c -outdir="$BUILD_DIR" "$TEX_FILE"
# Optional: Remove the build directory after moving the PDF (uncomment the line below)
# rm -rf "$BUILD_DIR"

echo "KLM project build complete. PDF moved to $SCRIPT_DIR as $OUTPUT_PDF."