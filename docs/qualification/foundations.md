# Foundation verification — 2026-10-08

Package gsel 0.0.1, Windows 11 x64, R 4.4.1, base-R-only code.

- R CMD build --no-manual: passed.
- Source archive installed successfully into the dedicated sibling isolated
  .r-library/gsel-foundation cache; normal user libraries were not modified.
- R CMD check --no-manual --no-multiarch on that archive: Status OK,
  zero errors, zero warnings and zero notes.
- tests/reference-calculations.R passed against the installed example and
  independent rational constants. No scientific API is exported.
- Archive inspection confirms developer tools, docs, website, build/cache and
  Git metadata are excluded; help, example, tests and notices are retained.

Reproduce with Rscript tools/build/qualify.R from the package root. Generated
logs and source/check/install artifacts are retained locally and not committed.
The host Rscript startup reports unavailable C.UTF-8 locale settings; child
package builds/checks use C locale and their final status is clean. The author
name uses the established ASCII spelling Soerensen to avoid corrupted help
under that locale.

These checks establish a working foundation and tiny reference arithmetic,
not estimation calibration, breeding outcomes, packed/native integration,
simulation integration or scalability. Linux/macOS checks and manual-only CI
have not run. No remote, push or website publication was performed.
