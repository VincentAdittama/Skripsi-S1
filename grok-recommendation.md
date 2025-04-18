Given that your project is a Skripsi (undergraduate final project) for the Music Study Program at the Faculty of Performing Arts, Institute of Arts Indonesia Yogyakarta (ISI Yogyakarta), with the program code 91221 (PDDIKTI), I recommend a tailored approach to set up your LaTeX environment and workflow. This approach ensures efficiency, compliance with institutional requirements, and support for the specific needs of a music-related academic document. Below is a step-by-step guide based on your context and previous needs for this serious academic project.

---

### 1. Choose the Right TeX Live Scheme

- **Recommendation**: Start with the `scheme-basic` TeX Live scheme and install additional packages as needed.
- **Why**:
  - `scheme-basic` provides essential LaTeX packages like `amsmath`, `graphicx`, and `babel`, keeping your setup lightweight and manageable (especially if using a Docker container).
  - You can later use `tlmgr` (TeX Live Manager) to add specific packages required for your Skripsi, ensuring flexibility without overloading your system.

---

### 2. Select a Suitable Document Class

- **Recommendation**: Use `scrartcl` from the KOMA-Script package or the standard `article` class.
- **Why**:
  - `scrartcl` offers advanced typography and customization options, making it ideal for a professional academic paper like your Skripsi.
  - `article` is simpler and included in `scheme-basic`, suitable if you prefer a straightforward setup.
  - Since a Skripsi is typically shorter than a full thesis, these classes are more appropriate than `scrreprt` or `memoir`, which are better for longer, book-like documents.

---

### 3. Install Essential LaTeX Packages

- **Recommendation**: Install the following packages using `tlmgr`:
  - `koma-script` (for `scrartcl`)
  - `babel-indonesian` (for Indonesian language support)
  - `hyperref` (for interactive PDFs with links)
  - `biblatex` and `biber` (for bibliography management)
  - `geometry` (for precise page layout control)
  - `tikz` (for diagrams or illustrations)
  - `musixtex` or `lilypond` (for music notation, critical for your Music Study Program Skripsi)
- **Why**:
  - `koma-script` enhances document formatting.
  - `babel-indonesian` ensures proper hyphenation and formatting in Indonesian, the primary language of your Skripsi.
  - `hyperref` adds interactivity to your PDF, useful for academic submissions.
  - `biblatex` with `biber` provides flexible and modern bibliography management.
  - `geometry` allows you to meet ISI Yogyakarta’s margin requirements (if specified).
  - `tikz` is handy for creating diagrams or visual aids.
  - `musixtex` (for inline notation) or `lilypond` (for complex scores) supports music examples, which are likely central to your project.

To install, use commands like:

```bash
tlmgr install koma-script babel-indonesian hyperref biblatex biber geometry tikz musixtex
```

---

### 4. Configure LaTeX Workshop in VS Code

- **Recommendation**: Use LaTeX Workshop extension in Visual Studio Code with `latexmk` for compilation and SyncTeX for navigation.
- **Why**:
  - `latexmk` automates the compilation process, handling bibliographies and multiple runs efficiently.
  - SyncTeX lets you jump between your LaTeX source and PDF output, speeding up editing for a large document like a Skripsi.

Example VS Code settings (`settings.json`):

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-pdf",
        "-file-line-error",
        "-halt-on-error",
        "-interaction=nonstopmode",
        "%DOC%"
      ]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk",
      "tools": ["latexmk"]
    }
  ]
}
```

---

### 5. Manage Bibliographies

- **Recommendation**: Use `biblatex` with the `biber` backend.
- **Why**:
  - `biblatex` offers more customization than traditional `bibtex`, aligning with academic standards.
  - Install `biber` if not included: `tlmgr install biber`.

Example LaTeX preamble:

```latex
\usepackage[bibstyle=authoryear, backend=biber]{biblatex}
\addbibresource{references.bib}
```

---

### 6. Handle Language and Localization

- **Recommendation**: Include `babel` with the `indonesian` option.
- **Why**: Ensures correct hyphenation and date formatting for Indonesian text.

Example:

```latex
\usepackage[indonesian]{babel}
```

---

### 7. Include Music Notation

- **Recommendation**: Use `musixtex` for simple inline notation or `lilypond` for complex, standalone scores.
- **Why**:
  - As a Music Study Program student, your Skripsi may include musical examples. `musixtex` integrates well with LaTeX for short snippets, while `lilypond` excels at detailed scores.
  - Install via: `tlmgr install musixtex` or `tlmgr install lilypond`.

Example with `musixtex`:

```latex
\usepackage{musixtex}
\begin{music}
\startextract
\notes\qu c\en
\endextract
\end{music}
```

---

### 8. Ensure Compliance with ISI Yogyakarta Requirements

- **Recommendation**: Follow the guidelines from “PANDUAN UNGGAH MANDIRI UNTUK MAHASISWA ISI YOGYAKARTA 2025.pdf”:
  - **Watermarking**: Add a watermark with the ISI Yogyakarta logo and "UPA Perpustakaan ISI Yogyakarta" on all pages using tools like Adobe Acrobat or `pdftk`.
  - **File Naming**: Use the format `Nama_TahunKelulusan_FULL TEKS.pdf` (e.g., `YourName_2025_FULL TEKS.pdf`) for the full text, and similarly for other sections (e.g., `YourName_2025_BAB I.pdf`).
  - **PDF Format**: Submit in PDF with a scanned, signed approval page (lembar pengesahan).
- **Why**: These are mandatory for submission to the ISI Yogyakarta repository.

---

### 9. Version Control and Collaboration

- **Recommendation**: Use Git and host your project on GitHub.
- **Why**:
  - Tracks changes and allows reverting to earlier versions.
  - Facilitates collaboration with advisors.
  - Add a `.gitignore` to exclude temporary files (e.g., `*.aux`, `*.log`).

Example `.gitignore`:

```
*.aux
*.log
*.out
*.pdf
```

---

### 10. Automate Builds with GitHub Actions

- **Recommendation**: Set up a GitHub Action to compile your LaTeX document on each push.
- **Why**: Ensures your document compiles correctly and provides a PDF artifact for review.

Example workflow (`.github/workflows/latex.yml`):

```yaml
name: Build LaTeX Document
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: xu-cheng/latex-action@v2
        with:
          root_file: main.tex
          latexmk_use: true
      - uses: actions/upload-artifact@v3
        with:
          name: PDF
          path: main.pdf
```

---

### 11. Handle Large Files and Media

- **Recommendation**: Host large audio/video files externally (e.g., YouTube) and link them in your document using `hyperref`.
- **Why**: Keeps your PDF and repository size manageable, per ISI guidelines.

Example:

```latex
\usepackage{hyperref}
\href{https://youtube.com/yourvideo}{Link to Audio Example}
```

---

### 12. Prepare for Submission

- **Recommendation**:
  - Compile your document into a PDF with `latexmk -pdf main.tex`.
  - Add the watermark as required.
  - Split your document into required parts (full text, Chapter 1, conclusion, appendices, etc.) and name them per guidelines.
  - Upload to the repository at `http://digilib.isi.ac.id` following the steps in the ISI guide.
- **Why**: Ensures compliance with ISI Yogyakarta’s submission process.

---

### 13. Test Your Setup

- **Recommendation**: Create a sample document with Indonesian text, a bibliography, and music notation, then compile it.
- **Why**: Verifies that all packages and configurations work correctly before you invest significant effort.

Example test document:

```latex
\documentclass{scrartcl}
\usepackage[indonesian]{babel}
\usepackage{musixtex}
\usepackage{biblatex}
\addbibresource{references.bib}
\begin{document}
\section{Pendahuluan}
Ini adalah contoh dokumen Skripsi.

\begin{music}
\startextract
\notes\qu c\en
\endextract
\end{music}

\printbibliography
\end{document}
```

---

### 14. Document Your Workflow

- **Recommendation**: Write a README file detailing how to build your document, install packages, and compile it.
- **Why**: Helps you and your advisors replicate the setup.

Example README:

```
# Skripsi Project
## Build Instructions
1. Install TeX Live with `scheme-basic`.
2. Install packages: `tlmgr install koma-script babel-indonesian musixtex`.
3. Compile with `latexmk -pdf main.tex`.
```

---

### Summary

- **Start Lean**: Use `scheme-basic` and add packages as needed.
- **Document Class**: Opt for `scrartcl` or `article`.
- **Packages**: Install tools for Indonesian text, bibliographies, and music notation.
- **Automation**: Use `latexmk` and GitHub Actions for efficiency.
- **Compliance**: Follow ISI Yogyakarta’s watermarking, naming, and submission rules.
- **Testing**: Validate your setup early with a sample document.

This approach ensures your Skripsi is professionally formatted, meets institutional standards, and supports music notation effectively. If you need specific configurations or run into issues, feel free to ask for further assistance!
