# gsel agent instructions

Read docs/README.md and the relevant scientific contract before implementation.
These foundations export no scientific APIs. Preserve that status until a
scientifically verified milestone is authorized. gpop owns population statistics,
expectations and estimators; gsel owns selection and programme design; gsim owns
biological simulation; estimation packages own fitting and genetic evaluation.
No umbrella dependency, vendored native backend, private header or course build
dependency. Use installed public interfaces when adding justified adapters.

Run tools/build/qualify.R from the package root for source build, isolated install
and R CMD check. Keep caches and unrelated changes. Never commit build, check,
installation, log, website output or benchmark artifacts. Edit roxygen sources
and regenerate help with roxygen2; do not hand-edit generated Rd. Tests should
be small, deterministic and tied to executable behavior. Broad qualification
and benchmarks require explicit authorization.

Website sources are README/docs/man. Use website/build.py and ignored output;
never execute examples during rendering. Remotes, pushes and publication require
explicit instructions. Keep teaching notes/slides/apps in their owners.
