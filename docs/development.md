# Development conventions

Local gsim 0.17.0 (ea10c33) supplies maintainer contact, GPL-3, UTF-8,
R >=3.5.0, roxygen2-generated help/namespace, no-restored-workspace RStudio
settings, installed examples and separate design/qualification documents.
Initial version 0.0.1 denotes foundations, not copied gsim release history.
COPYING retains the full GPL text under a standard R-package licence filename.
No C++17/zlib, Makevars, native registration, DLL, qgg or testthat is needed.

From the package root:

```sh
Rscript -e 'roxygen2::roxygenise()'
Rscript tools/build/qualify.R
```

roxygen2 is a developer tool only. Edit R roxygen sources and regenerate Rd;
never hand-edit generated help. The qualification script uses the running R,
retains logs/archive/check outputs in ignored build/package, installs into the
sibling .r-library/gsel-foundation cache, and checks the source tarball with
--no-manual --no-multiarch. A positional argument chooses another isolated
library. It preserves caches and normal user libraries. Tests run the installed
reference example against independent constants; no empty testthat suite.

Open the package RStudio project for devtools installation, checking and
roxygen documentation. Edit README.Rmd and Knit to update README.md. The
pkgdown website uses authoritative Markdown and Rd, with examples disabled
and output outside docs. See [website](../website/README.md) for the R console
command and automatic Pages workflow. Linux/macOS package checks and
GitHub Actions deployment have not been validated by this documentation work.
