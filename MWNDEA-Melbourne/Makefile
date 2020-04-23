BUILDDIR=built-pdfs

pdf:
	mkdir $(BUILDDIR) -p
	pandoc $(FILENAME).md --number-sections \
	--filter pandoc-crossref --filter pandoc-citeproc \
  --resource-path=/home/santiago/github-repos/private-repos/future-fellowship-2020/erc-proposal/figures \
	--from=markdown+tex_math_single_backslash+citations \
	--variable linkcolor:blue \
	--variable geometry:a4paper \
	--variable geometry:"top=0.5cm, bottom=1.2cm, left=0.5cm, right=0.5cm" \
	--variable fontsize=12pt \
	--output=$(BUILDDIR)/$(FILENAME).pdf \
	--pdf-engine=xelatex


html:
	mkdir $(BUILDDIR) -p
	pandoc $(FILENAME).md \
	--from=markdown+tex_math_single_backslash \
	--mathjax \
	--to=html5 \
	--output=$(BUILDDIR)/$(FILENAME).html \
	--filter pandoc-citeproc \
	--bibliography=bibliography.bib \
	--self-contained \
	--csl=https://raw.githubusercontent.com/citation-style-language/styles/master/harvard-anglia-ruskin-university.csl \
