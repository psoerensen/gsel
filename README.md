# gsel

**Selection and Breeding Programme Design.** Initial development foundations, version 0.0.1.
The package is independently buildable and installable. Scientific interfaces
remain proposals: no scientific functions or native backends are exported.

## Installation and development

From this local checkout with R installed:

```sh
R CMD INSTALL .
Rscript tools/build/qualify.R
```

The second command builds a source archive, installs into a dedicated isolated
library outside the repository, and runs R CMD check. No remote repository,
published installer, biological download or sibling build is established.
See [development](docs/development.md).

## Reference example

```r
library(gsel)
example_file <- system.file("examples", "reference.R", package = "gsel",
                            mustWork = TRUE)
reference_env <- new.env()
sys.source(example_file, envir = reference_env)
reference_env$reference
```

This is transparent base-R arithmetic for teaching, not a proposed method API.

## Design and status

- [Documentation index](docs/README.md)
- [Scope and proposed interfaces](docs/design/scope.md)
- [Data and cooperation contracts](docs/design/data-contracts.md)
- [Reuse and ownership](docs/design/reuse.md)
- [Roadmap and teaching references](docs/design/roadmap.md)
- [Foundation verification](docs/qualification/foundations.md)
- [Local-only website](website/README.md)

No umbrella gsuite or required simulation dependency. Course notes, slides,
exercises and apps remain in the population-genetics and quantitative-genetics
teaching repositories. GPL-3; see [notices](inst/COPYRIGHTS).
