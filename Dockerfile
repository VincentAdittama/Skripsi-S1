FROM texlive/texlive:latest

RUN tlmgr install \
    scheme-basic \
    koma-script \
    babel-indonesian \
    hyperref \
    biblatex \
    biber \
    geometry \
    pgf \
    musixtex

WORKDIR /workdir
